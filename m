Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF38C4361B
	for <linux-pm@archiver.kernel.org>; Thu, 17 Dec 2020 11:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0F23741
	for <linux-pm@archiver.kernel.org>; Thu, 17 Dec 2020 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgLQLkE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Dec 2020 06:40:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:39362 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgLQLkE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 06:40:04 -0500
IronPort-SDR: gwF42mwfUe7+aNoPFak9/3MSFPr8iKP8XwJfz0U4VmMdM47oew2FrKmpgX5Wc+3NtTF74I863E
 BmCI+a0kRPAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="193627701"
X-IronPort-AV: E=Sophos;i="5.78,426,1599548400"; 
   d="scan'208";a="193627701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 03:38:18 -0800
IronPort-SDR: rS1dboMDN0OT6i+6FVNVvoiE84tOwqhHGfp6zqCghlG+KnaMBBNBrp0aoIYQv6WEN2EnzogLgb
 stQSQoV0Yv6A==
X-IronPort-AV: E=Sophos;i="5.78,426,1599548400"; 
   d="scan'208";a="369798936"
Received: from pvelur-mobl1.amr.corp.intel.com ([10.209.179.212])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 03:38:13 -0800
Message-ID: <2b101b07aa18e06a32b26add651a3d2e009e6d18.camel@linux.intel.com>
Subject: Re: [PATCH 3/5] thermal/drivers/acpi: Use hot and critical ops
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
Date:   Thu, 17 Dec 2020 03:38:08 -0800
In-Reply-To: <c20d9077-66e8-f947-6422-c48e2f679cc5@linaro.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
         <20201210121514.25760-3-daniel.lezcano@linaro.org>
         <c20d9077-66e8-f947-6422-c48e2f679cc5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-12-17 at 07:28 +0100, Daniel Lezcano wrote:
> On 10/12/2020 13:15, Daniel Lezcano wrote:
> > The acpi driver wants to do a netlink notification in case of a hot
> > or
> > critical trip point. Implement the corresponding ops to be used for
> > the thermal zone and use them instead of the notify ops.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Is there any comment on this patch ?

Looks good to me.

Thanks,
Srinivas

> 
> > ---
> >  drivers/acpi/thermal.c | 30 ++++++++++++++----------------
> >  1 file changed, 14 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 12c0ece746f0..b5e4bc9e3282 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -677,27 +677,24 @@ static int thermal_get_trend(struct
> > thermal_zone_device *thermal,
> >         return 0;
> >  }
> >  
> > -
> > -static int thermal_notify(struct thermal_zone_device *thermal, int
> > trip,
> > -                          enum thermal_trip_type trip_type)
> > +static void acpi_thermal_zone_device_hot(struct
> > thermal_zone_device *thermal)
> >  {
> > -       u8 type = 0;
> >         struct acpi_thermal *tz = thermal->devdata;
> >  
> > -       if (trip_type == THERMAL_TRIP_CRITICAL)
> > -               type = ACPI_THERMAL_NOTIFY_CRITICAL;
> > -       else if (trip_type == THERMAL_TRIP_HOT)
> > -               type = ACPI_THERMAL_NOTIFY_HOT;
> > -       else
> > -               return 0;
> > -
> >         acpi_bus_generate_netlink_event(tz->device-
> > >pnp.device_class,
> > -                                       dev_name(&tz->device->dev),
> > type, 1);
> > +                                       dev_name(&tz->device->dev),
> > +                                       ACPI_THERMAL_NOTIFY_HOT,
> > 1);
> > +}
> >  
> > -       if (trip_type == THERMAL_TRIP_CRITICAL && nocrt)
> > -               return 1;
> > +static void acpi_thermal_zone_device_critical(struct
> > thermal_zone_device *thermal)
> > +{
> > +       struct acpi_thermal *tz = thermal->devdata;
> >  
> > -       return 0;
> > +       acpi_bus_generate_netlink_event(tz->device-
> > >pnp.device_class,
> > +                                       dev_name(&tz->device->dev),
> > +                                       ACPI_THERMAL_NOTIFY_CRITICA
> > L, 1);
> > +
> > +       thermal_zone_device_critical(thermal);
> >  }
> >  
> >  static int acpi_thermal_cooling_device_cb(struct
> > thermal_zone_device *thermal,
> > @@ -812,7 +809,8 @@ static struct thermal_zone_device_ops
> > acpi_thermal_zone_ops = {
> >         .get_trip_temp = thermal_get_trip_temp,
> >         .get_crit_temp = thermal_get_crit_temp,
> >         .get_trend = thermal_get_trend,
> > -       .notify = thermal_notify,
> > +       .hot = acpi_thermal_zone_device_hot,
> > +       .critical = acpi_thermal_zone_device_critical,
> >  };
> >  
> >  static int acpi_thermal_register_thermal_zone(struct acpi_thermal
> > *tz)
> > 
> 
> 


