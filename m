From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 01:39:03 +0200
Message-ID: <201006060139.03585.rjw__34130.2979774356$1275781200$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
	<AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
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
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> > On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> >> > B1;2005;0cOn Fri, 4 Jun 2010, Arve Hj=F8nnev=E5g wrote:
...
> > So taking your example:
> >
> > Event happens and gets delivered to the framework
> >
> >      framework selects A because it is in the foreground
> >
> >      if (A is frozen)
> >         unfreeze(A)
> >
> >      deliver_event_to(A)
> >
> > It's that simple.
> >
> =

> That is too simple. You also have to prevent A from being frozen while
> it is processing the event or the result would be the same as if it
> was frozen beforehand.

Well, the freezing of the "untrusted" part of user space needs to be trigge=
red
somehow in the first place.  Whatever mechanism is used for that, there sho=
uld
be a way to tell it to not to freeze the "untrusted" part of user space for=
 a
while.  Yes, it is similar to wakelocks, but I think it can be implemented
entirely in user space.

So, in general, the "trusted" app that needs an "untrusted" one to handle s=
tuff
will take a "freeze lock" to prevent the power manager from freezing the
"untrusted" part of user space (that will also cause it to thaw these tasks=
 if
they are frozen at the moment) and will release the "freeze lock" when it's
done with its job.  You can use timeouts and whatever you like with that and
the kernel doesn't have to participate in that (except for carrying out the
low-level freezing and thawing of the "untrusted" tasks at the power manage=
r's
request).

Rafael
