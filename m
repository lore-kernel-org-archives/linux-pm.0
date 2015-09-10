From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] cpufreq: remove redundant CPUFREQ_INCOMPATIBLE
 notifier event
Date: Thu, 10 Sep 2015 06:09:18 +0530
Message-ID: <20150910003918.GL5266@linux>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
 <406f55ac8030043f0349b084878c9b8d04f7ad86.1438571116.git.viresh.kumar@linaro.org>
 <4897937.47p7WB7CoU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36393 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbbIJAjX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 20:39:23 -0400
Received: by padhk3 with SMTP id hk3so24973445pad.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 17:39:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4897937.47p7WB7CoU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>

On 10-09-15, 01:26, Rafael J. Wysocki wrote:
> On Monday, August 03, 2015 08:36:14 AM Viresh Kumar wrote:
> > What's being done from CPUFREQ_INCOMPATIBLE, can also be done with
> > CPUFREQ_ADJUST. There is nothing special with CPUFREQ_INCOMPATIBLE
> > notifier.
> 
> The above part of the changelog is a disaster to me. :-(
> 
> It not only doesn't explain what really goes on, but it's actively confusing.
> 
> What really happens is that the core sends CPUFREQ_INCOMPATIBLE notifications
> unconditionally right after sending the CPUFREQ_ADJUST ones, so the former is
> just redundant and it's more efficient to merge the two into one.

Undoubtedly this looks far better :)

But, isn't this series already applied some time back ?

> > Kill CPUFREQ_INCOMPATIBLE and fix its usage sites.
> > 
> > This also updates the numbering of notifier events to remove holes.
> 
> Why don't you redefine CPUFREQ_ADJUST as 1 instead?

So that there is no request with 0? Yeah that could have been done.
-- 
viresh
