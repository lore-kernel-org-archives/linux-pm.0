From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 22:32:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006072153030.27878-100000__1729.90034702725$1275964440$gmane$org@netrider.rowland.org>
References: <AANLkTikRSV5dFX10apUntFi4eJkRt645Iod91qrPk9gI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikRSV5dFX10apUntFi4eJkRt645Iod91qrPk9gI@mail.gmail.com>
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
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > It's true that under some exceptional circumstances the system would
> > never remove a wakeup source from the "active" list and then would
> > never go idle. =A0But exactly the same problem exists with wakelocks, if
> > the kernel activates a wakelock and there's no user process reading the
> > corresponding event queue.
> >
> =

> No, you have a different problem. If you open an input device and
> issue the ioctl to enable the suspend blocker that blocks while the

Um, the suspend blocker that is active while the queue is nonempty is
an in-kernel suspend blocker, right?  Not a userspace suspend blocker.  =

Hence it doesn't have to be enabled by an ioctl.  Or is this some part
of the whole wakelock design that hasn't yet been posted?  As far as I
know, you intended the in-kernel suspend blocker to be enabled whenever
the input device file is open.

> queue is not empty then don't read the event, that is a bug that is
> easy to fix.

I assume you mean "you open an input device but then fail to read from =

it".  When that happens the device's driver will activate its in-kernel =

suspend blocker, and since the input queue will never become empty, the =

suspend blocker will never be deactivated.  Yes, that's a bug.

> What you have is a race condition. If you read an event
> that occurred after you blocked the task freezing tasks will never get
> frozen again (until more events occur).

Sorry, I can't parse that sentence.  Could you rephrase it more =

grammatically?

It seems to say: "If you read an event that occurred after [something],
then tasks won't get frozen again until more events occur".  Which
doesn't make sense, firstly because in my scheme reading events has no
direct connection with freezing or unfreezing tasks, and secondly
because the occurrence of events doesn't cause tasks to be frozen --
just the opposite: occurrence of events _prevents_ tasks from being
frozen.

> We have multiple input devices and one thread reading from them. Do
> all input devices that can generate wakeup events share a wakeup
> source?

Basically, a wakeup source is a file descriptor that in your scheme,
some user process would read from in order to clear an in-kernel
wakelock.  Thus, if each of your input devices activates an in-kernel
wakelock that is cleared when a user process reads the device, then the
file descriptors for these input devices would each be considered a
wakeup source.

> It seems you would need a way to pass the wakeup source id to use from
> user space to the driver and for this to work

No, nothing needs to be passed from userspace to the kernel.  However =

the source ID (or a set of source IDs) does need to be passed to the =

power manager process, probably when the suspend blocker is created.

[On rereading this, I realized it might not have been clear that in my
scheme, suspend blockers have no in-kernel component.  They are
implemented entirely by IPC between the process owning the suspend
blocker and the power manager process.  Would it be less confusing if I
called them something else?]

> (ignoring the race if
> you allow multiple alarms per file) which seems like more work than
> using a suspend blocker.

It's not very much more: just one additional argument to the routine
that creates a suspend blocker.

I get the impression that you don't fully understand how my scheme is =

meant to work.  Would some additional explanation or examples help?

Alan Stern
