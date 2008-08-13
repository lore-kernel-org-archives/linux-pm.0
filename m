From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 10:31:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org>
References: <20080813095055.GA475@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756603AbYHMObU@vger.kernel.org>
In-Reply-To: <20080813095055.GA475@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@HansenPartnership.com, teheo@novell.com, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, Pavel Machek wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Add support for autosuspend/autoresume. Lowlevel driver can use it to
> spin the disk down and power down its SATA link, to turn off the USB
> interface, etc.
> 
> Spinning down the disk is useful - saves ~0.5W here. Powering down
> SATA controller is even better -- should save ~1W.
> 
> Now, I guess the patch will need to be split to small pieces for
> merge... I tried to rearrange it so that the documentation and hooks
> go before stuff that needs the hooks, and before Kconfig enabler. If
> it looks reasonably good, I'll split it into smaller pieces.

James had a number of objections to my original patch; you can read 
them here:

https://lists.linux-foundation.org/pipermail/linux-pm/2008-March/016849.html

I haven't had time yet to work on an improved version.

Alan Stern
