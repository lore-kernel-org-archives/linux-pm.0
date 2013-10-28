From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/3] charger-manager : Add default battery temperature
 checking funtion.
Date: Sun, 27 Oct 2013 23:31:12 -0700
Message-ID: <20131028063112.GB31266@teo>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
 <1382669253-23629-3-git-send-email-jonghwa3.lee@samsung.com>
 <20131025234436.GC13859@teo>
 <526DCB4A.5010009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47939 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3J1GbP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 02:31:15 -0400
Received: by mail-pb0-f51.google.com with SMTP id wz7so5999339pbc.24
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2013 23:31:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526DCB4A.5010009@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On Mon, Oct 28, 2013 at 11:26:18AM +0900, jonghwa3.lee@samsung.com wrote:
> >> During the charger manager driver's probing time, it can't succeed
> >> if there's no pre-defined .temperature_out_of_range callback function.
> >> But if fuel gauge supports battery temperature measurement, we
> >> can use it directly. That's what cm_default_get_temp() function does.
> >>
> >> With flag measure_batter_temp ON, we normally use cm_default_get_temp()
> >> for .temperature_out_of_range callback funtion.
> >> The TEMP_AMBIENT property is only used for pre-defined one.
> >>
> >> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> >> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> >> ---
> > ...
> >> +static int cm_default_get_temp(struct charger_manager *cm)
> >> +{
> >> +	struct charger_desc *desc = cm->desc;
> >> +	union power_supply_propval val;
> >> +	static int temp_alert_min = 0;
> >
> > No. Never.
> 
> Can I assume that you worried about initialization of a variable which would be
> used to hold minimum value to zero not INT_MAX or something big?

Nah, it's just any static variable inside a function is a big no-no. :)
With a very rare exceptions (mostly boot/arch code, which is not the case
here).

Basically, if you have to use static variables inside a function, it means
that you just broke device-driver separation.

Thanks,

Anton
