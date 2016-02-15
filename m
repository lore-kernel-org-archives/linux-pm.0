From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 15:19:57 -0800
Message-ID: <56C25D1D.5080409@roeck-us.net>
References: <20160215170527.GA24453@roeck-us.net>
 <CAFEAcA9Xy2L+edFAdUCpZFiO5NLGyrQPTQ6DgmuScbwEty-nzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45836 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbcBOXUC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 18:20:02 -0500
In-Reply-To: <CAFEAcA9Xy2L+edFAdUCpZFiO5NLGyrQPTQ6DgmuScbwEty-nzg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 02/15/2016 02:29 PM, Peter Maydell wrote:
> On 15 February 2016 at 17:05, Guenter Roeck <linux@roeck-us.net> wrote:
>> I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
>> timers with utilization update callbacks' with next-20160215. An example
>> crash log and bisect results are attached below.
>>
>> Please let me know if there is anything I can do to help tracking down
>> the problem.
>>
>> Thanks,
>> Guenter
>>
>> ---
>>
>> Building arm:beagle:multi_v7_defconfig:omap3-beagle ... running ..... failed (crashed)
>> ------------
>> qemu log:
>
> You're using the QEMU beagle board emulation? Can I ask which
> QEMU you're using (qemu-linaro?). If the OMAP3 emulation is still
> actively useful to people I might have another stab at getting
> it into upstream QEMU some day...
>

Yes, I use qemu-linaro for those tests.

Is it useful ? Obviously for me, yes. It lets me test images in qemu,
and I don't need real hardware to run those tests. That means that
I don't depend on the hardware really working, and I am not hosed
if the hardware breaks down and I don't have a replacement. Plus,
of course, I don't need a lab with 90+ pieces of hardware.

Guenter

