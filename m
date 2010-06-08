From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Tue, 8 Jun 2010 11:11:39 +0200
Message-ID: <201006081111.39333.rjw__22179.6926147819$1275988798$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006061555.38526.rjw@sisk.pl>
	<AANLkTilwE8-9yi6gTI-Cx8etIX1Q6kzKobiIxtSW2Sb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilwE8-9yi6gTI-Cx8etIX1Q6kzKobiIxtSW2Sb9@mail.gmail.com>
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
Cc: tytso@mit.edu, Andrew Morton <akpm@linux-foundation.org>, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 June 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/6 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Sunday 06 June 2010, Arve Hj=F8nnev=E5g wrote:
... =

> If individual processes are frozen, we run into problems that we
> cannot run into if we freeze and thaw all processes.

Not individual processes, but the processes that don't use wakelocks in the
Android world all together.  And of course the approach has to be different,
because it's a different design, but I don't think there are any fundamental
issues you can't solve within this approach.

> >> The app that reads this event blocks suspend before reading it. If it =
was
> >> busy talking to a less trusted app when the event happened it still wo=
rks
> >> since all apps are running at this point.
> >
> > And how is this different from an approach with cgroup freezing?  Apps =
that
> > use wakelock within the current framework would use "freeze locks" to p=
revent
> > the "untrusted" part of user space from being frozen or to thaw it.  Wh=
ere's
> > the problem, then?
> >
> =

> They will not be able to get wakeup events directly from the kernel.
> If the kernel does not thaw processes when a wakeup event happens, the
> app may never get to the point where it grabs its wakelock.

The apps that use "freeze locks" (or wakelocks) are never frozen, so I don't
think this would be a problem.

Rafael
