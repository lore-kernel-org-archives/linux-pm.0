From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 18:38:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707171835560.8690-100000__27041.5310319096$1184712151$gmane$org@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Jul 2007 david@lang.hm wrote:

> > But what about the freezer?  The original reason for using kexec was to
> > avoid the need for the freezer.  With no freezer, while the original
> > kernel is busy powering down its devices, user tasks will be free to
> > carry out I/O -- which will make the memory snapshot inconsistent with
> > the on-disk data structures.
> 
> no, user tasks just don't get scheduled during shutdown.

But a user task may be holding a lock which is needed for putting some 
device into low-power mode.  It can't release that lock if it doesn't 
get scheduled.

Alan Stern
