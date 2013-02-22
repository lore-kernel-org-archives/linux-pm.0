From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 1/4] cpufreq: Add per policy governor-init/exit infrastructure
Date: Fri, 22 Feb 2013 03:21:51 +0100
Message-ID: <6210802.HjCYHcMl5j@vostro.rjw.lan>
References: <cover.1360568193.git.viresh.kumar@linaro.org> <3793606.bilcxohA80@vostro.rjw.lan> <CAKohpom8HiBEXE54BL72s-nWaeXzSRTrp7=MQKrJcon17T9tXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41139 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab3BVCPM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Feb 2013 21:15:12 -0500
In-Reply-To: <CAKohpom8HiBEXE54BL72s-nWaeXzSRTrp7=MQKrJcon17T9tXQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com

On Friday, February 22, 2013 07:38:12 AM Viresh Kumar wrote:
> On 22 February 2013 05:05, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, February 11, 2013 01:20:00 PM Viresh Kumar wrote:
> 
> >> This patch is inclined towards providing this infrastructure. Because we are
> >> required to allocate governor's resources dynamically now, we must do it at
> >> policy creation and end. And so got CPUFREQ_GOV_POLICY_INIT/EXIT.
> >
> > Are those new events NOPs now?
> 
> No. These are used atleast for ondemand & conservative.

They will be after the next patch, you mean? :-)

> >> +#define CPUFREQ_GOV_POLICY_INIT      4
> >> +#define CPUFREQ_GOV_POLICY_EXIT      4
> >
> > Why don't you use different values here?
> >
> > If you need only one value, one #define should be sufficient.
> 
> Naah, something happened... I got fixed this locally but couldn't
> get that into the commit somehow. EXIT should have 5 here.

Well, it appeared so from the next patch ...

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
