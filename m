From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [RFC 1/4] power_supply: Introduce charging object table
Date: Mon, 9 Mar 2015 12:26:21 +0000
Message-ID: <20ADAB092842284E95860F279283C5642EEC90C3@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48167 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbbCIM0z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 08:26:55 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Sebastian Reichel' <sre@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>


Hi,

> > +#define PSY_MAX_BAT_NAME_LEN 8
> > +#define PSY_MAX_TEMP_ZONE 6
> > +
> > +struct psy_charging_obj {
> 
> This is not just about charging data, but also about the batteries
> thermal limits, technology and full capacity, so how about
> 
> struct psy_battery_information {

Ok, Agree.
> 
> > +	char name[PSY_MAX_BAT_NAME_LEN];
> 
> char *name;
> 
> No need for arbitrary length limitation.

The length limitation is introduced to form a packed structure so that
the data can be read directly from memory without parsing.

> 
> > +	int battery_type;
> > +	int temp_max;
> > +	int temp_min;
> > +	int full_condition_soc;
> 
> Please be more verbose about the information being stored here.

Ok..Agree.
> 
> > +	int full_condition_capacity;
> > +	int full_condition_voltage;
> > +	int iterm; /* charge termination current */
> > +	/* CC/CV table for different temperature range */
> > +	int temp_mon_count; /* number of entries in temp_mon_table */
> > +	struct psy_temp_mon_table temp_mon_table[PSY_MAX_TEMP_ZONE];
> 
> No need to embed this into the struct. Just point to the array and
> remove the size limitation.

This is to make sure that the array is packed so that the data can be
read directly from memory without parsing.

-Jenny
