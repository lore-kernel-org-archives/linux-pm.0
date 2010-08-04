From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Wed, 4 Aug 2010 09:32:16 -0700
Message-ID: <20100804163216.GB24163__28275.1648607247$1280939680$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
	<20100803183447.0275c134@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100803183447.0275c134@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 03, 2010 at 06:34:47PM -0700, Arjan van de Ven wrote:
> On Mon, 2 Aug 2010 21:56:10 -0700
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
> =

> > > non-obvious dependencies.
> > >
> > =

> > The dependencies is what made this solution uninteresting to us. For
> > instance, we currently use cgroup scheduling to reduce the impact of
> > some background tasks, but we occasionally saw a watchdog restart of
> > the system process were critical services were waiting on a kernel
> > mutex owned by a background task for more than 20 seconds. If we froze
> > a cgroup instead, we would not hit this particular problem since tasks
> > cannot be frozen while executing kernel code the same way they can be
> > preempted, but nothing prevents a task from being frozen while holding
> > a user-space resource.
> =

> one of the solutions we're looking at to solve this is to unfreeze the
> cgroup on a regular basis (say, every 15 to 30 seconds) briefly to avoid
> this kind of deadlock...

Cute!!!  ;-)

If this doesn't work for the Android folks for whatever reason, another
approach would be to do the freeze in user code, which could track
whether any user-level resources (pthread mutexes, SysV semas, whatever)
where held, and do the freeze on a thread-by-thread basis within each
"victim" application as the threads reach safe points.

I must of course defer to the Android folks as to whether or not this
would actually work for Android.  But if your approach works for them,
why worry?

							Thanx, Paul
