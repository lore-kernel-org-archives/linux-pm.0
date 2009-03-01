From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 2 Mar 2009 00:17:50 +0100
Message-ID: <200903020017.52390.rjw__19673.0127827779$1235949761$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902282353.39763.rjw@sisk.pl>
	<d6200be20902281538g1dd6aec4q1b42b610d3ea15d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902281538g1dd6aec4q1b42b610d3ea15d1@mail.gmail.com>
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

On Sunday 01 March 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Feb 28, 2009 at 2:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 28 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> Can you summarize what the problems with my current api are? I get the
> >> impression that you think the overhead of using a list is too high,
> >> and that timeout support should be removed because you think all
> >> drivers that use it are broken.
> >
> > In no particular order:
> > 1. One user space process can create an unlimited number of wakelocks. =
 This
> >   shouldn't be possible.  Moreover, it is not even necessary for any pr=
ocess
> >   to have more than one wakelock held at any time.
> =

> This has been addressed. A user space process cannot create more
> wakelocks than it has filedescriptors.
> =

> > 2. Timeouts are wrong, because they don't really _solve_ any problem.  =
They are
> >   useful for working around the fact that you can't or you don't want to
> >   modify every piece of code that in principle should take a wakelock a=
nd
> >   that's it.
> =

> Yes, timeouts are sometimes wrong, but they are not always wrong. I
> gave two examples where the use of timeouts was not incorrect.

There still is a problem that the same operation can take time X on one
platform and time Y on another, so how are you going to determine the timeo=
uts
that will be suitable for all platforms?

> >  However,  entire concept of having one code path acting on
> >   behalf of another one on a hunch that it might be doing something mak=
ing
> >   suspend undesirable is conceptually broken IMO.
> =

> OK. Do you have an alternative?

Well, IMO every code path doing something that makes automatic suspend
undesirable should use a suspend blocker of some sort.  I'm afraid any other
approach will be unreliable and racy.

> I my opinion this is how the entire system works if you do autosuspend
> without a mechanism like wakelocks.

It surely hasn't been designed with automatic suspend in mind.

Thanks,
Rafael
