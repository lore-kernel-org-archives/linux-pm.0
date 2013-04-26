From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: Can't set policy
Date: Fri, 26 Apr 2013 17:21:04 -0400
Message-ID: <517AEFC0.2010301@ti.com>
References: <1367008557-12443-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1367008557-12443-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

Hello Srinivas,

On 26-04-2013 16:35, Srinivas Pandruvada wrote:
> Setting policy results in invalid value error.
> 	>echo "step_wise" > policy
> 	>echo: write error: Invalid argument
>
> Need clean up of the buffer which "echo" may add based on the
> arguments, before comparing aganist list of governor names.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/thermal/thermal_core.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 4cdc3e3..ed6904f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -696,16 +696,27 @@ static ssize_t
>   policy_store(struct device *dev, struct device_attribute *attr,
>   		    const char *buf, size_t count)
>   {
> -	int ret = -EINVAL;
> +	int ret;
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
>   	struct thermal_governor *gov;
> +	char str_gov[THERMAL_NAME_LENGTH];
> +	char format[6]; /* enough for 3 digit format width */
> +
> +	ret = snprintf(format, sizeof(format), "%%%ds",
> +					THERMAL_NAME_LENGTH - 1);
> +	if (ret < 0)
> +		return ret;
> +	ret = sscanf(buf, format, str_gov);
> +	if (ret <= 0)
> +		return -EINVAL;


Is this due to trainling \n? Why not using sysfs_streq()? I believe it 
is better approach. Can you please check if the following solves the issue?

https://gitorious.org/thermal-framework/thermal-framework/commit/810a33a629b40adfa92a164883281bbdfad80516

commit 810a33a629b40adfa92a164883281bbdfad80516
Author: Eduardo Valentin <eduardo.valentin@ti.com>
Date:   Fri Apr 26 17:12:30 2013 -0400

     thermal: better string treatment while finding governors

     To avoid returning error value just because of trailing
     \n, this patch changes the function to find governors
     by name to use sysfs_streq().

     Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f36cd44..08ea62c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -58,7 +58,7 @@ static struct thermal_governor *__find_governor(const 
char *name)
         struct thermal_governor *pos;

         list_for_each_entry(pos, &thermal_governor_list, governor_list)
-               if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
+               if (sysfs_streq(name, pos->name))
                         return pos;

         return NULL;

>
>   	mutex_lock(&thermal_governor_lock);
>
> -	gov = __find_governor(buf);
> -	if (!gov)
> +	gov = __find_governor(str_gov);
> +	if (!gov) {
> +		ret = -EINVAL;
>   		goto exit;
> -
> +	}
>   	tz->governor = gov;
>   	ret = count;
>
>

