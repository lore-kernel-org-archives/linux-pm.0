From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 3 Mar 2009 23:39:00 +0100
Message-ID: <200903032339.02002.rjw__49682.5861781419$1236120093$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200903020017.52390.rjw@sisk.pl>
	<d6200be20903021548h11f57283t6d6a9053f3feb3fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20903021548h11f57283t6d6a9053f3feb3fd@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> On Sun, Mar 1, 2009 at 3:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday 01 March 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Sat, Feb 28, 2009 at 2:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Saturday 28 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> Can you summarize what the problems with my current api are? I get =
the
> >> >> impression that you think the overhead of using a list is too high,
> >> >> and that timeout support should be removed because you think all
> >> >> drivers that use it are broken.
> >> >
> >> > In no particular order:
> >> > 1. One user space process can create an unlimited number of wakelock=
s.  This
> >> >   shouldn't be possible.  Moreover, it is not even necessary for any=
 process
> >> >   to have more than one wakelock held at any time.
> >>
> >> This has been addressed. A user space process cannot create more
> >> wakelocks than it has filedescriptors.
> >>
> >> > 2. Timeouts are wrong, because they don't really _solve_ any problem=
.  They are
> >> >   useful for working around the fact that you can't or you don't wan=
t to
> >> >   modify every piece of code that in principle should take a wakeloc=
k and
> >> >   that's it.
> >>
> >> Yes, timeouts are sometimes wrong, but they are not always wrong. I
> >> gave two examples where the use of timeouts was not incorrect.
> >
> > There still is a problem that the same operation can take time X on one
> > platform and time Y on another, so how are you going to determine the t=
imeouts
> > that will be suitable for all platforms?
> =

> This only applies to the timeouts that fall into the wrong category.
> The timeout used when a driver returns -EBUSY is arbitrary, but any
> value is technically correct. The one second timeout in the alarm
> driver is not platform specific. It is one second because the
> resolution of the rtc api is only one second.
> =

> For the timeouts that do fall into the wrong category (use a timeout
> when passing data to a unmodified subsystem), the drivers are mostly
> (if not all) platform specific.

What drivers are they?

> >> >  However,  entire concept of having one code path acting on
> >> >   behalf of another one on a hunch that it might be doing something =
making
> >> >   suspend undesirable is conceptually broken IMO.
> >>
> >> OK. Do you have an alternative?
> >
> > Well, IMO every code path doing something that makes automatic suspend
> > undesirable should use a suspend blocker of some sort.  I'm afraid any =
other
> > approach will be unreliable and racy.
> =

> I agree with this,

Good.

> but I cannot change every code path at once.

That need not happen at once (eg. in one patch or something).  Once we've
introduced the basics, the changes can be made gradually wherever necessary,
step by step.

> I also don't know if every code path can be easily fixed. Using a timeout=
 in
> this case is a compromise. It is not as good as protecting every code
> path, but it is much better than doing nothing. The race condition you
> have when preventing suspend with a timeout is the same as every code
> using a timeout. If the system is busy it can fail. The race condition
> that you have with no protection happens with any load. If the system
> decides to go to sleep at the same time as a wakeup event occur, the
> system will sleep.

Well, if you have strictly limited time (eg. you want to ship a product at
specific date), you have to go for compromises like this, but we're not in a
hurry (or are we for some unspecified reason?).  There's no deadline etc., =
so
we can afford to do it right from the start (which BTW is likely to save us
time in future).

So, I'd suggest to just separate the timeouted suspend blockers from the
basic code and introduce the latter first.

IOW, let's first try to merge things that everybody is comfortable with and
postpone the merging of the rest.  I don't think we're going to lose
anything by doing it this way.

Thanks,
Rafael
