From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Thu, 3 Jun 2010 21:54:50 -0700
Message-ID: <AANLkTikZP3bmckpfb_jUdG7qZO5W9DgpZ79ugtSZaEpt__13055.246594786$1275627397$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603232302.GA16184@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 3, 2010 at 4:23 PM, Ingo Molnar <mingo@elte.hu> wrote:
...
> =A0- Controlled auto-suspend: drivers (such as input) could on wakeup
> =A0 automatically set the 'minimum wakeup latency' value of wakee tasks t=
o a
> =A0 lower value. This automatically prevents another auto-suspend in the =
near
> =A0 future: up to the point the wakee task increases its latency (via the
> =A0 scheduler syscall) again and allows suspend again.
>

How do you clear the latency value in a safe way? If another wakeup
event happens right after your wakee task is done processing the last
event and decides to increase its latency, auto suspend will be
allowed even though you have an unprocessed wakeup event. Also how do
you know which task will read the event if it is not already waiting
for it?


> =A0 This means there will be no surprise suspends for a task that may tak=
e a
> =A0 bit longer than usual to finish its work. [ Detail: this would only b=
e done
> =A0 for tasks that have a non-default (non-infinity) task->latency value =
- to
> =A0 prevent the input driver from lowering latency values (and preventing
> =A0 future suspends) just because some unaware apps are running and using=
 input
> =A0 drivers. ]

Don't you need two inifinity values for this?

-- =

Arve Hj=F8nnev=E5g
