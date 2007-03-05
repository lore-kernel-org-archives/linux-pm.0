From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [patch] KVM: T60 resume fix
Date: Mon, 5 Mar 2007 15:26:25 +0200
Message-ID: <20070305132625.GA5311@mellanox.co.il>
References: <20070302080441.GA12785@elte.hu> <20070302102018.GA11549@elte.hu>
	<20070302102216.GA13575@elte.hu> <45E93012.4000100@qumranet.com>
	<20070305082251.GA23366@elte.hu>
	<45EBD9BC.4030801@qumranet.com> <20070305084449.GA1706@elte.hu>
	<20070305085718.GA2513@elte.hu>
	<20070305125425.GA4350@mellanox.co.il>
	<20070305125008.GA21735@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070305125008.GA21735@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Avi Kivity <avi@qumranet.com>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> Quoting Ingo Molnar <mingo@elte.hu>:
> Subject: Re: [patch] KVM: T60 resume fix
> =

> =

> * Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> =

> > > suspend/resume works fine now and there are no warning messages =

> > > whatsoever (with suspend simulation). Thanks Avi!
> > =

> > I just tried Ingo's .config and it hangs on resume for me (with =

> > suspend to memory).
> =

> could you try 's2ram' from http://suspend.sf.net ? It's basically =

> equivalent to 'echo mem > /sys/power/state', but you can usually also =

> see the reason why it doesnt resume, on the vga console. (by default the =

> kernel doesnt resume the t60's vga properly)

OK, I'll give it a try. Do I have to shut down X or is it enough to
switch to another VT?

> on my box resume works, but it's incredibly slow.

I guess it is possible that what I mistook for a hang was actually an incre=
dibly
slow system, and that it would resume, eventually. I waited for 5 min and g=
ave
up.

> Takes a few minutes to have total effect.

I have same here with my old .config (2-3 min).

However, after resume was completed, system would hang on the *next* suspen=
d to
ram.

Ingo, do you see this behaviour, or can you suspend/resume any number of ti=
mes?

-- =

MST
