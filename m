From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sun, 30 May 2010 11:43:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005301134530.19555-100000__16329.074293799$1275234296$gmane$org@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 29 May 2010, Alan Stern wrote:

> On Sat, 29 May 2010, Arve Hj=F8nnev=E5g wrote:

> > > =A0 =A0 =A0 =A0for (;;) {
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (any IPC requests remain)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handle them;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (any processes need to prevent susp=
end)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write "qos" to /sys/po=
wer/state;
> > > =A0 =A0 =A0 =A0}
> > >
> > > The idea is that receipt of a new IPC request will cause a signal to =
be
> > > sent, interrupting the sleep or the "qos" write.
> > =

> > What happen if the signal is right before (or even right after)
> > calling write "qos". How does the signal handler stop the write?
> =

> You're right, this is a serious problem.  The process would have to
> give the kernel a signal mask to be used during the wait, as in ppoll
> or pselect.  There ought to be a way to do this or something
> equivalent.

Okay, here's a possible solution:

	char arg[20];

	signal_handler()
	{
		arg[0] =3D 0;
	}


	In the main loop:

	...
	mask signals;
	if (we decide to start a QoS-based suspend) {
		strcpy(arg, "qos");
		unmask signals;
		write arg to /sys/power/state;
	}

It's hacky but I think it will work.

A more straightforward approach is to give processes the ability to =

register their own QoS constraints.  This could be done via a custom =

driver as Brian suggested or by adding a new system call as Alan Cox =

suggested.  Then the power manager could be split into two threads, one =

of which handles IPC requests and manages QoS constraints, while the =

other repeatedly attempts to initiate QoS-based suspends.

Alan Stern
