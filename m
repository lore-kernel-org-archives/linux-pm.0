From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50 [snd_hda_intel] returns -11
Date: Wed, 12 Dec 2012 00:44:33 +0100
Message-ID: <15066310.xXEWfqCuJc@vostro.rjw.lan>
References: <20121211170315.GC28827@liondog.tnic> <2487425.bAQggRZzC4@vostro.rjw.lan> <20121211175508.GE28827@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56453 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753759Ab2LKXjb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Dec 2012 18:39:31 -0500
In-Reply-To: <20121211175508.GE28827@liondog.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, December 11, 2012 06:55:08 PM Borislav Petkov wrote:
> On Tue, Dec 11, 2012 at 06:48:23PM +0100, Rafael J. Wysocki wrote:
> > Boris, please send the output of "lspci -vvv' from that box.
> 
> Attached.

So the audio is a Root Complex Integrated Endpoind and there shouldn't be
any problems with it related to PCIe ports power management.

It looks like azx_runtime_suspend() is new in 3.7 and it returns -EAGAIN
to indicate that it actually can't be suspended (if my understanding the
code is correct).  However, it shouldn't do that, because that causes
the runtime PM core to repeat the attempts.  It rather should implement
a .runtime_idle() callback returning an error code instead.

Those messages are just noise, though.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
