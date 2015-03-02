From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: hisilicon: add acpu driver
Date: Mon, 2 Mar 2015 19:14:07 +0800
Message-ID: <20150302111406.GA18498@leoy-linaro>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
 <1424956899-8891-2-git-send-email-leo.yan@linaro.org>
 <CAKohpokN3Ljuufv5i+TsoJRanGBVZoqEqF1wmUmCzfGbcPbUZQ@mail.gmail.com>
 <20150302105025.GA8702@leoy-linaro>
 <CAKohpok62tCenCwSRxACeWZGwotsm5sm4nTX74Bq6sAXJfZX0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33486 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbCBLON (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 06:14:13 -0500
Received: by pdjz10 with SMTP id z10so38943412pdj.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2015 03:14:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpok62tCenCwSRxACeWZGwotsm5sm4nTX74Bq6sAXJfZX0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com

On Mon, Mar 02, 2015 at 04:34:34PM +0530, Viresh Kumar wrote:
> On 2 March 2015 at 16:20, Leo Yan <leo.yan@linaro.org> wrote:
> > i'm glad to use more general method, let me give more input so that we
> > can see if can figure out a better way. ;)
> 
> And I am glad to hear that :)
> 
> > 1. From hardware design, during the initialization phase, it will
> > bind every opps with its corresponding voltage, and pass these related
> > info to power controller. So later, in kernel the cpufreq driver don't
> > need manually change the voltage, it will only change the cpu clock
> > frequency and power controller will automatically handle voltage
> > related operations. This is similar with TC's SPC implementation.
> >
> > So looks likely the cpufreq-dt driver's voltage related ops are
> > redundant for this case.
> 
> Its okay, they wouldn't harm. You don't have to specify any regulator
> in CPUs DT node and the code will not try any fancy stuff :)

If so, it's make sense to directly use cpufreq-dt driver; i will try
it firstly. Appreciate for suggestion :)

Thanks,
Leo Yan
