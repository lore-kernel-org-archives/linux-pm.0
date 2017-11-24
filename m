From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH v2 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Fri, 24 Nov 2017 14:19:02 +0200
Message-ID: <20171124121902.GA2403@kuha.fi.intel.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Nov 14, 2017 at 11:44:47AM +0000, Adam Thomson wrote:
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 78983e1..7c26c3d 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/power_supply.h>
>  #include <linux/proc_fs.h>
>  #include <linux/sched/clock.h>
>  #include <linux/seq_file.h>
> @@ -277,6 +278,10 @@ struct tcpm_port {
>  	u32 current_limit;
>  	u32 supply_voltage;
>  
> +	/* Used to export TA voltage and current */
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +
>  	u32 bist_request;
>  
>  	/* PD state for Vendor Defined Messages */
> @@ -1756,6 +1761,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>  	int ret = -EINVAL;
>  
>  	port->pps_data.supported = false;
> +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD;
>  
>  	/*
>  	 * Select the source PDO providing the most power while staying within
> @@ -1775,8 +1781,10 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>  			mv = pdo_min_voltage(pdo);
>  			break;
>  		case PDO_TYPE_APDO:
> -			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
> +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
>  				port->pps_data.supported = true;
> +				port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD_PPS;
> +			}
>  			continue;
>  		default:
>  			tcpm_log(port, "Invalid PDO type, ignoring");
> @@ -2248,6 +2256,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	port->try_snk_count = 0;
>  	port->supply_voltage = 0;
>  	port->current_limit = 0;
> +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_TYPE_C;

Is it OK to everybody that the type of the psy is changed like that?
Hans?!

We do have drivers that already change the type, for example
drivers/power/supply/isp1704_charger.c, but what does the user space
expect? The ABI for the power supply class was never documented I
guess.

I'm not against changing the type, but I think that we should have an
attribute file listing all supported types a psy can have if we go
forward with this. Ideally the type file would just list them as space
separated values, and show the current one with asterisk in front of
it. The output would be similar we have with some of the other files
under /sys/power, at least /sys/power/state, but that would break the
ABI.


Thanks,

-- 
heikki
