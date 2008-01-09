From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC] Implementation of SCSI dynamic power
	management
Date: Wed, 9 Jan 2008 10:25:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801091022100.4468-100000__13921.4747622193$1199892581$gmane$org@iolanthe.rowland.org>
References: <20080108212430.GB5050@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080108212430.GB5050@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Jan 2008, Pavel Machek wrote:

> > In fact suspend methods already do take an argument specifying the
> > reason they were called.  It wouldn't be hard to add a couple of extra 
> > PM_EVENT_* values for manual suspend and autosuspend.  The problem is 
> > that resume methods don't take a corresponding argument.
> 
> Well, you could store the value in struct device or something.
> 
> There's other problem: if autosuspend is != NULL, you know device
> supports autosuspend.
> 
> If you call existing suspend(PMSG_AUTOSUSPEND), and driver does not
> support it, it will crash and burn.

That's right.  The problem doesn't arise in SCSI because there only the
sd driver supports suspend at all -- and now it supports autosuspend as
well.  In USB I had to add an extra "supports_autosuspend" bitflag to
the usb_driver structure.

Alan Stern
