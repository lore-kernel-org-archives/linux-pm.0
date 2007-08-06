From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] kexec: fix pci device initialization fail
	after kexec (2.6.23-rc2). (Related to e1000 doesn't resume
	properly from standby)
Date: Mon, 6 Aug 2007 13:54:35 -0700
Message-ID: <200708061354.35648.david-b__18021.5063541711$1186433734$gmane$org@pacbell.net>
References: <b25c3fa70708060642w1b3a326q792a81fdaa3036c5@mail.gmail.com>
	<b25c3fa70708060850p26b7b3e6yb8a523a479c714c0@mail.gmail.com>
	<200708062048.37160.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708062048.37160.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Simon Arlott <simon@fire.lp0.eu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joonwoo Park <joonwpark81@gmail.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday 06 August 2007, Rafael J. Wysocki wrote:
> Section 5.4.1 of PCI PM 1.1. spec is about D3_hot. =A0Specifically, it =
says
> that if a device in D3_hot is programmed to D0, it performs the equival=
ent of
> a warm reset. =A0IOW, this is supposed to happen if the current state i=
s D3_hot
> and the targed state is D0, which is covered by the code snippet above.

Actually, it's *allowed* to do a warm reset.  Not required.
And not all PCI devices will do such a reset.   Some of them
will return to D0_initialized ... not D0_uninitialized (where
uninitialized means "did the reset").

It's D3_cold where a (powerup) reset is *required*.

A common example would be a USB host controller.  If one of
those did a warm reset it'd trash all the connection state
which was carefully retained during sleep ... and there'd be
no point to supporting D3_hot rather than D3_cold.

As a rule of thumb, it's probably safe to assume that if
a device can generate wakeup events, it probably doesn't
trash all of its state when it resumes from D3_hot.

Of course, if it can generate wakeup events from D3_cold,
the difference between Vaux and Vcc power wells comes into
play.  The Vaux powered bits will retain state, while the
stuff powered by Vcc gets a powerup reset.

If it can't generate wakeup events, a PCI device has no
particular need to retain state after D3.  Implementors
can choose whichever is most convenient.

- Dave
