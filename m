From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 1/5] soc: qcom: Add suspend to idle support
Date: Fri, 10 Jun 2016 10:26:15 -0500
Message-ID: <20160610152615.GN13357@hector.attlocal.net>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-2-git-send-email-andy.gross@linaro.org>
 <CAPDyKFrAGVPkc=ycm-cQg6Y5NLx_d4xGeg8SaSiB-K5sxtv76A@mail.gmail.com>
 <20160609180902.GJ13357@hector.attlocal.net>
 <CAPDyKFp=qR=5q5O5RmtG0SQUma9BdgUrvGL9GyxdrpgiH24TeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36157 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbcFJP0S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 11:26:18 -0400
Received: by mail-oi0-f42.google.com with SMTP id p204so117214014oih.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 08:26:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=qR=5q5O5RmtG0SQUma9BdgUrvGL9GyxdrpgiH24TeQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Jun 10, 2016 at 10:47:35AM +0200, Ulf Hansson wrote:

<snip>

> >>
> >> I don't think this will work!
> >>
> >> When building a multi defconfig for ARM, you might overwrite the
> >> suspend_ops (there's only one set) as here you don't know that it's
> >> actually the QCOM platform that is running, right!?
> >>
> >> Perhaps this code actually belongs closer to the cpuidle driver?
> >
> > Hmmmm, I might have to get creative.  I originally had a DT entry for the pm,
> > but that doesn't make sense as this is purely a software construct.  The db410c
> > uses the arm cpuidle driver so I can't really hook it in there.  I'll have to
> > come up with something else.
> 
> I did a little research.
> 
> I think you should be able to use the struct cpuidle_ops->init()
> callback. This is being invoked when the arm cpuidle driver is
> initialized.
> 
> arm_idle_init()
>   ->arm_cpuidle_init()
>      ->cpuidle_ops->init()

Ah I'll see if I can get that to work.  Thanks for the pointer.

> 
> In the QCOM case, it's the spm driver that registers these cpuidle_ops
> (drivers/soc/qcom/spm.c). If you fold in the code from $subject patch
> in qcom_cpuidle_init(), that should work I think.

Only for the 32 bit processor case.  The SPM is not used for the 64 bit procs.


Regards,

Andy
