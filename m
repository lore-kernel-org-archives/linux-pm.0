From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Fri, 10 Feb 2006 13:19:13 +0100
Message-ID: <20060210121913.GA4974@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060210080643.GA14763@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On P=E1 10-02-06 09:06:43, Stefan Seyfried wrote:
> On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
> > The included patch adds support for power management methods to reg=
ister=20
> > callbacks in order to allow drivers to check if the system is on AC=
 or=20
> > not. Following patches add support to ACPI and APM. Feedback welcom=
e.
>=20
> Ok. Maybe i am not seeing the point. But why do we need this in the k=
ernel?
> Can't we handles this easily in userspace?

Some kernel parts need to now: for example powernow-k8: some
frequencies are not allowed when you are running off battery. [Just
now it is solved by not allowing those frequencies at all unless ACPI
is available; quite an ugly solution.]

								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted.=
=2E.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
