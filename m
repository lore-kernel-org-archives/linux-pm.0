From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] PM / OPP: Handle return value of kasprintf
Date: Wed, 20 Sep 2017 04:17:35 -0700
Message-ID: <1505906255.2153.3.camel@perches.com>
References: <15cec6eac63ffc9f12f1d16aff913eccad670f77.1505817563.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:46909 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751848AbdITLRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 07:17:39 -0400
In-Reply-To: <15cec6eac63ffc9f12f1d16aff913eccad670f77.1505817563.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2017-09-20 at 12:29 +0530, Arvind Yadav wrote:
> kasprintf() can fail here and we must check its return value.
[]
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
[]
> @@ -45,7 +45,8 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
>  
>  	for (i = 0; i < opp_table->regulator_count; i++) {
>  		name = kasprintf(GFP_KERNEL, "supply-%d", i);
> -
> +		if (!name)
> +			return false;
>  		/* Create per-opp directory */
>  		d = debugfs_create_dir(name, pdentry);

Probably more sensible to avoid the kasprintf/kfree
and just have
	char name[20];
on the stack
