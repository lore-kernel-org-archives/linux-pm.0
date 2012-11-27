From: Adrian Byszuk <adrian.byszuk@gmail.com>
Subject: Re: PROBLEM: resuming from suspend-to-ram hangs
Date: Tue, 27 Nov 2012 11:42:00 +0100
Message-ID: <50B498F8.2090609@gmail.com>
References: <50B3A371.10101@gmail.com> <CAJ0PZbSwbU-Lkbc66n7KCLXobR1si=M0NsaK1qo96f7dV4CsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:44680 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2K0KmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Nov 2012 05:42:05 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so6615640lag.19
        for <linux-pm@vger.kernel.org>; Tue, 27 Nov 2012 02:42:03 -0800 (PST)
In-Reply-To: <CAJ0PZbSwbU-Lkbc66n7KCLXobR1si=M0NsaK1qo96f7dV4CsXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: linux-pm@vger.kernel.org

On 27/11/12 03:10, MyungJoo Ham wrote:
> On Tue, Nov 27, 2012 at 2:14 AM, Adrian Byszuk <adrian.byszuk@gmail.com> wrote:
>> Hello all-mighty linux kernel developers.
>>
>> My laptop (Asus F3F-AP075) can't wake up from suspend to RAM, it seems
>> to hang completely while resuming. What seems to be a bit odd, is that
>> LED for HDD lights on all the time while the system is hanged.
>> To be more precise: s2ram used to work on this notebook, but it stopped
>> to. Some time ago I changed the HDD from typical 2.5' hard drive to an
>> OCZ Vertex4 SSD drive (and installed a new distribution on it) - I think
>> that's the moment it stopped working (however I'm not suspending often,
>> so it could also be a pure coincidence).
>> This problem is 100% reproducible on both Debian 3.2 kernel and vanilla
>> 3.6.x kernels.
>>
>> Following the Documentation/power/s2ram.txt I've got something like this
>> from dmesg:
>> [    0.253496]   Magic number: 0:56:890
>> [    0.253501]   hash matches drivers/base/power/main.c:571
>> [    0.253542] pci 0000:00:1f.3: hash matches
>>
>> and PCI 00:1f.3 device is:
>> 00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
>>
>> I'm willing to debug this by myself, but I need your help. Could someone
>> tell where to start looking?
>>
>> Regards,
>> Adrian
>>
> 
> Have you tested with console_suspend (or was it suspend_console?)
> disabled without X ?

I've tried suspending without X, no change.
I've just tested it with console_suspend disabled and got this:

[ 136.708075] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen
[ 136.708156] ata1.00: failed command: READ VERIFY SECTOR(S)
[ 136.708221] ata1.00: cmd 40/00:01:00:00:00/00:00:00:00:00/e0 tag 0
[ 136.708221]     res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x4
(timeout)
[ 136.708352] ata1.00: status: [DRDY]
[ 156.800057] ata1: SRST failed (errno=-16)
[ 166.845059] ata1: SRST failed (errno=-16)
