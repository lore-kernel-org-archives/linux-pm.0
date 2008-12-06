From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sat, 6 Dec 2008 21:09:27 +0000
Message-ID: <20081206210927.445f0bc6@lxorguk.ukuu.org.uk>
References: <200812020320.31876.rjw@sisk.pl> <200812061822.35763.rjw@sisk.pl>
	<alpine.LFD.2.00.0812060930490.3425@nehalem.linux-foundation.org>
	<200812061843.59495.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812061843.59495.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> prefer it to go next.  After it's been merged, I'm going to add the mandatory
> suspend-resume things (save state and go to a low power state on suspend,
> restore state on resume) to the new framework in a separete patch.
> 
> Is this plan acceptable?

I have at least two drivers I look after where if you put the device into
D3 you lost. We survive because on a successful suspend/resume sequence
the BIOS puts it back coming out of suspend but that means we must not
put those devices into D3 ourselves ever - including during a suspend
before we are 100% comitted to the suspend completing or reboot.
