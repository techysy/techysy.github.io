---
name: "strava-parser"
description: "Parse Strava data including athlete IDs, activity IDs, and avatar URLs from text or URLs. Invoke when user provides Strava links or needs to extract Strava data."
---

# Strava Parser

This skill helps parse and extract Strava-related data from user input.

## Capabilities

1. **Athlete ID Extraction**
   - From athlete URL: `https://www.strava.com/athletes/122968010` → `122968010`
   - From avatar URL: `https://dgalywyr863hv.cloudfront.net/pictures/athletes/122968010/...` → `122968010`

2. **Activity ID Extraction**
   - From activity URL: `https://www.strava.com/activities/18777123822` → `18777123822`

3. **Avatar URL Recognition**
   - Pattern: `https://dgalywyr863hv.cloudfront.net/pictures/athletes/{athleteId}/...`
   - Default avatar: `https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-...`

## Usage Examples

### Example 1: Extract Athlete ID
```
Input: https://www.strava.com/athletes/122968010
Output: { athleteId: 122968010 }
```

### Example 2: Extract Activity ID
```
Input: https://www.strava.com/activities/18777123822
Output: { activityId: 18777123822 }
```

### Example 3: Extract Multiple Data
```
Input: 
  https://www.strava.com/athletes/122968010
  https://www.strava.com/activities/18777123822
  https://dgalywyr863hv.cloudfront.net/pictures/athletes/122968010/28902961/1/large.jpg

Output:
  {
    athleteId: 122968010,
    activityId: 18777123822,
    avatar: 'https://dgalywyr863hv.cloudfront.net/pictures/athletes/122968010/28902961/1/large.jpg'
  }
```

## Data Format for tianfu-itt.html

### Rider Data
```javascript
{ name: 'Athlete Name', stravaId: 122968010, avatar: 'https://...', female: false }
```

### Activity Data
```javascript
{ 
  stravaId: 122968010, 
  activityId: 18777123822, 
  time: '2:32:10', 
  speed: 38.0, 
  heart: 174, 
  power: 0, 
  date: '2026年6月4日', 
  remark: '备注', 
  qz: false, 
  weight: 0, 
  heightFront: 0, 
  heightBack: 0, 
  groupId: null, 
  itt: true 
}
```

### Group Data
```javascript
{ groupId: '0001', name: '队伍名称', members: [122968010, 132340309] }
```

## Regex Patterns

```javascript
// Athlete ID from URL
const athleteUrlPattern = /strava\.com\/athletes\/(\d+)/;

// Activity ID from URL
const activityUrlPattern = /strava\.com\/activities\/(\d+)/;

// Athlete ID from avatar URL
const avatarPattern = /athletes\/(\d+)\//;

// Default avatar URL
const defaultAvatarPattern = /d3nn82uaxijpm6\.cloudfront\.net\/assets\/avatar\/athlete\/large/;
```

## Notes

- All Strava IDs are numeric
- Avatar URLs contain the athlete ID in the path
- Activity URLs contain the activity ID
- Use `itt: true` for solo ITT rides, `itt: false` for group rides
- Use `groupId: null` for solo rides, `groupId: '0001'` for group rides
