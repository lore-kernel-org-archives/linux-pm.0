From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC 1/4] power_supply: Introduce charging object table
Date: Fri, 06 Mar 2015 12:12:50 +0100
Message-ID: <1425640370.2197.0.camel@suse.de>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
	 <1425638007-9411-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638007-9411-2-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, jonghwa3.lee@samsung.com, myungjoo.ham@gmail.com, Pallala Ramakrishna <ramakrishna.pallala@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2015-03-06 at 16:03 +0530, Jenny TC wrote:
> Charging current (CC) and charging voltage (CV) may vary based on
> battery temperature. To support CC and CV for different temperature
> zones, defined a charging object which holds the properties related
> to battery charging.
> 
> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> ---
>  include/linux/power_supply.h |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 096dbce..7aada44 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -252,6 +252,33 @@ struct power_supply_info {
>  	int use_for_apm;
>  };
>  
> +
> +struct psy_temp_mon_table {
> +	int temp_max;
> +	int temp_min;
> +	int charging_current; /* CC */
> +	int charging_voltage; /* CV */

In which units?

> +	/* delta voltage at which charging should restart */
> +	int maint_voltage_delta;
> +};
> +
> +#define PSY_MAX_BAT_NAME_LEN 8
> +#define PSY_MAX_TEMP_ZONE 6
> +
> +struct psy_charging_obj {
> +	char name[PSY_MAX_BAT_NAME_LEN];
> +	int battery_type;
> +	int temp_max;
> +	int temp_min;
> +	int full_condition_soc;
> +	int full_condition_capacity;
> +	int full_condition_voltage;
> +	int iterm; /* charge termination current */
> +	/* CC/CV table for different temperature range */
> +	int temp_mon_count; /* number of entries in temp_mon_table */
> +	struct psy_temp_mon_table temp_mon_table[PSY_MAX_TEMP_ZONE];
> +};
> +
>  extern struct atomic_notifier_head power_supply_notifier;
>  extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);


-- 
Oliver Neukum <oneukum@suse.de>
