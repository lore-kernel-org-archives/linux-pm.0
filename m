From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 14:09:04 +0200
Message-ID: <20100528140904.0d0d4878__4060.3002220907$1275048600$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	<20100527173118.GE2468@srcf.ucam.org>
	<alpine.LFD.2.00.1005271959450.3032@localhost.localdomain>
	<20100528104415.1403541a@schatten.dmk.lab>
	<AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
	<20100528122521.3698a62e@schatten.dmk.lab>
	<AANLkTikumixQTaKvlyaxjZgfCZNZXFM9LySJ2YZ4OVZf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikumixQTaKvlyaxjZgfCZNZXFM9LySJ2YZ4OVZf@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: List <linux-omap@vger.kernel.org>, Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010 04:35:34 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:

> 2010/5/28 Florian Mickler <florian@mickler.org>:

> > It sounds like it could save some duplication of effort to integrate
> > suspend into the idle-framework. "Purpose-fulness" could be just
> > another measure of "idle".
> >
> =

> To me idle means that no threads are ready to run and no interrupts are p=
ending.

I misused the term "idle".  I tried to express this by "quoting" it.

> =

> I don't think we can plug suspend in as a cpu idle state. 1. we want
> to suspend even the cpu is not idle. 2. starting suspend will cause
> the cpu to not be idle.
> =


yeah. it would have to move out of the cpu-specific context. it would
be a more general "system-state" thing.

if the properties of the state's are well expressed, it does not matter
that starting suspend will cause the cpu to not be idle, because our
target-state(suspend) has better properties than any other state.

(or maybe there needs to be a "state-transition-in-flight" flag.)

if we take the "approximated duration of staying in that state" into
account, we could provoke the pm-framework to always suspend if no
constraint(i.e. blocker) is there.

But really. I think I can't implement something like that.
Also I really have _no_ idea how much work this would be.

_And_ I am not really shure if this is a better approach than the
current solution.

Just an idea. =


Cheers,
Flo
