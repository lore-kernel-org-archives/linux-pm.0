From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Generic governors support
Date: Thu, 17 Nov 2016 22:06:41 +0100
Message-ID: <CAJZ5v0grUpg3EcXJgbwXC5xeMkPTbH0orrn5T7T5ye-xFO0JHg@mail.gmail.com>
References: <000301d240f7$d86604b0$89320e10$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35769 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbcKQVGn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 16:06:43 -0500
In-Reply-To: <000301d240f7$d86604b0$89320e10$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Nov 17, 2016 at 6:27 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2016.11.15 18:35 Rafael J. Wysocki wrote:
>
>> -> v2:
>> Notice that intel_cpufreq_target() generally can be called on a CPU
>> different from the target one, so it needs to ensure that the right
>> MSR will be written, so update the code accordingly.  This makes
>> the performance and powersave governors work with this driver as
>> expected (at least).
>
> With V2 I did the exact same tests with the ondemand, powersave,
> and performance governors as I did with the previous versions
> of this patch. Now everything works fine and as expected.

Thanks for the confirmation!

I'll add a Tested-by tag from you to it if you don't mind.

Thanks,
Rafael
