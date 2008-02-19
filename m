From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Status of storage autosuspend
Date: Mon, 18 Feb 2008 22:19:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802182214060.18685-100000@netrider.rowland.org>
References: <20080218222014.GB31201@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760684AbYBSDTW@vger.kernel.org>
In-Reply-To: <20080218222014.GB31201@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Feb 2008, Pavel Machek wrote:

> > Should we ignore this issue and submit the patches anyway?
> 
> I think you should. "Easy" (and clean) solution to that issue is to
> just return -EPERM from SG_IOCTL if autosuspend is configured in ;-).

:-)

Okay, I'll update the patches to 2.6.25-rc2 and submit them in a few
days.  (Actually the SCSI patch has to go in first and the usb-storage
patch afterward, which will probably cause it to be delayed one kernel
version.  I don't know any good way to handle these cross-subsystem
updates...)

Alan Stern
