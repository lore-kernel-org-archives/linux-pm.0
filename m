From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/8] arm_big_little: free OPP table created during ->init()
Date: Mon, 01 Dec 2014 23:37:25 +0100
Message-ID: <2087619.jKJQDeFADg@vostro.rjw.lan>
References: <cover.1416910766.git.viresh.kumar@linaro.org> <b5fca3025ec6411bb134306059c119b6b58f5ee2.1416910766.git.viresh.kumar@linaro.org> <CAKohpom2tLb6Krq94xsU9ra22ErNV=j6f5QCoR3ctaRj43=Jcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52272 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932476AbaLAWQC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 17:16:02 -0500
In-Reply-To: <CAKohpom2tLb6Krq94xsU9ra22ErNV=j6f5QCoR3ctaRj43=Jcw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On Monday, December 01, 2014 12:41:59 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> On 25 November 2014 at 16:04, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > OPP layer now supports freeing of OPPs and we should free them once they aren't
> > useful anymore.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/arm_big_little.c    | 7 ++++++-
> >  drivers/cpufreq/arm_big_little.h    | 5 ++++-
> >  drivers/cpufreq/arm_big_little_dt.c | 1 +
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> Looks like you missed applying this one from this series ?

I overlooked this one due to a numbering conflict.  Applied now.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
