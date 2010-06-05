From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 01:03:20 +0200
Message-ID: <201006060103.20540.rjw__2712.59152000329$1275779018$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006052025.11526.rjw@sisk.pl>
	<AANLkTilP0uyJRuUq6BlVeHDydPYi4oJsf37VvSAixwgN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilP0uyJRuUq6BlVeHDydPYi4oJsf37VvSAixwgN@mail.gmail.com>
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
Cc: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday 05 June 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/4 Matt Helsley <matthltc@us.ibm.com>:
> >> > On Fri, Jun 04, 2010 at 05:39:17PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> >> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
> >> >> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
> >> >
> >> > <snip>
> >> >
> >> >>
> >> >> >     With the cgroup freezer you can "suspend" them right away and
> >> >> >     just keep the trusted background task(s) alive which allows u=
s to
> >> >> >     go into deeper idle states instead of letting the crapplicati=
ons
> >> >> >     run unconfined until the download finished and the suspend
> >> >> >     blocker goes away.
> >> >> >
> >> >>
> >> >> Yes this would be better, but I want it in addition to suspend, not
> >> >> instead of it. It is also unclear if our user-space code could easi=
ly
> >> >> make use of it since our trusted code calls into untrusted code.
> >> >>
> >> >
> >> > Perhaps I'm misunderstanding, but suspend and the cgroup freezer
> >> > interoperate well today -- you don't have to choose one or the other.
> >> > If you've discovered otherwise I'd consider it a bug and would like =
to
> >> > hear more about it.
> >> >
> >>
> >> I'm not aware of any bug with combining both, but we cannot use
> >> suspend at all without suspend blockers in the kernel (since wakeup
> >> events may be ignored)
> >
> > The more I think of it, the more it appears to me that the problem of
> > lost wakeup events can actually be solved without suspend blockers.
> > I'll send a bunch of patches to address this issue, probably tomorrow.
> >
> =

> I know of two ways to prevent lost wakeup events. Reset a timeout
> every time you receive a wakeup event or prevents suspend until you
> know the event has been fully processed. Does your solution fall onto
> one of these two categories, or do you have a third way?

Basically, it involves two mechanisms, detection of wakeup events occuring
right before suspend is started and aborting suspend if wakeup events occur
in the middle of it.

> >> and I don't know how we can safely freeze
> >> cgroups without funneling all potential wakeup events through a
> >> process that never gets frozen.
> >
> > If your untrusted apps get called by the trusted ones, they aren't real=
ly
> > untrusted in the first place.
> >
> That is not a correct statement. A trusted apps can call into an
> untrusted app, it just has to validate the response and handle not
> getting a response at all. There are also different levels of trust. I
> may have trusted an app to provide a contact pictures, but not trusted
> it to block suspend. When the phone rings the app will be called to
> provide the picture for the incoming call dialog, but if it is frozen
> at this point the more trusted app that handles the incoming phone
> call will not be able to get the picture.

It will be able to do that if it causes the frozen part of user space to be
thawed.

I think you have this problem already, though, because you use full system
suspend and all of your apps are frozen by it.  So, to handle the situation=
 you
describe above, you need to carry out full system resume that will thaw the
tasks for you.  I don't see any fundamental difference betwee the two cases.

> > From what you're saying it follows that you're not really willing to ac=
cept
> > any solution different to your suspend blockers.  Is that really the ca=
se?
> >
> I don't think that is a fair way to put it. We need to support our
> user-space framework and I have not seen an alternative solution that
> clearly will work (other than replacing suspend_blockers with pm_qos
> constraints that do the same thing).

Then think again of the approach I proposed and explain to me why it won't
work, because I haven't seen any convincing argument on that yet.

Rafael
