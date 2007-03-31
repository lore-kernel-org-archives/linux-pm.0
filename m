From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
Subject: Re: [4/4] 2.6.21-rc5: known regressions (v2)
Date: Sat, 31 Mar 2007 08:44:39 +0200
Message-ID: <1175323479.5550.70.camel@funkylaptop>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
	 <20070330214956.GQ14134@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932183AbXCaGol@vger.kernel.org>
In-Reply-To: <20070330214956.GQ14134@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tino Keitel <tino.keitel@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, pavel@suse.cz, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Le vendredi 30 mars 2007 =C3=A0 23:49 +0200, Adrian Bunk a =C3=A9crit :
> Subject    : MacMini doesn't come out of suspend to ram  (i386 clocke=
vents)
>              (CONFIG_HPET_TIMER)
> References : http://lkml.org/lkml/2007/3/21/374
> Submitter  : Fr=C3=A9d=C3=A9ric Riss <frederic.riss@gmail.com>
>              Tino Keitel <tino.keitel@gmx.de>
> Caused-By  : Thomas Gleixner <tglx@linutronix.de>
>              commit e9e2cdb412412326c4827fc78ba27f410d837e6e
> Status     : unknown

This one has been fixed by 399afa4fc9238fbae42116cf25a54671c0e8f56e.
Suspend to ram now works with HPET enabled (and regardless of the NO_HZ
setting).

Thanks!

=46red.
