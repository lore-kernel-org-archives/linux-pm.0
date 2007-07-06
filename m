From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 11:53:03 +0200
Message-ID: <200707061153.05091.rjw__15111.8774469525$1183715308$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
	<1183712354.3388.126.camel@localhost.localdomain>
	<200707061131.08475.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707061131.08475.oliver@neukum.org>
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

On Friday, 6 July 2007 11:31, Oliver Neukum wrote:
> Am Freitag, 6. Juli 2007 schrieb Benjamin Herrenschmidt:
> > On Fri, 2007-07-06 at 09:13 +0200, Rafael J. Wysocki wrote:
> > > 
> > > The only reason (I know of) why we don't handle uninterruptible tasks in the
> > > freezer is that we're afraid of the suspend process deadlocking with an
> > > uninterruptible task holding a lock, but AFAICS the probability of such an
> > > event is extremely small.
> > 
> > What would deadlock specifically ? One of the drivers trying to acquire
> > that lock ? It would be a driver bug then.
> 
> Your driver's write method looks like:
> 
> mutex_lock();
> poke_some_hardware();
> wait_event_uninterruptible(); //for result
> res = evaluate_result();
> mutex_unlock();
> return res;
> 
> If you put a task into the refrigerator at wait_event_interruptible()
> you will deadlock if you need this lock for the driver to go to suspend.
> The suspend method then must not take the lock _and_ it must be
> aware that there may be an ongoing operation.

s/interruptible/uninterruptible/

> you will deadlock if you need this lock for the driver to go to suspend.
> The suspend method then must not take the lock _and_ it must be
> aware that there may be an ongoing operation.

Well, is there any driver in the tree that works like that _and_ has a
.suspend() method requiring the same lock?

Besides, I'm not going to put the task into the refrigerator at that point.

Please read http://lkml.org/lkml/2007/7/6/71

Moreover, I claim that, in the context of your example, _if_ the task is stuck
at the wait_event_uninterruptible(), _then_ the freezerless suspend will
deadlock with the task.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
