From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Add extra PM_EVENT_* codes for use by
	subsystems
Date: Sun, 2 Mar 2008 10:18:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803021017280.9430-100000@netrider.rowland.org>
References: <200803021357.42826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803021357.42826.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 Mar 2008, Rafael J. Wysocki wrote:

> On Friday, 29 of February 2008, Alan Stern wrote:
> > Is there any objection to adding extra PM_EVENT_* codes?  Although they
> > won't ever be issued by the PM core, they will come in handy for
> > internal uses in power-aware subsystems (like USB).
> 
> Well, this is in a (slight) conflict with the hibernation/suspend callbacks
> rework that I'm working on with Alex.  I'll send the first patch in a few
> minutes for comments.

If you want to add my new codes to yours, that would be fine.  Or I 
could wait until after your new callbacks are merged before submitting 
the new event codes.  Whatever you think is best.

Alan Stern
