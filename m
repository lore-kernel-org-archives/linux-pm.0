From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] s2ram: warn when interrupts should be disabled but are not
Date: Sun, 13 Apr 2008 22:24:27 -0700
Message-ID: <200804132224.27792.david-b@pacbell.net>
References: <20080412095311.GA1729@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752021AbYDNFYl@vger.kernel.org>
In-Reply-To: <20080412095311.GA1729@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 April 2008, Pavel Machek wrote:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0WARN_ON(!irqs_disabled(=
));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D drv->suspend=
(sysdev, state);

Wouldn't it be better to assert the warning AFTER the
driver had a chance to screw it up?  (On the resume
side of things too.)

We know IRQs were disabled on entry to the loop.
If something went wrong it was some goofy driver.
Best warn about it ASAP instead of *maybe* getting
a warning before the next driver (if there is one).

And if you're concerned about such issues, I'd think
similar warnings would be done in suspend_late() and
resume_early() support...

- Dave
