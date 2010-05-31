From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 16:26:17 -0700
Message-ID: <20100531232617.GF31155__755.968530620699$1275348428$gmane$org@gvim.org>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
	<AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<201005312338.55109.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005312338.55109.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, May 31, 2010 at 11:38:55PM +0200, Rafael J. Wysocki wrote:
> On Monday 31 May 2010, Arve Hj=F8nnev=E5g wrote:
> > 2010/5/29 Alan Stern <stern@rowland.harvard.edu>:
> > > On Sat, 29 May 2010, Arve Hj=F8nnev=E5g wrote:
> > >
> > >> > In place of in-kernel suspend blockers, there will be a new type o=
f QoS
> > >> > constraint -- call it QOS_EVENTUALLY.  It's a very weak constraint,
> > >> > compatible with all cpuidle modes in which runnable threads are al=
lowed
> > >> > to run (which is all of them), but not compatible with suspend.
> > >> >
> > >> This sound just like another API rename. It will work, but given that
> > >> suspend blockers was the name least objectionable last time around,
> > >> I'm not sure what this would solve.
> > >
> > > It's not just a rename.  By changing this into a QoS constraint, we
> > > make it more generally useful.  Instead of standing on its own, it
> > > becomes part of the PM-QOS framework.
> > >
> > =

> > We cannot use the existing pm-qos framework. It is not safe to call
> > from atomic context.
> =

> We've just merged a patch that fixed that if I'm not mistaken.  Mark, did=
 your
> PM QoS update fix that?
>

I'm pretty sure it can be called in atomic context, and if its not I'm
sure we can fix that.  It can be called in atomic context.  I don't
think it was ever a problem to call it in atomic context.  The problem it
had was that crappy list of string compares.  Thats been fixed.

--mgross
 =

> > Also, it does not have any state constraints, so it iterates over every
> > registered constraint each time one of them changes.
> =

> That's fixable IMO.
> =

> > Nor does is currently provide any stats for debugging.
> =

> That's why Alan is proposing to add that.
> =

> > The original wakelock patchset supported a wakelock type so it could
> > be used to block more then suspend, but I had to remove this because
> > it "overlapped" with pm-qos. So, yes I do consider this just another
> > rename.
> =

> It's an extension of an existing framework rather than an addition of a n=
ew
> one, with entirely new API and so on.  Extending existing APIs is much
> preferred to adding new ones, in general.
> =

> Rafael
