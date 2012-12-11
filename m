From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50 [snd_hda_intel] returns -11
Date: Tue, 11 Dec 2012 18:48:23 +0100
Message-ID: <2487425.bAQggRZzC4@vostro.rjw.lan>
References: <20121211170315.GC28827@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55685 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab2LKRnW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Dec 2012 12:43:22 -0500
In-Reply-To: <20121211170315.GC28827@liondog.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Takashi Iwai <tiwai@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, December 11, 2012 06:03:15 PM Borislav Petkov wrote:
> Hi guys,
> 
> I've got the message tagged "HERE" in dmesg running 3.7 (of course, this
> is a new message):
> 
> ...
> [   27.444441] input: ACPI Virtual Keyboard Device as /devices/virtual/input/input14
> [   29.550494] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50 [snd_hda_intel] returns -11	<-- HERE
> [   29.610630] powernow-k8: this CPU is not supported anymore, using acpi-cpufreq instead.
> [   29.676307] acpi-cpufreq: overriding BIOS provided _PSD data
> [   32.575161] Program wdm tried to access /dev/mem between 100000->104000.
> [   34.242866] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50 [snd_hda_intel] returns -11	<-- HERE
> [ 1502.142636] usbcore: registered new interface driver usblp
> [ 1988.970449] Program wdm tried to access /dev/mem between 100000->104000.
> [ 1988.994976] pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50 [snd_hda_intel] returns -11	<-- HERE

Well, this looks like the driver is having a problem.

Takashi, have we done any PM changes to that driver recently?

Boris, please send the output of "lspci -vvv' from that box.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
