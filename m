From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Allow inactive opp_device to be present in dev
 list
Date: Tue, 29 Nov 2016 09:25:31 +0530
Message-ID: <20161129035531.GC3288@vireshk-i7>
References: <2fe61813c867c173ddfcb0b9cabc00a65997a935.1480056714.git.viresh.kumar@linaro.org>
 <20161129024647.GY6095@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36237 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbcK2Dzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 22:55:35 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so64126161pgc.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 19:55:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161129024647.GY6095@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 28-11-16, 18:46, Stephen Boyd wrote:
> That's a lot of lines for something that we want to backport to
> stable kernels!

Hmm, I agree.

> The whole dev_list design seems fairly broken to me. Another
> solution would be to iterate the cpumask in reverse, but there
> doesn't seem to be a construct for that and adding one is
> probably not worth the effort.
> 
> Adding yet another member to the structure and doing accounting
> in different places seems to be papering over the problem as
> well. Now we want to have "inactive" devices in the list? That
> seems like a problem for cpufreq to solve. It can decide to not
> call OPP APIs when the cpu device isn't actually physically
> removed if it wants to.
> 
> It also exposes the OPP API's strong reliance on struct device
> for everything. Really we shouldn't be storing device pointers in
> the OPP core at all because we're not treating them like the
> reference counted objects they are. The dev_list should go
> probably go away and be replaced with some sort of counter. It
> would also be nice if struct device had a pointer to the OPP
> table(s) for a device so the lookup is direct.

If the struct device gets a pointer to the opp-table, then yes we can kill the
dev-list completely. I will work on cleaning up OPP core a bit later on.

> BTW, _dev_pm_opp_remove_table() calls _find_opp_dev() twice, once
> to find the opp_table for a device and then to find the
> opp_device inside the table that was used to match up the table
> in the first place. Madness!
> 
> Anyway, rant over, how about handing out the opp table pointer to
> the caller so they can pass it back in when they call the put
> side? That should fix the same problem if I understand correctly.

Yes, that can be a solution for the time being.

> We should think about changing the API further so that callers
> have to "get" the OPP table cookie for their device and then pass
> that pointer to the dev_pm_*_set() APIs instead of passing a
> struct device pointer. That would save lots of cycles searching
> for something we already had.

Hmm, we need to do some cleanup soon I believe. Also note that we want to kill
the RCU thing :)

> -static inline void dev_pm_opp_put_regulator(struct device *dev) {}
> +static inline void dev_pm_opp_put_regulator(struct opp_table *opp_table) {}

We need to modify few more things as well. I will send a patch for that soon.

-- 
viresh
