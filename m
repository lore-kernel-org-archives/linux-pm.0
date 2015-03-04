From: Martin Steigerwald <martin@lichtvoll.de>
Subject: [REGRESSION][BUG 94241] 4.0-rc2: Blanks screen on hibernation but does not switch off the machine
Date: Wed, 04 Mar 2015 11:47:28 +0100
Message-ID: <2102769.qaa7254DPQ@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:37838 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933123AbbCDKrb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 05:47:31 -0500
Received: from merkaba.localnet (unknown [194.150.191.253])
	by mail.lichtvoll.de (Postfix) with ESMTPSA id CE75C28E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2015 11:47:29 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Also reported as:
https://bugzilla.kernel.org/show_bug.cgi?id=94241


After I had [1] with 3.18 and 3.19 upto rc7, with 4.0-rc2 I get a different 
issue:

The ThinkPad T520 does not hibernate at all anymore. It blanks the screen, 
has some disk accesses, but then stays there. It stays on. It even seems 
to continue to have some disk accesses. But its not possible to switch on 
the display anymore. I tried the usual Ctrl-Alt-F1 to switch to TTY1 
thing.

Expected results:

It goes to console as I have "no_console_suspend", tells me it will 
hibernate, gives out the 10% step progress report on saving the image, 
completes saving the image and switches off.


I am back on 3.19-rc7 as I need the machine for work. I do not foresee 
having time to bisect this at the moment. I may try with kernel 4.0-rc2 
again and try to SSH into the machine from a different box. Maybe I can 
still log in to it in that black screen state.

This is on Debian Sid with systemd and the following hardware and software 
configuration:

martin@merkaba:~> phoronix-test-suite system-info

Phoronix Test Suite v5.2.1
System Information

Hardware:
Processor: Intel Core i5-2520M @ 3.20GHz (4 Cores), Motherboard: LENOVO 
42433WG, Chipset: Intel 2nd Generation Core Family DRAM, Memory: 16384MB, 
Disk: 300GB INTEL SSDSA2CW30 + 480GB Crucial_CT480M50, Graphics: Intel HD 
3000 (1300MHz), Audio: Intel 6 /C200, Network: Intel 82579LM Gigabit 
Connection + Intel Centrino Advanced-N 6205

Software:
OS: Debian 8.0, Kernel: 3.19.0-rc7-tp520+ (x86_64), Desktop: KDE 4.14.2, 
Display Server: X Server 1.16.4, Display Driver: intel 2.21.15, OpenGL: 
3.3 Mesa 10.4.2, Compiler: GCC 4.9.2, File-System: btrfs, Screen 
Resolution: 1920x1080


[1] [Bug 86565] New: black screen after resume from hibernation since 
linux kernel 3.18
https://bugs.freedesktop.org/show_bug.cgi?id=86565

Thanks,
-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
