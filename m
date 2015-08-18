From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Tue, 18 Aug 2015 10:23:40 +0800
Message-ID: <55D2972C.3030709@intel.com>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com> <20150817101115.GA27204@gmail.com> <20150817132726.GA11047@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2229 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbbHRCUR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 22:20:17 -0400
In-Reply-To: <20150817132726.GA11047@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@kernel.org>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pavel, thanks for your review,
On 08/17/2015 09:27 PM, Pavel Machek wrote:
> On Mon 2015-08-17 12:11:15, Ingo Molnar wrote:
>>
>> * Chen Yu <yu.c.chen@intel.com> wrote:
>>
>>> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
>
> Access denied :-(
>
Might need to register for accessing.
>
> What HW is this on?
>
Intel Braswell and Broadwell, detail for Broadwell:
Platform: MayanCity
Processor: 2x BROADWELL BDX_EP A0 QHPR
Chipset: Wellsburg B1 QR7E

>
> - So BIOS expects to control MSR_IA32_THERM_CONTROL . Now you suspend
>    in hot enironment but resume in cool one. BIOS sets up
>    MSR_IA32_THERM_CONTROL the right way, but you override it.
>
>    As BIOS expects to control MSR_IA32_THERM_CONTROL and machine is
>    kept cool, BIOS will not write new value to it, and machine will
>    keep running slowly.
>
Sorry, I can not quite catch up, do you mean we should let
  BIOS modifying MSR_IA32_THERM_CONTROL and  leverage linux
to adjust this value at runtime(after S3)?

> Doing this unconditionally is asking for trouble. Blacklist entry with
> affected BIOS info might be acceptable, but...
> 									Pavel
>
you mean a quirk here(accroding to dmi info ,etc)?


Best Regards,
Yu

