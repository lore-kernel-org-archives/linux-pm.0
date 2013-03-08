From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
Date: Fri, 8 Mar 2013 12:20:42 +0800
Message-ID: <CAKohpo=-_uzTi6QR4MnXPd5yAZFTcw-3ZZL-TAVY+drV-bDjNw@mail.gmail.com>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
	<Pine.LNX.4.64.1303072248560.20470@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:42786 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759621Ab3CHEUn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Mar 2013 23:20:43 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so993007obb.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Mar 2013 20:20:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1303072248560.20470@axis700.grange>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, devicetree-discuss@lists.ozlabs.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com

On 8 March 2013 05:56, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> I like generic drivers :)

Me too :)

> cpufreq-cpu0 is yet another such generic
> (cpufreq) driver. Now, comparing the functionality of the two:

Great!!

> we see, that this driver "only" switches CPU clock frequencies. Whereas
> the cpufreq-cpu0 driver also manipulates a regulator (if available)
> directly. I understand, power-saving is also an important consideration
> for big.LITTLE systems. So, I presume, you plan to implement voltage
> switching in cpufreq notifiers?

So the platform on which we are currently testing these is ARM TC2 Soc
and this switching is done by the firmware instead. And so didn't went
for regulator hookups initially.. Obviously in future regulator hookups would
find some space in this driver but not required for now.

> Now, my question is: is this (notifier)
> actually the preferred method and the cpufreq-cpu0 driver is doing it
> "wrongly?"

What notifiers are you talking about? I believe using the regulator framework
is the right way of doing this. And that would be part of this code later on.
