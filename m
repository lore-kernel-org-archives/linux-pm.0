From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL pm-next] freezer: fix various bugs and
	simplify implementation
Date: Mon, 22 Aug 2011 20:50:59 +0200
Message-ID: <201108222050.59374.rjw__29143.7829997905$1314039107$gmane$org@sisk.pl>
References: <20110820094434.GA24151@htj.dyndns.org>
	<201108212003.14722.rjw@sisk.pl>
	<20110822095857.GD24151@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110822095857.GD24151@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: arnd@arndb.de, paul@paulmenage.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 22, 2011, Tejun Heo wrote:
> Hello, Rafael.
> 
> On Sun, Aug 21, 2011 at 08:03:14PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM / Freezer: Move might_sleep() from try_to_freeze()
> > 
> > There are some code paths that call try_to_freeze() from interrupt
> > context, but doing so they know that the current process cannot
> > possible be freezing (e.g. during reboot on ARM).  However, the
> > recently added might_sleep() annotation in try_to_freeze()
> > triggers in those cases, making it look like there were bugs in
> > those places, which really isn't the case.
> > 
> > Therefore move might_sleep() from try_to_freeze() to
> > __refrigerator() so that it doesn't produce false positives.
> 
> Hmmm... I can't quite agree with this change.  Some invocations of
> try_to_freeze() can be very difficult to trigger.  Freezing isn't a
> frequent operation after some try_to_freeze() can be buried in weird
> places.  might_sleep() is exactly to detect context bugs in these
> situations.  If a code path is called from both sleepable and
> unsleepable context and it knows that the latter wouldn't happen if
> the system is freezing, that code path should conditionalize
> invocation of try_to_freeze() based on its knowledge of context.  That
> way, all other normal cases get the might_sleep() protection and the
> peculiar logic in that code path is explicitly described - win win.
> 
> Can you please point me to where the problem was?

Apparently, during reboot on ARM try_to_freeze() is called via
do_signal() with interrupts disabled.

Thanks,
Rafael
