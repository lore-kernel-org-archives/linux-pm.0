From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Wed, 18 Jul 2007 16:47:31 +0200
Message-ID: <200707181647.32620.rjw__5448.55059492892$1184769694$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707181021300.3759-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707181021300.3759-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 18 July 2007 16:29, Alan Stern wrote:
> On Tue, 17 Jul 2007 david@lang.hm wrote:
> 
> > On Tue, 17 Jul 2007, Alan Stern wrote:
> > 
> > > On Tue, 17 Jul 2007 david@lang.hm wrote:
> > >
> > >>> But what about the freezer?  The original reason for using kexec was to
> > >>> avoid the need for the freezer.  With no freezer, while the original
> > >>> kernel is busy powering down its devices, user tasks will be free to
> > >>> carry out I/O -- which will make the memory snapshot inconsistent with
> > >>> the on-disk data structures.
> > >>
> > >> no, user tasks just don't get scheduled during shutdown.
> > >
> > > But a user task may be holding a lock which is needed for putting some
> > > device into low-power mode.  It can't release that lock if it doesn't
> > > get scheduled.
> > 
> > then you can't suspend that box. if you schedule it, it could get another 
> > lock (or another process gets another lock)
> > 
> > if you can't power down or put hardware into low-power mode without the 
> > approval of userspace, you are in serious trouble.
> 
> You don't seem to appreciate the issues involved here.  Part of the 
> justification for the freezer is that it doesn't need userspace 
> approval and it freezes tasks at controlled points where they don't 
> hold any locks.
> 
> Never mind.  It seems clear that this approach will suffer the same 
> drawback as the proposal for removing the freezer from the 
> suspend-to-RAM pathway.  Namely, device drivers will have to be changed 
> to prevent user I/O requests from proceeding while devices are supposed 
> to be quiescent or in a low-power state.

I agree.
 
> If a driver fails to handle this properly, its device could be 
> reactivated in order to service a user request before the memory 
> snapshot is made.  This could easily ruin the snapshot.

That's why I've been saying for quite some time that we first need to take care
of the drivers. :-)

IMO we've reached the point at which, whatever we want to do next, the drivers
are in the way.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
