From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Status of storage autosuspend
Date: Mon, 18 Feb 2008 15:36:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802181530330.31135-100000@netrider.rowland.org>
References: <20080218202749.GA2656@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760643AbYBRUg3@vger.kernel.org>
In-Reply-To: <20080218202749.GA2656@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Feb 2008, Pavel Machek wrote:

> Hi!
> 
> What is the status of USB storage/SCSI autosuspend patches? They work
> nicely here ;-).

I could submit them, but there is one outstanding problem I would like
to solve first.  Maybe you can suggest a solution.

The problem is how to handle SG_IOCTL calls.  It seems that the only
safe thing to do is to force an autoresume and prevent the device from
autosuspending until the device file is closed.  Unfortunately the
SG_IOCTL stuff is all handled inside the block layer, and there's no
apparent way (other than some dreadful hack) of passing the necessary
information down to the SCSI layer.

Should we ignore this issue and submit the patches anyway?

Alan Stern
