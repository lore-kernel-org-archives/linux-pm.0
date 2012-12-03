From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [RFC PATCH 2/7] Thermal: Create zone level APIs
Date: Mon, 3 Dec 2012 15:42:54 +0800
Message-ID: <CAJLyvQzptLcWPiJUquO2c2PegiMRt00SR+V=8kHA2wkZG4EFNQ@mail.gmail.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
	<1353149158-19102-3-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:61736 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab2LCHsC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Dec 2012 02:48:02 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so3594132ieb.6
        for <linux-pm@vger.kernel.org>; Sun, 02 Dec 2012 23:48:01 -0800 (PST)
In-Reply-To: <1353149158-19102-3-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, wni@nvidia.com, eduardo.valentin@ti.com, amit.kachhap@linaro.org, sachin.kamat@linaro.org

On 17 November 2012 18:45, Durgadoss R <durgadoss.r@intel.com> wrote:
> This patch adds a new thermal_zone structure to
> thermal.h. Also, adds zone level APIs to the thermal
> framework.
>
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |  206 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h       |   25 +++++
>  2 files changed, 231 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index e726c8b..9d386d7 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -44,19 +44,28 @@ MODULE_DESCRIPTION("Generic thermal management sysfs support");
>  MODULE_LICENSE("GPL");
>
>  static DEFINE_IDR(thermal_tz_idr);
> +static DEFINE_IDR(thermal_zone_idr);
>  static DEFINE_IDR(thermal_cdev_idr);
>  static DEFINE_IDR(thermal_sensor_idr);
>  static DEFINE_MUTEX(thermal_idr_lock);
>
>  static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_sensor_list);
> +static LIST_HEAD(thermal_zone_list);
>  static LIST_HEAD(thermal_cdev_list);
>  static LIST_HEAD(thermal_governor_list);
>
>  static DEFINE_MUTEX(thermal_list_lock);
>  static DEFINE_MUTEX(ts_list_lock);
> +static DEFINE_MUTEX(tz_list_lock);
>  static DEFINE_MUTEX(thermal_governor_lock);
>
> +#define for_each_thermal_sensor(pos) \
> +       list_for_each_entry(pos, &thermal_sensor_list, node)
> +
> +#define for_each_thermal_zone(pos) \
> +       list_for_each_entry(pos, &thermal_zone_list, node)
> +
>  static struct thermal_governor *__find_governor(const char *name)
>  {
>         struct thermal_governor *pos;
> @@ -419,15 +428,62 @@ static void thermal_zone_device_check(struct work_struct *work)
>         thermal_zone_device_update(tz);
>  }
>
> +static int get_sensor_indx(struct thermal_zone *tz, struct thermal_sensor *ts)
> +{
> +       int i, indx = -EINVAL;
> +
> +       if (!tz || !ts)
> +               return -EINVAL;
> +
> +       mutex_lock(&ts_list_lock);
> +       for (i = 0; i < tz->sensor_indx; i++) {
> +               if (tz->sensors[i] == ts) {
> +                       indx = i;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&ts_list_lock);
> +       return indx;
> +}
> +
> +static void remove_sensor_from_zone(struct thermal_zone *tz,
> +                               struct thermal_sensor *ts)
> +{
> +       int indx, j;
> +
> +       indx = get_sensor_indx(tz, ts);
> +       if (indx < 0)
> +               return;
> +
> +       sysfs_remove_link(&tz->device.kobj, kobject_name(&ts->device.kobj));
> +
> +       /* Shift the entries in the tz->sensors array */
> +       for (j = indx; j < MAX_SENSORS_PER_ZONE - 1; j++)
> +               tz->sensors[j] = tz->sensors[j + 1];
> +
> +       tz->sensor_indx--;
> +}
> +
>  /* sys I/F for thermal zone */
>
>  #define to_thermal_zone(_dev) \
>         container_of(_dev, struct thermal_zone_device, device)
>
> +#define to_zone(_dev) \
> +       container_of(_dev, struct thermal_zone, device)
> +
>  #define to_thermal_sensor(_dev) \
>         container_of(_dev, struct thermal_sensor, device)
>
>  static ssize_t
> +zone_name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct thermal_zone *tz = to_zone(dev);
> +
> +       return sprintf(buf, "%s\n", tz->name);
> +}
> +
> +static ssize_t
>  sensor_name_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         struct thermal_sensor *ts = to_thermal_sensor(dev);
> @@ -772,6 +828,8 @@ static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
>  static DEVICE_ATTR(sensor_name, 0444, sensor_name_show, NULL);
>  static DEVICE_ATTR(temp_input, 0444, sensor_temp_show, NULL);
>
> +static DEVICE_ATTR(zone_name, 0444, zone_name_show, NULL);
> +
>  /* sys I/F for cooling device */
>  #define to_cooling_device(_dev)        \
>         container_of(_dev, struct thermal_cooling_device, device)
> @@ -1557,6 +1615,146 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
>         kfree(tz->trip_hyst_attrs);
>  }
>
> +struct thermal_zone *create_thermal_zone(const char *name, void *devdata)
> +{
> +       struct thermal_zone *tz;
> +       int ret;
> +
> +       if (!name || (name && strlen(name) >= THERMAL_NAME_LENGTH))
> +               return ERR_PTR(-EINVAL);
> +
> +       tz = kzalloc(sizeof(*tz), GFP_KERNEL);
> +       if (!tz)
> +               return ERR_PTR(-ENOMEM);
> +
> +       idr_init(&tz->idr);
> +       ret = get_idr(&thermal_zone_idr, &thermal_idr_lock, &tz->id);
> +       if (ret)
> +               goto exit_free;
> +
> +       strcpy(tz->name, name);
> +       tz->devdata = devdata;
> +       tz->device.class = &thermal_class;
> +
> +       dev_set_name(&tz->device, "zone%d", tz->id);
> +       ret = device_register(&tz->device);
> +       if (ret)
> +               goto exit_idr;
> +
> +       ret = device_create_file(&tz->device, &dev_attr_zone_name);
> +       if (ret)
> +               goto exit_unregister;
> +
> +       /* Add this zone to the global list of thermal zones */
> +       mutex_lock(&tz_list_lock);
> +       list_add_tail(&tz->node, &thermal_zone_list);
> +       mutex_unlock(&tz_list_lock);
> +       return tz;
> +
> +exit_unregister:
> +       device_unregister(&tz->device);
> +exit_idr:
> +       release_idr(&thermal_zone_idr, &thermal_idr_lock, tz->id);
> +exit_free:
> +       kfree(tz);
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(create_thermal_zone);
> +
> +void remove_thermal_zone(struct thermal_zone *tz)
> +{
> +       struct thermal_zone *pos, *next;
> +       bool found = false;
> +
> +       if (!tz)
> +               return;
> +
> +       mutex_lock(&tz_list_lock);
> +
> +       list_for_each_entry_safe(pos, next, &thermal_zone_list, node) {
> +               if (pos == tz) {
> +                       list_del(&tz->node);
> +                       found = true;
> +                       break;
> +               }
> +       }
> +
> +       if (!found)
> +               goto exit;
> +
> +       device_remove_file(&tz->device, &dev_attr_zone_name);
> +
> +       release_idr(&thermal_zone_idr, &thermal_idr_lock, tz->id);
> +       idr_destroy(&tz->idr);
> +
> +       device_unregister(&tz->device);
> +       kfree(tz);
> +exit:
> +       mutex_unlock(&tz_list_lock);
> +       return;
> +}
> +EXPORT_SYMBOL(remove_thermal_zone);
> +
> +struct thermal_sensor *get_sensor_by_name(const char *name)
> +{
> +       struct thermal_sensor *pos;
> +       struct thermal_sensor *ts = NULL;
> +
> +       mutex_lock(&ts_list_lock);
> +       for_each_thermal_sensor(pos) {
> +               if (!strnicmp(pos->name, name, THERMAL_NAME_LENGTH)) {
> +                       ts = pos;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&ts_list_lock);
> +       return ts;
> +}
> +EXPORT_SYMBOL(get_sensor_by_name);
> +
> +int add_sensor_to_zone_by_name(struct thermal_zone *tz, const char *name)
> +{
> +       int ret;
> +       struct thermal_sensor *ts = get_sensor_by_name(name);
> +
> +       if (!tz || !ts)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz_list_lock);
> +
> +       /* Ensure we are not adding the same sensor again!! */
> +       ret = get_sensor_indx(tz, ts);
> +       if (ret >= 0) {
> +               ret = -EEXIST;
> +               goto exit_zone;
> +       }
> +
> +       mutex_lock(&ts_list_lock);
> +
> +       ret = sysfs_create_link(&tz->device.kobj, &ts->device.kobj,
> +                               kobject_name(&ts->device.kobj));
> +       if (ret)
> +               goto exit_sensor;
> +
> +       tz->sensors[tz->sensor_indx++] = ts;
> +
> +exit_sensor:
> +       mutex_unlock(&ts_list_lock);
> +exit_zone:
> +       mutex_unlock(&tz_list_lock);
> +       return ret;
> +}
> +EXPORT_SYMBOL(add_sensor_to_zone_by_name);
> +
> +int add_sensor_to_zone(struct thermal_zone *tz, struct thermal_sensor *ts)
> +{
> +       if (!tz || !ts)
> +               return -EINVAL;
> +
> +       return add_sensor_to_zone_by_name(tz, ts->name);
> +}
> +EXPORT_SYMBOL(add_sensor_to_zone);
> +
>  /**
>   * thermal_sensor_register - register a new thermal sensor
>   * @name:      name of the thermal sensor
> @@ -1624,6 +1822,7 @@ EXPORT_SYMBOL(thermal_sensor_register);
>  void thermal_sensor_unregister(struct thermal_sensor *ts)
>  {
>         int i;
> +       struct thermal_zone *tz;
>         struct thermal_sensor *pos, *next;
>         bool found = false;
>
> @@ -1643,6 +1842,13 @@ void thermal_sensor_unregister(struct thermal_sensor *ts)
>         if (!found)
>                 return;
>
> +       mutex_lock(&tz_list_lock);
> +
> +       for_each_thermal_zone(tz)
> +               remove_sensor_from_zone(tz, ts);
> +
> +       mutex_unlock(&tz_list_lock);
> +
>         for (i = 0; i < ts->thresholds; i++)
>                 device_remove_file(&ts->device, &ts->thresh_attrs[i].attr);
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e2f85ec..38438be 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -49,6 +49,11 @@
>  /* Default Thermal Governor: Does Linear Throttling */
>  #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
>
> +/* Maximum number of sensors, allowed in a thermal zone
> + * We will start with 5, and increase if needed.
> + */
> +#define MAX_SENSORS_PER_ZONE           5
> +
>  struct thermal_sensor;
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
> @@ -191,6 +196,21 @@ struct thermal_zone_device {
>         struct delayed_work poll_queue;
>  };
>
> +struct thermal_zone {
> +       char name[THERMAL_NAME_LENGTH];
> +       int id;
> +       void *devdata;
> +       struct thermal_zone *ops;
What is this, thermal_zone_device_ops? and how to initialize this ops?

> +       struct thermal_governor *governor;
> +       struct idr idr;
> +       struct device device;
> +       struct list_head node;
> +
> +       /* Sensor level information */
> +       int sensor_indx; /* index into 'sensors' array */
> +       struct thermal_sensor *sensors[MAX_SENSORS_PER_ZONE];
> +};
> +
>  /* Structure that holds thermal governor information */
>  struct thermal_governor {
>         char name[THERMAL_NAME_LENGTH];
> @@ -264,6 +284,11 @@ struct thermal_sensor *thermal_sensor_register(const char *,
>  void thermal_sensor_unregister(struct thermal_sensor *);
>  int enable_sensor_thresholds(struct thermal_sensor *, int);
>
> +struct thermal_zone *create_thermal_zone(const char *, void *);
> +void remove_thermal_zone(struct thermal_zone *);
> +int add_sensor_to_zone(struct thermal_zone *, struct thermal_sensor *);
> +int add_sensor_to_zone_by_name(struct thermal_zone *, const char *);
> +
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(u32 orig, enum events event);
>  #else
> --
> 1.7.9.5
>
