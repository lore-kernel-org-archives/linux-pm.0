From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH 5/6] intel_idle: Add ->enter_freeze callbacks
Date: Thu, 05 Mar 2015 07:50:26 +0800
Message-ID: <54F79A42.9070801@linux.intel.com>
References: <8292243.ibkmfVtXac@vostro.rjw.lan> <2407992.WHaFxrNaoa@vostro.rjw.lan> <20150212132643.GY23123@twins.programming.kicks-ass.net> <25445086.IBiaGBbm1j@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60220 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbbCDXul (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Mar 2015 18:50:41 -0500
In-Reply-To: <25445086.IBiaGBbm1j@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>

On 2015/2/13 0:24, Rafael J. Wysocki wrote:
> On Thursday, February 12, 2015 02:26:43 PM Peter Zijlstra wrote:
>>
>> Why bother with enter_freeze() for any but the deepest state (C6 in this
>> case)?
> 
> User space may disable the deepest one (and any of them in general) via sysfs
> and there's no good reason to ignore its choice in this particular case while
> we're honoring it otherwise.
> 
> So the logic is basically "find the deepest one which isn't disabled" and
> setting the pointers costs us nothing really.
> 

If the user has chance to disable C6 via /sys, that means c6 works?
Shouldn't we ignore user space setting during freeze? Otherwise, we will
lost S0ix?

Thanks,
-Aubrey

