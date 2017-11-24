From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC PATCH v2 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Fri, 24 Nov 2017 14:05:27 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B1241@SW-EX-MBX01.diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <20171124121902.GA2403@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.166]:8413 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753560AbdKXOFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Nov 2017 09:05:34 -0500
In-Reply-To: <20171124121902.GA2403@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On 24 November 2017 12:19, Heikki Krogerus wrote:

> Hi,
> 
> On Tue, Nov 14, 2017 at 11:44:47AM +0000, Adam Thomson wrote:
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index 78983e1..7c26c3d 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/power_supply.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/sched/clock.h>
> >  #include <linux/seq_file.h>
> > @@ -277,6 +278,10 @@ struct tcpm_port {
> >  	u32 current_limit;
> >  	u32 supply_voltage;
> >
> > +	/* Used to export TA voltage and current */
> > +	struct power_supply *psy;
> > +	struct power_supply_desc psy_desc;
> > +
> >  	u32 bist_request;
> >
> >  	/* PD state for Vendor Defined Messages */
> > @@ -1756,6 +1761,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
> >  	int ret = -EINVAL;
> >
> >  	port->pps_data.supported = false;
> > +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD;
> >
> >  	/*
> >  	 * Select the source PDO providing the most power while staying within
> > @@ -1775,8 +1781,10 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
> >  			mv = pdo_min_voltage(pdo);
> >  			break;
> >  		case PDO_TYPE_APDO:
> > -			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
> > +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
> >  				port->pps_data.supported = true;
> > +				port->psy_desc.type =
> POWER_SUPPLY_TYPE_USB_PD_PPS;
> > +			}
> >  			continue;
> >  		default:
> >  			tcpm_log(port, "Invalid PDO type, ignoring");
> > @@ -2248,6 +2256,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
> >  	port->try_snk_count = 0;
> >  	port->supply_voltage = 0;
> >  	port->current_limit = 0;
> > +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_TYPE_C;
> 
> Is it OK to everybody that the type of the psy is changed like that?
> Hans?!
> 
> We do have drivers that already change the type, for example
> drivers/power/supply/isp1704_charger.c, but what does the user space
> expect? The ABI for the power supply class was never documented I
> guess.
> 

Hi Heikki,

Appreciate your time in reviewing this.

Yes, I actually saw that as an example when I considered this approach. I didn't
see anything obvious for this in the ABI documentation. Any ideas Sebastian?
What is user-space expectation for the 'type' property of a power_supply? I
assume having this dynamic is ok given existing drivers can already do something
like this, but would be good to have clarification.

> I'm not against changing the type, but I think that we should have an
> attribute file listing all supported types a psy can have if we go
> forward with this. Ideally the type file would just list them as space
> separated values, and show the current one with asterisk in front of
> it. The output would be similar we have with some of the other files
> under /sys/power, at least /sys/power/state, but that would break the
> ABI.
> 

I added this as I wanted the user to know what was connected rather than
blindly trying to set the 'online' property to enable PPS, even if the attached
source partner didn't support this. As you say, am not sure we could change the
'TYPE' property as that to my knowledge has always been a single string.

Maybe the addition of a 'SUPPORTED_TYPES' property or something similar could
close this gap (as you eluded to), at least by providing a RO list of all
supported types? Another option would be to add a type which indicates the
supply supports multiple types, and then based on this we can read another
property which does as you suggest with multiple strings and one being
highlighted? Am certainly open to discussion on this.
