From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: spurious bL cpufreq driver messages
Date: Wed, 22 May 2013 12:54:18 +0200
Message-ID: <2544320.us1o8zUn7V@vostro.rjw.lan>
References: <519686BC.3090101@gmail.com> <11917612.jOVuLqOMKF@vostro.rjw.lan> <CAKohpokkMvEhotcow8qfCGP0SxNfRsxw7swo-ZFbTSKE-F8Xtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45249 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab3EVKpd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 May 2013 06:45:33 -0400
In-Reply-To: <CAKohpokkMvEhotcow8qfCGP0SxNfRsxw7swo-ZFbTSKE-F8Xtw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On Wednesday, May 22, 2013 06:44:20 AM Viresh Kumar wrote:
> On 22 May 2013 05:15, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, May 20, 2013 10:06:49 AM Viresh Kumar wrote:
> >> On 19 May 2013 01:21, Rob Herring <robherring2@gmail.com> wrote:
> >> > No, it still registers the bL driver. The problem is not that DT data
> >> > is missing, but it is present on a single cluster system.
> >>
> >> I misread your mail.. I got the problem now.. Below should fix your
> >> issue (It is rebased on the patch I pointed to you earlier):
> >>
> >> Attached too for testing as gmail copy-paste will break it.
> >>
> >> @Rafael: Once Rob gives his Tested-by, please queue it for 3.10-rcs
> >>
> >> ------------x-----------------x-----------------
> >>
> >> From: Viresh Kumar <viresh.kumar@linaro.org>
> >> Date: Mon, 20 May 2013 09:57:17 +0530
> >> Subject: [PATCH] cpufreq: arm_big_little_dt: Instantiate as platform_driver
> >>
> >> As multiplatform build is being adopted by more and more ARM platforms, initcall
> >> function should be used very carefully. For example, when both arm_big_little_dt
> >> and cpufreq-cpu0 drivers are compiled in, arm_big_little_dt driver may try to
> >> register even if we had platform device for cpufreq-cpu0 registered.
> >>
> >> To eliminate this undesired the effect, the patch changes arm_big_little_dt
> >> driver to have it instantiated as a platform_driver. Then it will only run on
> >> platforms that create the platform_device "arm-bL-cpufreq-dt".
> >>
> >> Reported-by: Rob Herring <robherring2@gmail.com>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > The patch (from the attachment) didn't apply for me.  Please check the
> > bleeding-edge branch.
> 
> Have you tried applying this before it (As written in my last mail)?

No and I'm not sure which mail you're referring to.  There's been quite
a number of them recently. :-)

> https://groups.google.com/forum/?fromgroups#!topic/linux.kernel/XJF-82rad4o
>
> Above is also required fix for 3.10-rc3

OK, that worked.

Please check the bleeding-edge branch now and see if anything for-3.10-rc is
still missing.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
