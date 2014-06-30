From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Mon, 30 Jun 2014 14:03:22 +0530
Message-ID: <CAKohpom_2A0a7nm97WJ0ReocikqViyu4HJ9BdPJi4vEB4mkP-A@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
	<53AC42CE.2050304@arm.com>
	<CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
	<53AC6D31.7010709@arm.com>
	<CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com>
	<CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
	<alpine.LFD.2.11.1406272202220.16842@knanqh.ubzr>
	<CAKohpomLQcfp5OD1QB5m6JTSJPT_JF+mb=mEtGbG4RQb6gsovA@mail.gmail.com>
	<CAJuA9agDU1-wLHW4yH+2u2EB51SCCbyN+SSshZ271SBK-D=iBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42613 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbaF3IdX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 04:33:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id va2so8467525obc.33
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2014 01:33:22 -0700 (PDT)
In-Reply-To: <CAJuA9agDU1-wLHW4yH+2u2EB51SCCbyN+SSshZ271SBK-D=iBA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 30 June 2014 14:02, Thomas Abraham <ta.omasab@gmail.com> wrote:
> Thanks Nicolas and Viresh for your feedback. Probably, this can be
> handled in platform specific mcpm backend driver.

This can be a generic requirement and so doing it inside MCPM core
would be better IMO.

But the control should be there with backend driver.
