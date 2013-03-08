From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
Date: Fri, 8 Mar 2013 07:11:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1303080706310.24111@axis700.grange>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
 <Pine.LNX.4.64.1303072248560.20470@axis700.grange>
 <CAKohpo=-_uzTi6QR4MnXPd5yAZFTcw-3ZZL-TAVY+drV-bDjNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64972 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab3CHGLu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Mar 2013 01:11:50 -0500
In-Reply-To: <CAKohpo=-_uzTi6QR4MnXPd5yAZFTcw-3ZZL-TAVY+drV-bDjNw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, devicetree-discuss@lists.ozlabs.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com

Hi Viresh

On Fri, 8 Mar 2013, Viresh Kumar wrote:

> On 8 March 2013 05:56, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > I like generic drivers :)
> 
> Me too :)
> 
> > cpufreq-cpu0 is yet another such generic
> > (cpufreq) driver. Now, comparing the functionality of the two:
> 
> Great!!
> 
> > we see, that this driver "only" switches CPU clock frequencies. Whereas
> > the cpufreq-cpu0 driver also manipulates a regulator (if available)
> > directly. I understand, power-saving is also an important consideration
> > for big.LITTLE systems. So, I presume, you plan to implement voltage
> > switching in cpufreq notifiers?
> 
> So the platform on which we are currently testing these is ARM TC2 Soc
> and this switching is done by the firmware instead. And so didn't went
> for regulator hookups initially.. Obviously in future regulator hookups would
> find some space in this driver but not required for now.
> 
> > Now, my question is: is this (notifier)
> > actually the preferred method and the cpufreq-cpu0 driver is doing it
> > "wrongly?"
> 
> What notifiers are you talking about? I believe using the regulator framework
> is the right way of doing this. And that would be part of this code later on.

Also in your driver you're doing

		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
		...
		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

So, theoretically you could install such notifiers to adjust CPU voltages 
(using regulators too). But adding regulator calls directly to the driver 
would make it consistent with cpufreq-cpu0.c, so, if this doesn't violate 
any concepts, I think, it would be good to add those when suitable systems 
appear.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
