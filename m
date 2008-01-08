From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 13:51:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801081349510.4804-100000__4534.25223608992$1199819178$gmane$org@iolanthe.rowland.org>
References: <4783BBC0.2070802@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4783BBC0.2070802@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Jan 2008, Stefan Richter wrote:

> > How about something more like this:
> > 
> > *	Resume (return to an operational power level) the specified host,
> > *	and prevent autosuspends from other software layers until the
> > *	template autosuspend method has been called again.
> > *	Return 0 if the resume was successful, otherwise a negative
> > *	error code.
> 
> Who prevents them?  The autoresume() implementation, or its caller?

The autoresume implementation.  This comment explains what the function 
is supposed to do, not what its caller does.

Alan Stern
