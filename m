From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Bisected] 3.7-rc1 can't resume (still present in 3.9)
Date: Fri, 12 Jul 2013 16:45:52 -0700
Message-ID: <51E09530.8030300@zytor.com>
References: <20130218155439.GA902@onny> <cfd96a3d-5834-4687-b9de-9f044f43b588@email.android.com> <20130223131856.GA682@onny> <51293A8B.5060107@zytor.com> <20130320143257.GA473@onny> <20130501170118.GB488@onny> <518151DD.106@zytor.com> <51DDC972.3010005@student.kit.edu> <51DDF4DF.4000902@zytor.com> <51E092FC.1030200@student.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42502 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289Ab3GLXqY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jul 2013 19:46:24 -0400
In-Reply-To: <51E092FC.1030200@student.kit.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?Q2hyaXN0aWFuIFPDvG5rZW5iZXJn?= <christian.suenkenberg@student.kit.edu>
Cc: Jonas Heinrich <onny@project-insanity.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 07/12/2013 04:36 PM, Christian S=C3=BCnkenberg wrote:
>=20
> Jonas tried your patch and it fixes suspend/resume on his T43, althou=
gh
> IMHO the safest approach would be to just add an exception for
> Vendor=3D=3DIntel && Family=3D=3D6 && Model=3D=3D13, or more generall=
y Vendor=3D=3DIntel
> && !supports_long_mode, as the same erratum also warns about wrmsr
> possibly not triggering a GP either.
> Anyways, at least on this specific MSR with the Pentium M Jonas teste=
d,
> it behaved correctly on every try, so I'd say your patch does the tri=
ck,
> thank you very much!
>=20

Using vendor matches is not really a great way to deal with things that
can better be handled analytically.

If WRMSR doesn't fault, it is not a problem...

> As a side note, I found a similar erratum #33 in "Pentium=C2=AE Proce=
ssor
> Specification Update" for Intel P54C (Family 5, Model 2), which would=
,
> supposed there are P54C systems with ACPI sleep/resume support, resul=
t
> in MSR 0 (P5_MC_ADDR) to be saved and restored instead of nonexistent=
 EFER.

Doesn't really matter, as we'd only read that one after an #MC.

	-hpa


