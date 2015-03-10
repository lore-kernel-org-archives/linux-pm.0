From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [RFC 4/4] charger-manager: Enable psy based charge control
Date: Tue, 10 Mar 2015 05:21:29 +0000
Message-ID: <20ADAB092842284E95860F279283C5642EECB1F5@BGSMSX104.gar.corp.intel.com>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-5-git-send-email-jenny.tc@intel.com>
 <20150308021409.GC25160@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44249 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbbCJFVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 01:21:53 -0400
In-Reply-To: <20150308021409.GC25160@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>

Hi,
 
> On Fri, Mar 06, 2015 at 04:03:27PM +0530, Jenny TC wrote:
> > At present charger manager support only regulator based charging
> > control. But most of the charger drivers are registered with power
> > supply subsystem. This patch adds support for power supply based
> > charging control along with the regulator based control. With the
> > patch, charging control can be done either using power supply
> > interface or with regulator interface. The charging is setup
> > based on battery parameters received through the battery info
> > handlers.
> 
> [...]
> 
> (so far I only skipped over the patch)

Appreciate if you could review entire patch. I will submit next patch set
addressing all your comments.

> [...]
> 
> > @@ -1704,6 +1968,10 @@ static int charger_manager_probe(struct
> platform_device *pdev)
> >  		strncpy(cm->psy_name_buf, desc->psy_name, PSY_NAME_MAX);
> >  	cm->charger_psy.name = cm->psy_name_buf;
> >
> > +	if (!power_supply_get_property(fuel_gauge,
> POWER_SUPPLY_PROP_MODEL_NAME,
> > +						&val))
> > +		cm->battery_info = psy_get_battery_info(val.strval);
> > +
> >  	/* Allocate for psy properties because they may vary */
> >  	cm->charger_psy.properties = devm_kzalloc(&pdev->dev,
> >  				sizeof(enum power_supply_property)
> 
> We are currently splitting battery data from fuel gauge data, so
> acquiring the battery using the fuel gauge's MODEL_NAME is not very
> nice.


Will enhance struct charger_desc{ ..} to support list of battery model name
supported. This can be used to query battery_info using psy_get_battery_info()

-Jenny
