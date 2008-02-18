From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Status of storage autosuspend
Date: Mon, 18 Feb 2008 23:20:14 +0100
Message-ID: <20080218222014.GB31201@elf.ucw.cz>
References: <20080218202749.GA2656@elf.ucw.cz> <Pine.LNX.4.44L0.0802181530330.31135-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761998AbYBRWUB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802181530330.31135-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > What is the status of USB storage/SCSI autosuspend patches? They work
> > nicely here ;-).
> 
> I could submit them, but there is one outstanding problem I would like
> to solve first.  Maybe you can suggest a solution.
> 
> The problem is how to handle SG_IOCTL calls.  It seems that the only
> safe thing to do is to force an autoresume and prevent the device from
> autosuspending until the device file is closed.  Unfortunately the
> SG_IOCTL stuff is all handled inside the block layer, and there's no
> apparent way (other than some dreadful hack) of passing the necessary
> information down to the SCSI layer.

Hmm...

> Should we ignore this issue and submit the patches anyway?

I think you should. "Easy" (and clean) solution to that issue is to
just return -EPERM from SG_IOCTL if autosuspend is configured in ;-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
