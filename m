From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Fri, 10 Feb 2006 13:32:59 +0100
Message-ID: <20060210123259.GB18577@suse.de>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de> <20060210121913.GA4974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060210121913.GA4974@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 10, 2006 at 01:19:13PM +0100, Pavel Machek wrote:
> On P=E1 10-02-06 09:06:43, Stefan Seyfried wrote:

> > Ok. Maybe i am not seeing the point. But why do we need this in the=
 kernel?
> > Can't we handles this easily in userspace?
>=20
> Some kernel parts need to now: for example powernow-k8: some

we can tell them from userspace.

> frequencies are not allowed when you are running off battery. [Just
> now it is solved by not allowing those frequencies at all unless ACPI
> is available; quite an ugly solution.]

And this is a reason to include it in the kernel?
Pavel? Is it you? What have they done to you? ;-)

I mean - we are moving suspend and everything to userspace, so i wonder
why this has to be in kernel.
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write.=
"
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Co=
hen
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
