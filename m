From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 21:13:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006072110550.26784-100000__34061.1535044902$1275959805$gmane$org@netrider.rowland.org>
References: <AANLkTimf_nVcOZGi0x6nDtaO-FMVSLPrxDtOzQwKTB5P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimf_nVcOZGi0x6nDtaO-FMVSLPrxDtOzQwKTB5P@mail.gmail.com>
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
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Florian Mickler <florian@mickler.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > Remember that suspend takes place in several phases, the first of which
> > is to freeze tasks. =A0The phases can be controlled individually by the
> > process carrying out a suspend, and there's nothing to prevent you from
> > stopping after the freezer phase. =A0Devices won't get powered down, but
> > Android uses aggressive runtime power management for its devices
> > anyway.
> >
> > If you do this then the synchronization can be carried out entirely
> > from userspace, with no need for kernel modifications such as suspend
> > blockers. And since Android can reach essentially the same low-power
> > state from idle as from suspend, it appears that they really don't need
> > any kernel changes at all.
> >
> =

> I don't think this is true. If you stop after the freezer phase you
> still need all the suspend blockers that are held until user-space
> consumes an event, otherwise it never gets consumed since user-space
> is frozen.

No.  You don't need to hold any suspend blockers; you merely need to =

unfreeze userspace.  Once it is unfrozen, it will eventually consume =

the wakeup event.

What you _do_ need to do is to prevent userspace from getting frozen =

again too soon.  That's the purpose of the list of "active" wakeup =

sources.  So long as the power manager believes a source is still =

active, it won't freeze anything.

Alan Stern
