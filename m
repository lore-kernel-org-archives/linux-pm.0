From: "rhn" <kebuac.rhn@porcupinefactory.org>
Subject: Unreliable hibernation on Lenovo x230 (regression)
Date: Wed, 1 Apr 2015 21:47:43 +0200
Message-ID: <20150401214743.20fbe2c5@porcupinefactory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 178.212.147.28.siec.idealan.pl ([178.212.147.28]:48509 "EHLO
	porcupinefactory.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbDATx4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 15:53:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

Hello,

Between kernel 3.16 and 3.17, a regression has been introduced where the first hibernation after regular shutdown always fails to resume. Subsequent hibernations succeed.

The system is a Lenovo x230 with Intel i5, booting with EFI, with the hibernate partition located on a secondary SSD drive. Installed system is Fedora 20, hibernation and reboots were issued using the KDE shutdown dialog.

I have tracked the problem to first appear in the commit
e67ee10190e69332f929bdd6594a312363321a66	Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'

The problem itself manifests in dmesg as follows (system was first restarted, then hibernated - this log is from the subsequent resume):

[    0.603802] PM: Checking hibernation image partition UUID=8f9fa995-7456-4353-9e43-4f9b2aa3c85a
[    1.523053] PM: Hibernation image not present or could not be loaded.
[    2.888873] PM: Starting manual resume from disk
[    2.888879] PM: Hibernation image partition 8:17 present
[    2.888881] PM: Looking for hibernation image.
[    2.891705] PM: Image signature found, resuming
[    2.891834] PM: Preparing processes for restore.
[    2.895006] PM: Loading hibernation image.
[    2.895188] PM: Marking nosave pages: [mem 0x00090000-0x000fffff]
[    2.895194] PM: Marking nosave pages: [mem 0x20000000-0x201fffff]
[    2.895207] PM: Marking nosave pages: [mem 0x40004000-0x40004fff]
[    2.895209] PM: Marking nosave pages: [mem 0x5b8fd000-0x5bafefff]
[    2.895222] PM: Marking nosave pages: [mem 0x9d3d3000-0x9d3d3fff]
[    2.895223] PM: Marking nosave pages: [mem 0x9d3e3000-0x9d3e3fff]
[    2.895225] PM: Marking nosave pages: [mem 0xd6850000-0xdaffefff]
[    2.895626] PM: Marking nosave pages: [mem 0xdb000000-0xffffffff]
[    2.896472] PM: Basic memory bitmaps created
[    2.930394] PM: Using 3 thread(s) for decompression.
PM: Loading and decompressing image data (355423 pages)...
[    3.054656] PM: Image loading progress:   0%
[    3.138824] PM: 0x9d3d3000 in e820 nosave region: [mem 0x9d3d3000-0x9d3d3fff]
[    3.139696] PM: Read 1421692 kbytes in 0.20 seconds (7108.46 MB/s)
[    3.140736] PM: Error -14 resuming
[    3.140762] PM: Failed to load hibernation image, recovering.
[    3.141520] PM: Basic memory bitmaps freed
[    3.141591] PM: Hibernation image not present or could not be loaded.
[    3.159767] PM: Starting manual resume from disk
[    3.159772] PM: Hibernation image partition 8:17 present
[    3.159774] PM: Looking for hibernation image.
[    3.160992] PM: Image not found (code -22)
[    3.160995] PM: Hibernation image not present or could not be loaded.

(the system boots normally after this)

The failure mode looks similar to the one specified by commit
84c91b7ae07c62cf6dee7fde3277f4be21331f85	PM / hibernate: avoid unsafe pages in e820 reserved regions
which I believe is related.

In 3.16, dmesg after resume is the same as the second (successful) attempt in the broken commit:

[   82.104560] PM: Hibernation mode set to 'platform'
[   82.124615] PM: Syncing filesystems ... done.
[   82.338692] PM: Marking nosave pages: [mem 0x00090000-0x000fffff]
[   82.338698] PM: Marking nosave pages: [mem 0x20000000-0x201fffff]
[   82.338708] PM: Marking nosave pages: [mem 0x40004000-0x40004fff]
[   82.338710] PM: Marking nosave pages: [mem 0x5b8fd000-0x5bafefff]
[   82.338720] PM: Marking nosave pages: [mem 0x9d3d3000-0x9d3d3fff]
[   82.338721] PM: Marking nosave pages: [mem 0x9d3e3000-0x9d3e3fff]
[   82.338723] PM: Marking nosave pages: [mem 0xd6850000-0xdaffefff]
[   82.339042] PM: Marking nosave pages: [mem 0xdb000000-0xffffffff]
[   82.339731] PM: Basic memory bitmaps created
[   82.339802] PM: Preallocating image memory... done (allocated 369125 pages)
[   82.749218] PM: Allocated 1476500 kbytes in 0.40 seconds (3691.25 MB/s)
[   83.943966] PM: freeze of devices complete after 1193.117 msecs
[   83.944513] PM: late freeze of devices complete after 0.542 msecs
[   83.949333] PM: noirq freeze of devices complete after 4.815 msecs
[   83.952668] PM: Saving platform NVS memory
[   83.960083] PM: Creating hibernation image:
[   84.288693] PM: Need to copy 368027 pages
[   84.288697] PM: Normal pages needed: 368027 + 1024, available pages: 2730849
[   83.961192] PM: Restoring platform NVS memory
[   84.092687] PM: noirq restore of devices complete after 11.067 msecs
[   84.092844] PM: early restore of devices complete after 0.132 msecs
[   84.941509] PM: restore of devices complete after 793.686 msecs
[   84.941713] PM: Image restored successfully.
[   84.941764] PM: Basic memory bitmaps freed

The bug persists with kernel 4.0.0-rc5.

While I'm not familiar enough with x64 PM to fix it myself, I'll be happy to provide more info, or apply patches that provide deeper debugging, or check out various combinations of the merged branches (but which ones?).

Cheers,
rhn
