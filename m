From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Mon, 7 Jan 2008 16:34:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801071632180.6739-100000__26525.7043684416$1199741768$gmane$org@iolanthe.rowland.org>
References: <200801072131.05755.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801072131.05755.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jan 2008, Oliver Neukum wrote:

> Am Montag, 7. Januar 2008 20:42:23 schrieb Alan Stern:
> > When all the devices under a host are suspended, the LLD is informed 
> > (via a new "autosuspend" method in the host template) so that it can
> 
> That is most certainly a mistake.

Why?

> Is there a good reason to not modify
> to extend suspend() to take an extra argument for the reason it is called?

In fact suspend methods already do take an argument specifying the
reason they were called.  It wouldn't be hard to add a couple of extra 
PM_EVENT_* values for manual suspend and autosuspend.  The problem is 
that resume methods don't take a corresponding argument.

Alan Stern
