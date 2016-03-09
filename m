From: Arto Jantunen <viiru@iki.fi>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 09 Mar 2016 19:01:23 +0200
Message-ID: <87a8m74mcc.fsf@iki.fi>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<87si087tsr.fsf@iki.fi>
	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:51853 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbcCIRB1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Mar 2016 12:01:27 -0500
In-Reply-To: <CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>
	(Len Brown's message of "Tue, 8 Mar 2016 16:19:13 -0500")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rik van Riel <riel@redhat.com>

Len Brown <lenb@kernel.org> writes:

> On Wed, Mar 2, 2016 at 11:01 AM, Arto Jantunen <viiru@iki.fi> wrote:
>> Len Brown <lenb@kernel.org> writes:
>>> Does it happen if you use default cmdline,
>>> but edit intel_idle.c to comment out c8 and c9 support?
>>
>> That also boots, ts.out attached (as is the patch to do this, to make
>> sure there is no miscommunication).
>
> yes, patch looks good, and thanks for running turbostat.
>
> If your system boots and runs properly with "intel_idle.max_cstate=7",
> then you are suffering this issue:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=109081

That's the one, indeed. Based on the report this is actually a microcode
bug?

This is the version info that I see at boot:

microcode: CPU0 sig=0x506e3, pf=0x20, revision=0x33

The machine is an Asus GL552VW (reported as affected in the bug report),
with BIOS version 216, which is the latest.

>> With this change the original bug disappears as well.
>
> Hmm, so your problems with frequency staying constant,
> as well as the boot issue both went away by deleting c8 and c9?

Yes. I assume that removing idle=nomwait is the fix for the frequency
issue, while removing the deepest idle states fixes the boot issue.

> Still works with intel_idle.max_cstate=7 ?

I'll test this.

-- 
Arto Jantunen
