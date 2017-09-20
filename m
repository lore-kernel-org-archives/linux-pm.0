From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Handle return value of kasprintf
Date: Wed, 20 Sep 2017 07:49:02 -0700
Message-ID: <20170920144902.GL30848@ubuntu>
References: <15cec6eac63ffc9f12f1d16aff913eccad670f77.1505817563.git.arvind.yadav.cs@gmail.com>
 <1505906255.2153.3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:53298 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdITOtE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 10:49:04 -0400
Received: by mail-pg0-f45.google.com with SMTP id j70so1792357pgc.10
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2017 07:49:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1505906255.2153.3.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 20-09-17, 04:17, Joe Perches wrote:
> On Wed, 2017-09-20 at 12:29 +0530, Arvind Yadav wrote:
> > kasprintf() can fail here and we must check its return value.
> []
> > diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> []
> > @@ -45,7 +45,8 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> >  
> >  	for (i = 0; i < opp_table->regulator_count; i++) {
> >  		name = kasprintf(GFP_KERNEL, "supply-%d", i);
> > -
> > +		if (!name)
> > +			return false;
> >  		/* Create per-opp directory */
> >  		d = debugfs_create_dir(name, pdentry);
> 
> Probably more sensible to avoid the kasprintf/kfree
> and just have
> 	char name[20];
> on the stack

Sure.

@Arvind: I will let you write that patch.

-- 
viresh
