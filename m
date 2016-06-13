From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] soc: qcom: Add suspend to idle support
Date: Mon, 13 Jun 2016 18:12:11 +0200
Message-ID: <20160613161211.GG10634@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-2-git-send-email-andy.gross@linaro.org>
 <CAPDyKFrAGVPkc=ycm-cQg6Y5NLx_d4xGeg8SaSiB-K5sxtv76A@mail.gmail.com>
 <20160609180902.GJ13357@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38411 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424775AbcFMQMP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 12:12:15 -0400
Received: by mail-wm0-f46.google.com with SMTP id m124so86657178wme.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2016 09:12:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160609180902.GJ13357@hector.attlocal.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, stanimir.varbanov@linaro.org

On Thu, Jun 09, 2016 at 01:09:02PM -0500, Andy Gross wrote:
> On Thu, Jun 09, 2016 at 09:39:34AM +0200, Ulf Hansson wrote:
> > + Daniel
> > 
> > On 19 May 2016 at 07:00, Andy Gross <andy.gross@linaro.org> wrote:

[ ... ]

> > I don't think this will work!
> > 
> > When building a multi defconfig for ARM, you might overwrite the
> > suspend_ops (there's only one set) as here you don't know that it's
> > actually the QCOM platform that is running, right!?
> > 
> > Perhaps this code actually belongs closer to the cpuidle driver?
> 
> Hmmmm, I might have to get creative.  I originally had a DT entry for the pm,
> but that doesn't make sense as this is purely a software construct.  The db410c
> uses the arm cpuidle driver so I can't really hook it in there.  I'll have to
> come up with something else.

IMO, the generic ARM driver should be revisited to add support for suspend 
to idle.

