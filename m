From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Mon, 30 Jun 2014 23:01:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406302255190.16842@knanqh.ubzr>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com> <CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com> <53AC42CE.2050304@arm.com> <CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com> <53AC6D31.7010709@arm.com>
 <CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com> <CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com> <alpine.LFD.2.11.1406272202220.16842@knanqh.ubzr> <CAKohpomLQcfp5OD1QB5m6JTSJPT_JF+mb=mEtGbG4RQb6gsovA@mail.gmail.com>
 <CAJuA9agDU1-wLHW4yH+2u2EB51SCCbyN+SSshZ271SBK-D=iBA@mail.gmail.com> <CAKohpom_2A0a7nm97WJ0ReocikqViyu4HJ9BdPJi4vEB4mkP-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:64146 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbaGADBt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 23:01:49 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so7737201qcz.23
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2014 20:01:48 -0700 (PDT)
In-Reply-To: <CAKohpom_2A0a7nm97WJ0ReocikqViyu4HJ9BdPJi4vEB4mkP-A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <ta.omasab@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, 30 Jun 2014, Viresh Kumar wrote:

> On 30 June 2014 14:02, Thomas Abraham <ta.omasab@gmail.com> wrote:
> > Thanks Nicolas and Viresh for your feedback. Probably, this can be
> > handled in platform specific mcpm backend driver.
> 
> This can be a generic requirement and so doing it inside MCPM core
> would be better IMO.

Let me rephrase the above.

This could become a generic requirement at which point doing it inside 
MCPM core would be better.

Let's resist overengineering. things prematurely.


Nicolas
