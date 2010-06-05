From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 18:18:26 -0700
Message-ID: <20100605011826.GB21016__3894.98505178398$1275700776$gmane$org@count0.beaverton.ibm.com>
References: <20100603193045.GA7188@elte.hu> <20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 04, 2010 at 05:39:17PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de> wrot=
e:
> > On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:

<snip>

> =

> > =A0 =A0 With the cgroup freezer you can "suspend" them right away and
> > =A0 =A0 just keep the trusted background task(s) alive which allows us =
to
> > =A0 =A0 go into deeper idle states instead of letting the crapplications
> > =A0 =A0 run unconfined until the download finished and the suspend
> > =A0 =A0 blocker goes away.
> >
> =

> Yes this would be better, but I want it in addition to suspend, not
> instead of it. It is also unclear if our user-space code could easily
> make use of it since our trusted code calls into untrusted code.
>

Perhaps I'm misunderstanding, but suspend and the cgroup freezer
interoperate well today -- you don't have to choose one or the other.
If you've discovered otherwise I'd consider it a bug and would like to
hear more about it.

<snip> =


> it can handle bad apps better (assuming you don't combine
> opportunistic suspend and cgroup freezing).

I don't see why that would be a problem. The cgroup freezer works
independently of the suspend freezer -- even with suspend blockers.
So my hunch is this is really the same as the next problem you refer to:

> The biggest hurdle is how
> to handle dependencies between processes that gets frozen and
> processes that don't get frozen.

I'm not sure it covers everything you want, but it should be possible to
identify some of those so long as you know which process you're
communicating with.

A trusted app can look up the freezer cgroup of a target app in /proc, then
look at the cgroup's freezer.state file. If it's FREEZING or FROZEN then
you've very likely got a "bad" dependency.

For example, say a trusted app plans on doing a blocking read() to fetch
the output of an untrusted app via a pipe. Assuming we know the untrusted
app's pid we could then check the dependency and determine that we're likely
to block because the untrusted app's freezer cgroup is FREEZING or FROZEN.
(certain to block if we see FROZEN)

That said, it involves quite a few system calls compared to a simple read()
from the pipe. So my guess is it would be a debugging tool at best -- not
something you always have enabled.

It may even be possible to make an lsof-like debugging tool to do that from
outside both apps.

Cheers,
	-Matt Helsley
