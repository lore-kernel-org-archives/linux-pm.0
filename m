From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scpi: fix static checker warning cdev isn't an ERR_PTR
Date: Thu, 08 Feb 2018 11:06:22 +0100
Message-ID: <4004703.WBRK2LdAuj@aspire.rjw.lan>
References: <20180122104823.GA25283@mwanda> <1516632067-9584-1-git-send-email-sudeep.holla@arm.com> <20180123024142.GA13020@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:42325 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBHKIG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Feb 2018 05:08:06 -0500
In-Reply-To: <20180123024142.GA13020@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org

On Tuesday, January 23, 2018 3:41:42 AM CET Viresh Kumar wrote:
> On 22-01-18, 14:41, Sudeep Holla wrote:
> > Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> > leads to the following static checker warning:
> > 
> > 	drivers/cpufreq/scpi-cpufreq.c:203 scpi_cpufreq_ready()
> > 	warn: 'cdev' isn't an ERR_PTR
> > 
> > of_cpufreq_cooling_register() returns NULL on error. This patch removes
> > the incorrect IS_ERR check on the returned pointer.
> > 
> > Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/scpi-cpufreq.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
