From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Mon, 20 Nov 2017 14:36:25 +0000
Message-ID: <bug-197009-137361-2Ayz4ghyCT@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49334 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751124AbdKTOg0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2017 09:36:26 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 792A62933B
        for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2017 14:36:26 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

--- Comment #10 from Hal (haleakalas@yahoo.com) ---
Hi Rob. Thanks for your message.
I opened the ticket https://bugzilla.kernel.org/show_bug.cgi?id=197017 which
was marked as a DUPLICATE of this ticket and closed. That's why I came here to
comment and ask my question.

I don't want to waste anyone's time and post in the wrong place, but in my
experience the /proc/cpuinfo has ramifications beyond just the frequency meter
showing the top speed CPU as opposed to the actual real time CPU speed, at
least in XFCE according to my experience. Here is why?

1) Starting with 4.13.0 and with every subsequent version of the kernel
(including 4.14.0), when used on Linux Mint 18.2 64bit with XFCE, it causes the
"CPU Frequency Monitor" to show the top speed of the CPU, not the actual,
instantaneous frequency (in average mode). Note that with any prior version,
that is not the case and it works as it should.

2) Now, after I posted my bug report, I was let to understand that this was
because the XFCE panel plugin read the information from the wrong location, aka
"/proc/cpuinfo" rather than
"/sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq". Then my bug report
was marked as duplicate of this one and closed.

3) Fetching the CPU info in the wrong place might be only a "cosmetic" issue if
it is not being used for anything other than just showing info on the screen.
But it seems to be used for more than that. It somehow has a direct impact on
"intel_pstate" driver which gets disturbed and results in far greater power
consumption. When I observed that, I switched to "acpi_cpufreq" driver and the
power consumption got lower but not to the minimum as it was the case with
"intel_pstate" when running with an older kernel.

I don't know where "acpi_cpufreq" is getting its CPU speed cue but somehow it
behaves better than "intel_pstate" on this affected series of kernels.

4) The only exception to this occurrence is with kernel version
4.13.12-041312-generic #201711080535, which I currently use, and which makes my
machine behave EXACTLY as it did with older kernel versions. So, for me it WAS
a solution.

5) But the fix in 4.13.12 was reversed because apparently it caused to much CPU
IPI, etc. I can understand that a different fix is necessary. But I question
the wisdom of closing this ticket, unless there is another one that I haven't
been able to find yet.

As to the "cosmetic" vs "functional" aspect of the issue, it worries me even
more because it sounds like I am the only one out there observing power
consumption issues. 

Again to reiterate, on my 6 month old Intel Pentium G4560 desktop I see this
issue, on my HP high end laptop with Intel i7-4710HQ, same behavior, and on a
low end unbranded laptop with Intel Celeron N3450 same tune! (All three systems
running Linux Mint 18.2 XFCE 64 bit in various state of update)

I understand this is not a discussion forum and only bug reports should be made
with useful information for the developers, and that's what I was trying to do.

-- 
You are receiving this mail because:
You are the assignee for the bug.
