From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 03:56:39 +0100
Message-ID: <200902090356.39885.u.luckas@road.de>
References: <20090208210401.GE6369@elf.ucw.cz>
	<200902090311.58728.u.luckas@road.de>
	<d6200be20902081824r5f723694sd9f02e24c3ed3f0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902081824r5f723694sd9f02e24c3ed3f0d@mail.gmail.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: swetland@google.com, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Monday 09 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sun, Feb 8, 2009 at 6:11 PM, Uli Luckas <u.luckas@road.de> wrote:
> > On Monday 09 February 2009, Rafael J. Wysocki wrote:
> >> On Monday 09 February 2009, Pavel Machek wrote:
> >> > If wakelocks can be locked from userspace is _not_ a detail; and if
> >> > they can we do need the names.
> >>
> >> Do we?  What about one lock per process and using process names?
> >> Or better process IDs or even thread IDs?
> >
> > I like that idea. A process should be able to hold _one_ wake lock (whi=
ch
> > would be released if the process dies). If it turns out, that more then
> > on lock is convenient for a process, a library can easily agregate these
> > locks. If the last userspace wake lock is released, the library code can
> > relase the processes kernel wake lock.
> >
> >> Is there a limit on the number of wakelocks a user space process can
> >> create and if not, then why?
> >
> > Agreed as stated above. We should agree right now to switch to one lock
> > per process. Arve?
>
> This would work, but how would you implement it? I'm implementing an
> ioctl interface that will allow automatic cleanup without modifying
> the task struct.
I thought about a global ref count + a per thread flag. Now if your lock io=
ctl =

is first called for a specific thread it increases the global ref count and =

sets the thread's 'locked' flag. If the lock ioctl is called again for this =

thread it's a noop (with warning?). Now the first unlock ioctl decreases th=
e =

ref count and clears the locked flag. Further unlock ioctls are noops until =

the lock is taken again. =

In another thread Rafael mentioned something about reusing freezer flags. I=
f =

needed, he can probably give a detailed hint.
Does that sound feasible?

Uli
