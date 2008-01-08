From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC] Implementation of SCSI dynamic power
	management
Date: Tue, 8 Jan 2008 21:24:30 +0000
Message-ID: <20080108212430.GB5050__89.0620322481439$1199830159$gmane$org@ucw.cz>
References: <200801072131.05755.oliver@neukum.org>
	<Pine.LNX.4.44L0.0801071632180.6739-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0801071632180.6739-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> > > When all the devices under a host are suspended, the LLD is informed 
> > > (via a new "autosuspend" method in the host template) so that it can
> > 
> > That is most certainly a mistake.
> 
> Why?
> 
> > Is there a good reason to not modify
> > to extend suspend() to take an extra argument for the reason it is called?
> 
> In fact suspend methods already do take an argument specifying the
> reason they were called.  It wouldn't be hard to add a couple of extra 
> PM_EVENT_* values for manual suspend and autosuspend.  The problem is 
> that resume methods don't take a corresponding argument.

Well, you could store the value in struct device or something.

There's other problem: if autosuspend is != NULL, you know device
supports autosuspend.

If you call existing suspend(PMSG_AUTOSUSPEND), and driver does not
support it, it will crash and burn.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
