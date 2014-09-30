From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Bug#763320: linux-image-3.16-2-amd64: intel_idle enabled for
 Intel Atom S1260, causes high CPU temperature when idle
Date: Tue, 30 Sep 2014 07:56:45 +0200
Message-ID: <542A461D.9060900@siemens.com>
References: <20140929095709.3255.93208.reportbug@izoard.lan> <1412035987.9388.72.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:55325 "EHLO thoth.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbaI3GPw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 02:15:52 -0400
In-Reply-To: <1412035987.9388.72.camel@decadent.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>, Len Brown <len.brown@intel.com>
Cc: Christophe Thil <christophe@thil.de>, 763320@bugs.debian.org, linux-pm@vger.kernel.org

On 2014-09-30 02:13, Ben Hutchings wrote:
> On Mon, 2014-09-29 at 11:57 +0200, Christophe Thil wrote:
>> Package: src:linux
>> Version: 3.16.3-2
>> Severity: normal
>>
>> Dear Maintainer,
>>
>> with Kernel 3.16, intel_idle is enabled for the Intel Atom S1260 CPU
>> (Centerton SoC). This leads to a +20=C2=B0C temperature increase whe=
n the CPU
>> is idle, exceeding the 100=C2=B0C alarm threshold for passive cooled=
 systems
>> like the Supermicro X9SBAA-F.
>>
>> With 3.14, intel_idle was blacklisted for this CPU, which runs fine.=
 If
>> 3.16 is booted with intel_idle.max_cstate=3D0 processor.max_cstate=3D=
0,
>> which disables the intel_idle, the CPU also stays cool.
> [...]
>=20
> It looks like the relevant change is:
>=20
> commit acead1b0fac5b10d0ae3f1cc5f7820b9f9f924f5
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Sat Jan 25 22:24:22 2014 +0100
>=20
>     intel_idle: Add CPU model 54 (Atom N2000 series)
>    =20
>     Add CPU ID for Atom N2600/N2800 processors. Datasheets indicate s=
upport
>     for this, detailed information about potential quirks or limitati=
ons are
>     missing, though. So we just reuse the definition for the previous=
 ATOM
>     series. [...]
>=20
> as those processors are part of the same Atom generation as Centerton=
=2E
>=20
> I think that more specific ID matching is required here.

Hmm, I would check first if the Centerton series really has the same
model ID (0x36) as the Cedarview. If they do, what other means of
differentiation do we have?

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
