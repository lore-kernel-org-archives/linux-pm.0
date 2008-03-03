From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Fundamental flaw in system suspend,
 exposed by freezer removal
Date: Mon, 3 Mar 2008 18:12:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803031808150.8280-100000__30560.8900999234$1204586161$gmane$org@iolanthe.rowland.org>
References: <200803032356.35275.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803032356.35275.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Mar 2008, Rafael J. Wysocki wrote:

> > > Perhaps it's better to include dpm_sysfs_add() into device_pm_add(), since we
> > > are going the make the return a result anyway?
> > 
> > Yes.
> 
> Okay, I'll prepare a patch for that, on top of the one introducing the
> 'sleeping' field into 'struct dev_pm_info' (posting in a while).

While you're at it, could you add a field to indicate whether 
begin_sleep() has been called?  It would help prevent multiple calls to 
that method when a race does occur, and it could be useful for drivers 
as well.

> The question remains what we're going to do with the drivers without pm_ops
> pointers in the long run (in the short run we will use the legacy callbacks in
> that cases, if defined).

One possibility is to unbind those drivers at the start of a sleep
transition and reprobe them at the end.  Another possibility is to
ignore the lack of PM support and hope it doesn't cause any problems.

Alan Stern
