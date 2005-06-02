From: Stefan Seyfried <seife@suse.de>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Thu, 02 Jun 2005 18:21:49 +0200
Message-ID: <429F321D.9000009@suse.de>
References: <1117524577.5826.35.camel@gaston>	<20050531101344.GB9614@elf.ucw.cz>	<1117550660.5826.42.camel@gaston> <20050531212556.GA14968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261189AbVFBQWV@vger.kernel.org>
In-Reply-To: <20050531212556.GA14968@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:

> Anyway, it should not be arch-dependend. We need one good mechanism o=
f
> notifying userland, not one per architecture.

Yes.

>> Sure, ideally. However, existing X knows how to deal with APM events=
,
>> and thus APM emulation is an important thing to get something that
>> works. Pne thing I should do is consolidate PPC APM emu with ARM one=
 as
>> I think Russell improve my stuff significantly.
>=20
> Perhaps we need apm emulation on i386, too?

No. This is too ugly for words IMO. If we have one good mechanism of
notifying userland, X can use this mechanism. Let's kill APM, not keep
it alive.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."
