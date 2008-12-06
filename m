From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
	and resume
Date: Sat, 6 Dec 2008 22:50:42 +0100
Message-ID: <200812062250.43445.rjw__29950.592845171$1228600424$gmane$org@sisk.pl>
References: <200812020320.31876.rjw@sisk.pl> <200812061843.59495.rjw@sisk.pl>
	<20081206210927.445f0bc6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081206210927.445f0bc6@lxorguk.ukuu.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 6 of December 2008, Alan Cox wrote:
> > prefer it to go next.  After it's been merged, I'm going to add the mandatory
> > suspend-resume things (save state and go to a low power state on suspend,
> > restore state on resume) to the new framework in a separete patch.
> > 
> > Is this plan acceptable?
> 
> I have at least two drivers I look after where if you put the device into
> D3 you lost. We survive because on a successful suspend/resume sequence
> the BIOS puts it back coming out of suspend but that means we must not
> put those devices into D3 ourselves ever - including during a suspend
> before we are 100% comitted to the suspend completing or reboot.

We can mark them as devices not to put into D3.  There already is a
mechanism for that in place.

Thanks,
Rafael
