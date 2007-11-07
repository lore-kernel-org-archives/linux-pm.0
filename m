From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Add the "icebox"
Date: Wed, 7 Nov 2007 17:28:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711071726590.8406-100000@iolanthe.rowland.org>
References: <200711072331.54708.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711072331.54708.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Nov 2007, Rafael J. Wysocki wrote:

> > P.S.: What about mutual exclusion in kernel/power/user.c?  If we stop 
> > freezing user tasks, there's nothing to prevent more than one task 
> > holding an open file reference to the snapshot file and submitting 
> > ioctls concurrently.  Maybe the regions covered by pm_mutex should be 
> > expanded.
> 
> /dev/snapshot can only be open once at a time.

What if a process opens /dev/snapshot and then forks a child?  Can't
the parent and child processes make concurrent ioctl calls?

Alan Stern
