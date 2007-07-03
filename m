From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 22:54:19 +0200
Message-ID: <200707032254.20874.rjw__45656.7621244632$1183495910$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707031026260.3720-100000@iolanthe.rowland.org>
	<200707031722.13165.rjw@sisk.pl>
	<E1I5mKv-0004TM-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I5mKv-0004TM-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 19:38, Miklos Szeredi wrote:
> > > Indeed. Actually, one could argue that it's impossible to solve the
> > > problem as long as we try to call out to userspace during suspend and
> > > need to wait until that's finished, like in the case of sys_sync() and
> > > fuse filesystems, and probably other cases. Maybe we should make *those*
> > > calls return a failure so that the suspend isn't transparent inside the
> > > kernel but is transparent to userspace.
> > 
> > Well, it generally needs more consideration. :-)
> > 
> > I think that we should introduce mechanisms that will allow us to notify all
> > kernel subsystems, including FUSE and similar, that the system is going to
> > enter a sleep state (one of those is the notifier chain introduced recently).
> 
> Ugh, please no.
> 
> Believe me, fuse is doing _nothing_ out of the ordinary, and should
> not need special treatment during suspend/resume.  If suspend itself
> is doing something that triggers fuse activity, then that's a bug,
> such as the sync() thing that started this thread.

Apart from the sync, it shouldn't trigger any fs activity.  Still, some other
task running concurrently with the suspend code may do that and _if_
we are going to allow that to happen (and we do, if we remove the freezer
from the suspend code path), we will have to take that into consideration.

> > Then, they may react to such a notification by entering a "suspend" mode
> > of operation in which they will return errors from some callbacks that
> > otherwise should have succeeded etc.  That depends on the subsystem in
> > question.
> 
> Sounds horrible.
> 
> Why do we need to deal with subsystem interdependencies during
> suspend?  Isn't it about saving device state to ram?

No.  In addition, the devices should be prevented from generating interrupts
or initiating DMA transfers and put into low power states before we actually
suspend the system (platform).  This is a bit difficult to do while all user
space is running.

> That definitely _should not_ need to trigger anything that touches
> filesystems or other subsystems.

Right, but the subsystems may do something that affects devices.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
