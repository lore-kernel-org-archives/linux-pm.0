From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Singlethread vs. freezable workqueues
Date: Mon, 21 May 2007 23:28:00 +0200
Message-ID: <200705212328.00860.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705211531530.5679-100000@iolanthe.rowland.org>
	<200705212154.34490.rjw@sisk.pl> <20070521205409.GA167@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070521205409.GA167@tv-sign.ru>
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
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 21 May 2007 22:54, Oleg Nesterov wrote:
> On 05/21, Rafael J. Wysocki wrote:
> > 
> > On Monday, 21 May 2007 21:33, Alan Stern wrote:
> > > Raphael:
> > > 
> > > Are we now committed to making freezable workqueues always 
> > > singlethreaded?  Is it at all likely to change back?  Or should I 
> > > introduce a "create_singlethread_freezeable_workqueue" macro?
> > 
> > This was done as a quick fix of an issue with one driver that started to use
> > (broken) freezable workqueues when we were not watching. ;-)
> > 
> > We are going to have multithread freezable workqueues as well, but that'll
> > take some time.  We've discussed this a bit with Oleg and I believe he has an
> > idea of how it can be done cleanly.
> 
> No, I don't have an idea how to do this cleanly currently.
> 
> We can fix them right now with Rafael's "take_over_work() + migrate_sequence"
> patch, feel free to send it. Not perfect, but should work.

Well, there's no hurry with that, I think.  If there's a clear case in which
such a workqueue would be useful, we can do this.  For now, I don't see one.

> Perhaps it makes sense to make some other changes first. For example, kill
> CPU_TASKS_FROZEN bit.

That's possible, but the microcode driver uses it in a nontrivial way and that
should be taken into consideration.

> Next. We can't make all wqs freezeable, but if we add freezer_exempt/PF_FE_XXX
> we can freeze them all for cpu_up/cpu_down, this also make things simpler.

Yes.

> Note that we don't have a good way to use take_over_work() for !freezeable wq.
> 2.6.21 does kthread_stop() first, this is deadlockable because we may have
> a work_struct on ->worklist which also calls kthread_stop(). Perhaps it makes
> sense to wait until kthread_stop() will be reworked (should be soon).

Yes, I think we should wait until the kthread-related things settle.

> Perhaps we can think a bit more :)

Sure, that won't hurt. :-)

Greetings,
Rafael
