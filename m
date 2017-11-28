From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4.4] PM / OPP: Add missing of_node_put(np)
Date: Tue, 28 Nov 2017 14:51:10 +0530
Message-ID: <20171128092110.GF11413@vireshk-i7>
References: <3b71eca9ceb96a3525f4bb08bd1225536d691638.1511851763.git.viresh.kumar@linaro.org>
 <20171128084322.GG9413@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35956 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbdK1JVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Nov 2017 04:21:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id i15so18695666pfa.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2017 01:21:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171128084322.GG9413@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org

On 28-11-17, 09:43, Greg KH wrote:
> On Tue, Nov 28, 2017 at 12:20:41PM +0530, Viresh Kumar wrote:
> > From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> > 
> > commit 7978db344719dab1e56d05e6fc04aaaddcde0a5e upstream.
> > 
> > The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
> > doesn't drop the reference to "np" on errors. Fix that.
> > 
> > Fixes: 274659029c9d (PM / OPP: Add support to parse "operating-points-v2" bindings)
> > Cc: 4.4 <stable@vger.kernel.org> # 4.4
> > Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> > [ VK: Improved commit log. ]
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/opp/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index b8e76f75073b..0b4190a1efaa 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -1199,6 +1199,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
> >  		if (ret) {
> >  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
> >  				ret);
> > ++			of_node_put(np);
> 
> I don't think you test-built this patch :(

I actually compile tested the 4.9 patch and found the function to be
exactly same in 4.4 branch and skipped it being lazy. And the laziness
always proves that it was a bad decision to skip compiling it :(

Sorry for the ++ crap (It took me several minutes to see how your
committed change is different from what I have sent) :(

-- 
viresh
