From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/2] sched: idle: Encapsulate the code to compile it out
Date: Thu, 01 May 2014 00:56:41 +0200
Message-ID: <2735426.75qSjG3M6Y@vostro.rjw.lan>
References: <1398859263-7632-1-git-send-email-daniel.lezcano@linaro.org> <2783362.8r7SvVhudq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55822 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1945980AbaD3WkM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 18:40:12 -0400
In-Reply-To: <2783362.8r7SvVhudq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, mingo@elte.hu, amit.kucheria@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Thursday, May 01, 2014 12:47:25 AM Rafael J. Wysocki wrote:
> On Wednesday, April 30, 2014 02:01:02 PM Daniel Lezcano wrote:
> > Encapsulate the large portion of cpuidle_idle_call inside another
> > function so when CONFIG_CPU_IDLE=n, the code will be compiled out.
> > Also that is benefitial for the clarity of the code as it removes
> > a nested indentation level.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Well, this conflicts with
> 
> https://patchwork.kernel.org/patch/4071541/
> 
> which you haven't commented on and I still want cpuidle_select() to be able to
> return negative values because of
> 
> https://patchwork.kernel.org/patch/4089631/
> 
> (and I have one more patch on top of these two that requires this).

Moreover (along the lines of Nico said) after https://patchwork.kernel.org/patch/4071541/
we actually don't need the #ifdef CONFIG_CPU_IDLE in your patch, because cpuidle_select()
for CONFIG_CPU_IDLE unset is a static inline returning a negative number and the compiler
should optimize out the blocks that depend on it being non-negative.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
