From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Disabling power management firmware decisions
Date: Thu, 19 Mar 2015 15:08:46 +0100
Message-ID: <4773622.DqM2RS9PPh@vostro.rjw.lan>
References: <550AD02E.2080507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53994 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755638AbbCSNox (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 09:44:53 -0400
In-Reply-To: <550AD02E.2080507@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

On Thursday, March 19, 2015 02:33:34 PM Daniel Lezcano wrote:
> 
> Hi,
> 
> I would like to do some experiments with the x86 platform but I am 
> facing one big issue.
> 
> When I use the rapl register to measure the energy consumption with 
> turbostat and another tool written by me. I see no differences between 
> my kernel changes while using the idlestat tool, I see big differences 
> in the idle state durations with the traces.
> 
> I remember on x86 the firmware overrides all kernel decisions to do the 
> power management. So I assume, it is possible my changes are not 
> measurable because of that.
> 
> Is there a way to tell the firmware to stop overriding the kernel 
> decisions in order to let the kernel handle idle/dvfs on its own ?

The short answer to that is no, there isn't.  It also may not be firmware,
but hardware.

Rafael

