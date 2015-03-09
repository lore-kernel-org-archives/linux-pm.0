From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [RFC 3/4] power_supply: Introduce charger control interface
Date: Mon, 9 Mar 2015 12:47:18 +0000
Message-ID: <20ADAB092842284E95860F279283C5642EEC9149@BGSMSX104.gar.corp.intel.com>
References: <1425638007-9411-1-git-send-email-jenny.tc@intel.com>
 <1425638007-9411-4-git-send-email-jenny.tc@intel.com>
 <20150308015515.GB25160@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45579 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbbCIMrg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 08:47:36 -0400
In-Reply-To: <20150308015515.GB25160@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>

Hi,

> > +struct power_supply_charger {
> > +	int (*get_property)(struct power_supply_charger *psyc,
> > +			    enum psy_charger_control_property pspc,
> > +			    union power_supply_propval *val);
> 
> The charging framework can simply call the same get_property
> as used by sysfs. This is already done by all kind of drivers.

The idea is to separate power supply properties from power supply
charger properties. Existing power supply properties exposes a generic
property of a power supply. But the properties introduced above, is used
to control charging.  But I agree, if the charger properties are moved to
enum power_supply_property{ }, the existing set_property()/get_property()
calls can be used
 
> 
> > +	int (*set_property)(struct power_supply_charger *psyc,
> > +			    enum psy_charger_control_property pspc,
> > +			    const union power_supply_propval *val);
> 
> I guess this is needed for values, which are supposed to be
> writable by the kernel / charging framework, but non-writable
> by the sysfs. I suggest to add set_property_kernel() instead
> (and make the above properties part of enum power_supply_property)
> 

If properties are moved to enum power_supply_property {}, then it's possible
to reuse the set_property() call. property_is_writeable() can be used to block
user space  write access.


> > +};
> > +
> >  struct power_supply {
> >  	const char *name;
> >  	enum power_supply_type type;
> > @@ -200,6 +226,8 @@ struct power_supply {
> >  	void (*external_power_changed)(struct power_supply *psy);
> >  	void (*set_charged)(struct power_supply *psy);
> >
> > +	struct power_supply_charger *psy_charger;
> 
> Why is this a pointer?

This is introduced to access charger properties using power supply object.
If the properties can be accessed using existing set_property/get_property(),
then this is not really needed

-Jenny
