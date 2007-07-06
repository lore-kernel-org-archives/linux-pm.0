From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:13:22 +0200
Message-ID: <200707060913.24131.rjw__31523.8927644261$1183705595$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
	<200707052337.27066.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707052337.27066.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 23:37, Oliver Neukum wrote:
> Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> > On Thu, 5 Jul 2007, Miklos Szeredi wrote:
> > 
> > > I fear, that your efforts to "save" the freezer are in vain.  It is
> > > already moderately hackish with that PF_FREEZER_SKIP and the kernel
> > > dotted randomly with try_to_freeze() calls, but adding bandaids to try
> > > to order freezing userspace processes in the right order would just
> > > make it a horrible mess.
> > 
> > I agree that bandaids won't work.  What's needed is something more 
> > radical.  Things like FUSE must be written so that the kernel parts 
> > _can_ freeze even while they are waiting for a response from a user 
> > thread.
> 
> OK, some radical ideas.
> 
> In principle we want a deadlock here. Tasks that are frozen due to fuse
> are as good as frozen, there's no need to formally freeze them.
> The bad uninterruptible tasks are those waiting for hardware.
> 
> Can we detect the difference? Perhaps we can label those crucial locks
> and when only tasks in the refrigerator and tasks waiting on these locks
> are left we are content and go on to suspending the device tree.

Well, I think we can just make the freezer handle uninterruptible tasks.

If an uninterruptible task is stuck holding a lock that's needed for suspend,
the freezerless suspend will deadlock anyway. :-)

The only reason (I know of) why we don't handle uninterruptible tasks in the
freezer is that we're afraid of the suspend process deadlocking with an
uninterruptible task holding a lock, but AFAICS the probability of such an
event is extremely small.

Also, the powermac suspend will deadlock in such cases, so the fact that
it doesn't deadlock means that they don't occur very often (if at all).

I have a patch for that, will post it in a separate thread in a while.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
