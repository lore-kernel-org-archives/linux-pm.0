From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] IRQ: don't suspend nested_thread irqs over system suspend.
Date: Mon, 02 Feb 2015 23:50:17 +0100
Message-ID: <4516186.7hndmkLTuM@vostro.rjw.lan>
References: <20150131092545.33ed35b8@notabene.brown> <7535701.LlWsyNLDEC@vostro.rjw.lan> <20150131143747.7b9a4f10@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5981117.JpDRK7TbC6"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56109 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753728AbbBBW1a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 17:27:30 -0500
In-Reply-To: <20150131143747.7b9a4f10@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@jollamobile.com>


--nextPart5981117.JpDRK7TbC6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, January 31, 2015 02:37:47 PM NeilBrown wrote:
> On Sat, 31 Jan 2015 00:51:17 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net>
> wrote:
> 
> > On Saturday, January 31, 2015 12:06:37 AM Rafael J. Wysocki wrote:
> > > On Saturday, January 31, 2015 09:25:45 AM NeilBrown wrote:
> > > > 
> > > > Nested IRQs can only fire when the parent irq fires.
> > > > So when the parent is suspended, there is no need to suspend
> > > > the child irq.
> > > > 
> > > > Suspending nested irqs can cause a problem is they are suspended or
> > > > resumed in the wrong order.
> > > > If an interrupt fires while the parent is active but the child is
> > > > suspended, then the interrupt will not be acknowledged properly
> > > > and so an interrupt storm can result.
> > > > This is particularly likely if the parent is resumed before
> > > > the child, and the interrupt was raised during suspend.
> > > > 
> > > > Ensuring correct ordering would be possible, but it is simpler
> > > > to just never suspend nested interrupts.  This patch does that.
> > > 
> > > Clever. :-)
> > > 
> > > This is fine by me.  Thomas, what do you think?
> > 
> > It looks like I've overlooked a potential problem, though.
> > 
> > Can a nested interrupt be a wakeup one?  We won't set IRQD_WAKEUP_ARMED for it
> > then and may not handle wakeup correctly.
> > 
> 
> I only have a fairly narrow understanding of this stuff, but if you have
> nested interrupts, you would surely need the parent to be registered as a
> wakeup interrupt, else the device wouldn't wake and the nested interrupt
> would be ineffective until something else woke the device.
> 
> Very few files mention both '.irq_set_wake' and  'irq_set_nested'.
> 
> twl6040-irq.c has code to set irq_wake_enable  on the parent if any nested
> irqs have had irq_set_wake calls.
> tps6586x.c has something similar, but much simpler.
> arizona-irq.c and rc5t583-irq.c do the same as tps6586x.c
> 
> So I think that any nested interrupts which might want to be wakeup
> interrupts already deal with the issue, and I don't introduce a new problem
> here.

Fair enough.

I wonder if this means that it'll be useful to propagate IRQD_WAKEUP_STATE to
parents, then ...

Rafael

--nextPart5981117.JpDRK7TbC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJUz/8uAAoJEILEb/54YlRxCXoQAKMx1Esu8kyphoLDhe3tEy9y
K+mMMkMKtUSo0Sl/oxFZUIGf9w4wv2s9noFI5g8aAM6/JXsLVHg0K61sdJFeY4D2
dS3Ih1ob1Qtf+NpYWOitT3ZwzKKwx+jHwDYbn/RRCLGZ5BJac84/NPLbBauZ725h
wjkfwYxTaTPc9aNil+l2iYFObQrw4Dcqr+gPNGS0rfUfFb+vDv9ao123SMxTuCV/
pV9jtU6G0Ini2yXCUZ9xe5Lj866HUsmAjpUeYs+kMOk2DcPfhFwrZaETCteTUFvL
x6eeY0BNkTY+faMYlq5WNev8g9hoVS81DcLH6sPznVRFMqKy4ZUR/2jLESQsKXQ0
AhjoP5QZRuGRKyNL3Tj671D9v/GkX/FHeGIyTlTfeGEPtCvEM5ysxlVW2O+9pUOA
xNY2ImeeQ0P6Xs8POLHKgaeRKDmwh5guYndh9pcfGr7m18Dvn1hnC7J9qI6mxLuj
sWOHrlTpROzJBRBvmsnLLyhSgOn3KgaXAYkM48st6WkFv+CSloafNUAOVNS/652D
y4E8xWFsniJ6KSq+BH1Ln5VpFKO0QpqcSg4v/XVIfJI5wHqMv1AWrV1j9pmotUXo
RRfKLfmi2eLu8FzYqa+EIiwXem5ZqquVRA7JVYtDYijaFuRy0ZYB0dRfPCpuc+7j
koBbggtBq6kSlZFv2dcV
=KW+e
-----END PGP SIGNATURE-----

--nextPart5981117.JpDRK7TbC6--

