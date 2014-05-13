From: "edubezval@gmail.com" <edubezval@gmail.com>
Subject: Re: [RFC PATCH 1/5] thermal: let governors have private data for each
 thermal zone
Date: Tue, 13 May 2014 11:31:08 -0300
Message-ID: <CAC-25o_gfoXQ5AaeF=huDPFP5F9hoR9Rjjxctv7+kj=aaDjr2Q@mail.gmail.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
	<1399377998-14870-2-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:44773 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933656AbaEMObJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 May 2014 10:31:09 -0400
Received: by mail-ve0-f182.google.com with SMTP id sa20so547174veb.27
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2014 07:31:08 -0700 (PDT)
In-Reply-To: <1399377998-14870-2-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Punit Agrawal <Punit.Agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>

Hello Javi,

Thanks for your patch. Find some comment inline.

On Tue, May 06, 2014 at 01:06:34PM +0100, Javi Merino wrote:
> A governor may need to store its current state between calls to
> throttle().  That state depends on the thermal zone, so store it as
> private data in struct thermal_zone_device.
>
> The governors may have two new ops: bind_to_tz() and unbind_from_tz().
> When provided, these functions let governors do some initialization
> and teardown when they are bound/unbound to a tz and possibly store that
> information in the governor_data field of the struct
> thermal_zone_device.


Overall the idea is fine to me, although so far we have no case of such
need in the current governors. I will have a look on your proposed
governor to check futher on this API.

>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/thermal/thermal_core.c |   67 +++++++++++++++++++++++++++++++++++-----
>  include/linux/thermal.h        |    3 ++
>  2 files changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 71b0ec0c370d..ac8e5990a63e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -72,6 +72,45 @@ static struct thermal_governor *__find_governor(const char *name)
>   return NULL;
>  }
>
> +/**
> + * thermal_set_governor() - Switch to another governor
> + * @tz: a valid pointer to a struct thermal_zone_device
> + * @new_gov: pointer to the new governor
> + *
> + * Change the governor of thermal zone @tz.
> + *
> + * Returns 0 on success, an error if the new governor's bind_to_tz() failed.
> + */
> +static int thermal_set_governor(struct thermal_zone_device *tz,
> + struct thermal_governor *new_gov)
> +{
> + int ret = 0;
> +
> + if (tz->governor && tz->governor->unbind_from_tz)
> + tz->governor->unbind_from_tz(tz);
> +
> + if (new_gov && new_gov->bind_to_tz) {
> + ret = new_gov->bind_to_tz(tz);
> + if (ret) {
> + /* Try to register the old governor again */

I suggest to state in the Documentation that a governor may be called
to bind and unbind to same thermal zone several times, as per above code.

> + if (tz->governor && tz->governor->bind_to_tz) {
> + if (tz->governor->bind_to_tz(tz))
> + /*
> + * The new governor failed to register
> + * and the previous one failed as well
> + */

I suggest having a dev_warn here to notify that a zone is now orphan due to
switching from one governor to another.

> + tz->governor = NULL;
> + }
> +
> + return ret;
> + }
> + }
> +
> + tz->governor = new_gov;
> +
> + return ret;
> +}
> +
>  int thermal_register_governor(struct thermal_governor *governor)
>  {
>   int err;
> @@ -104,8 +143,12 @@ int thermal_register_governor(struct thermal_governor *governor)
>
>   name = pos->tzp->governor_name;
>
> - if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
> - pos->governor = governor;
> + if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
> + int ret = thermal_set_governor(pos, governor);

nip: add a blank line between declarations and first statement.

> + if (ret)
> + pr_warn("Failed to set governor %s for zone %d: %d\n",
> + governor->name, pos->id, ret);

dev_* family of logging functions is preferred in this file.

> + }
>   }
>
>   mutex_unlock(&thermal_list_lock);
> @@ -131,7 +174,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
>   list_for_each_entry(pos, &thermal_tz_list, node) {
>   if (!strnicmp(pos->governor->name, governor->name,
>   THERMAL_NAME_LENGTH))
> - pos->governor = NULL;
> + thermal_set_governor(pos, NULL);
>   }
>
>   mutex_unlock(&thermal_list_lock);
> @@ -756,8 +799,9 @@ policy_store(struct device *dev, struct device_attribute *attr,
>   if (!gov)
>   goto exit;
>
> - tz->governor = gov;
> - ret = count;
> + ret = thermal_set_governor(tz, gov);
> + if (!ret)
> + ret = count;
>
>  exit:
>   mutex_unlock(&thermal_governor_lock);
> @@ -1452,6 +1496,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>   int result;
>   int count;
>   int passive = 0;
> + struct thermal_governor *governor;
>
>   if (type && strlen(type) >= THERMAL_NAME_LENGTH)
>   return ERR_PTR(-EINVAL);
> @@ -1542,9 +1587,15 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>   mutex_lock(&thermal_governor_lock);
>
>   if (tz->tzp)
> - tz->governor = __find_governor(tz->tzp->governor_name);
> + governor = __find_governor(tz->tzp->governor_name);
>   else
> - tz->governor = def_governor;
> + governor = def_governor;
> +
> + result = thermal_set_governor(tz, governor);
> + if (result) {
> + mutex_unlock(&thermal_governor_lock);
> + goto unregister;
> + }
>
>   mutex_unlock(&thermal_governor_lock);
>
> @@ -1634,7 +1685,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   device_remove_file(&tz->device, &dev_attr_mode);
>   device_remove_file(&tz->device, &dev_attr_policy);
>   remove_trip_attrs(tz);
> - tz->governor = NULL;
> + thermal_set_governor(tz, NULL);
>
>   thermal_remove_hwmon_sysfs(tz);
>   release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f7e11c7ea7d9..baac212f815e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -177,6 +177,7 @@ struct thermal_zone_device {
>   struct thermal_zone_device_ops *ops;
>   const struct thermal_zone_params *tzp;
>   struct thermal_governor *governor;
> + void *governor_data;

Please document this entry.

>   struct list_head thermal_instances;
>   struct idr idr;
>   struct mutex lock; /* protect thermal_instances list */
> @@ -187,6 +188,8 @@ struct thermal_zone_device {
>  /* Structure that holds thermal governor information */
>  struct thermal_governor {
>   char name[THERMAL_NAME_LENGTH];
> + int (*bind_to_tz)(struct thermal_zone_device *tz);
> + void (*unbind_from_tz)(struct thermal_zone_device *tz);

a governor cannot prevent unbinding?

Please, document the proposed operations.

>   int (*throttle)(struct thermal_zone_device *tz, int trip);
>   struct list_head governor_list;
>  };
> --
> 1.7.9.5
>
>


I request that you update Documentation/thermal/sysfs-api.txt too.

BR,

Eduardo Valentin,
