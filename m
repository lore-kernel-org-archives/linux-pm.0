From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT
Date: Wed, 20 Jul 2016 01:40:29 +0200
Message-ID: <CAJZ5v0gGfRsaAPDSMB=AKYNoGFgrf53MdibdwY7bauSp5PDpgw@mail.gmail.com>
References: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0iCouZ9xU8AOOL51RZZEsuRmY7fLLpidY+0mmoGB+R92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35034 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcGSXkb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 19:40:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so4532075wmg.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2016 16:40:30 -0700 (PDT)
In-Reply-To: <CAJZ5v0iCouZ9xU8AOOL51RZZEsuRmY7fLLpidY+0mmoGB+R92Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Jul 20, 2016 at 1:38 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jul 20, 2016 at 1:34 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> From: spandruv <spandruv@spandruv-mobl.jf.intel.com>
>>
>> The MSR MSR_HWP_INTERRUPT is valid only when CPUID.06H:EAX[8] = 1, so
>> check for feature before accessing this MSR.
>>
>> Signed-off-by: spandruv <spandruv@spandruv-mobl.jf.intel.com>
>
> Do you really want this in the S-o-b tag?

Well, it isn't a valid address even, so it can't be here.
