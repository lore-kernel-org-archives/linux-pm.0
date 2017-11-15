From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: imx: remove cooling device
Date: Wed, 15 Nov 2017 10:30:32 +0530
Message-ID: <20171115050032.GH3257@vireshk-i7>
References: <20171114134829.1354-1-bst@pengutronix.de>
 <20171115045626.GF3257@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:47267 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdKOFAe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 00:00:34 -0500
Received: by mail-pg0-f68.google.com with SMTP id o7so17153906pgc.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2017 21:00:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171115045626.GF3257@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>, shawnguo@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel@pengutronix.de

On 15-11-17, 10:26, Viresh Kumar wrote:
> + Shawn
> 
> On 14-11-17, 14:48, Bastian Stender wrote:
> > The cooling device should not be part of the i.MX thermal code but
> > rather in the i.MX cpufreq driver. So remove it here.
> > 
> > Signed-off-by: Bastian Stender <bst@pengutronix.de>
> 
> Shouldn't the two patches you sent be part of a series? What if one gets applied
> before the other? For example if the cpufreq patch gets applied before this one,
> then the kernel would break somewhere as two drivers would be adding the
> cpu-cooling device :)

Actually, we may really want to have a single patch for this. So I would suggest
that we merge both the patches.

-- 
viresh
