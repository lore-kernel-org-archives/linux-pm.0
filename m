From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Tue, 14 Feb 2006 21:17:30 +0100
Message-ID: <200602142117.31232.rjw@sisk.pl>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <43F216FE.7050101@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 14 February 2006 18:44, Thomas Renninger wrote:
> Pavel Machek wrote:
> > On P=E1 10-02-06 09:06:43, Stefan Seyfried wrote:
> >> On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
> >>> The included patch adds support for power management methods to r=
egister=20
> >>> callbacks in order to allow drivers to check if the system is on =
AC or=20
> >>> not. Following patches add support to ACPI and APM. Feedback welc=
ome.
> >> Ok. Maybe i am not seeing the point. But why do we need this in th=
e kernel?
> >> Can't we handles this easily in userspace?
> >=20
> > Some kernel parts need to now: for example powernow-k8: some
> > frequencies are not allowed when you are running off battery. [Just
> > now it is solved by not allowing those frequencies at all unless AC=
PI
> > is available; quite an ugly solution.]
> >=20
> Allowed CPUfreqs are exported via _PPC.
> This is why a lot hardware sends an ac_adapter and a processor event
> when (un)plugging ac adapter.
> Limiting cpufreq already works nice that way.
>=20
> AMD64 laptops are booting with lower freqs per default until they are
> pushed up, so there shouldn't be anything critical?

This is not true as far as my box is concerned (Asus L5D).  It starts w=
ith
the _highest_ clock available.

> For the brightness part, I don't see any "laptop is going to explode"
> issue.
> I always hated the brightness going down when I unplugged ac on M$

Currently I have the same problem on Linux, but I don't know the soluti=
on
(yet).  Any hints? :-)

Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
