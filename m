From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq
Date: Tue, 16 Jul 2013 14:30:08 +0200
Message-ID: <5436935.SN8sd9TJ88@vostro.rjw.lan>
References: <1372841395-30891-1-git-send-email-kpark3469@gmail.com> <2756026.ocYqpU9MCn@vostro.rjw.lan> <51E51660.50309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44732 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392Ab3GPMUO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Jul 2013 08:20:14 -0400
In-Reply-To: <51E51660.50309@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kpark3469@gmail.com, linux-pm@vger.kernel.org, keun-o.park@windriver.com

On Tuesday, July 16, 2013 11:46:08 AM Daniel Lezcano wrote:
> On 07/16/2013 01:44 AM, Rafael J. Wysocki wrote:
> > On Monday, July 15, 2013 04:18:58 PM Daniel Lezcano wrote:
> >> On 07/15/2013 01:26 AM, Rafael J. Wysocki wrote:
> >>> On Wednesday, July 03, 2013 05:49:55 PM kpark3469@gmail.com wrote:
> >>>> From: Sahara <keun-o.park@windriver.com>
> >>>>
> >>>> This patch adds Kconfig.arm for cpuidle drivers for ARM. And, this
> >>>> also moves calxeda, kirkwood and zynq to Kconfig.arm. Like cpufreq
> >>>> menu, "CPU Idle" menu is added to drivers/cpuidle/Kconfig.
> >>>>
> >>>> Signed-off-by: Sahara <keun-o.park@windriver.com>
> >>>
> >>> Daniel: Yes, no, maybe?
> >>
> >> Actually I picked the patch in my tree, I was waiting for the -rc1
> >> before sending the pull request.
> >>
> >> I have 3 other patches on top of it I want to send for review before
> >> sending the pull request (as you take 1PR/week).
> > 
> > OK, I'm dropping it then.
> > 
> > I'll assume you'll handle ARM-specific changes from now on, so I'm going to
> > ignore them going forward.
> 
> Ok, please ignore my previous PR, it was based on your pm-next branch
> which has this patch.
> 
> I rebased my branch adding this patch and I will send you another
> updated PR.

OK, thanks a lot!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
