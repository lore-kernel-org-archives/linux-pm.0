From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Wed, 24 May 2017 18:16:05 +0000
Message-ID: <BN6PR1201MB0131CA87635E77604CE1FDE1F8FE0@BN6PR1201MB0131.namprd12.prod.outlook.com>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
 <20170523122439.GA7483@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:4443
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933130AbdEXSQI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 May 2017 14:16:08 -0400
In-Reply-To: <20170523122439.GA7483@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Tuesday, May 23, 2017 8:25 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-pm@vger.kernel.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; rjw@rjwysocki.net; len.brown@intel.com
> Subject: Re: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on
> AMD systems
>=20
> On Wed 2017-05-17 09:20:19, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > AMD systems support the Monitor/Mwait instructions and these can be
> > used for ACPI C1 in the same way as on Intel systems, with appropriate
> > BIOS support.
> >
> > Allow ffh_cstate_init() to succeed on AMD systems and make the Cstate
> > description vendor-agnostic.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/kernel/acpi/cstate.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/acpi/cstate.c
> > b/arch/x86/kernel/acpi/cstate.c index 8a908ae..4c5dd5d 100644
> > --- a/arch/x86/kernel/acpi/cstate.c
> > +++ b/arch/x86/kernel/acpi/cstate.c
> > @@ -109,7 +109,7 @@ static long
> acpi_processor_ffh_cstate_probe_cpu(void *_cx)
> >  			cx->type);
> >  	}
> >  	snprintf(cx->desc,
> > -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > +			ACPI_CX_DESC_LEN, "ACPI FFH X86 MWAIT 0x%x",
> >  			cx->address);
> >  out:
> >  	return retval;
>=20
> Are you sure no userspace depends on word "INTEL" there?
>=20

So far I've only seen this description printed by cpupower, and it's just f=
or
information.

> Does it make sense to include "X86" there?

I think so, since MWAIT is available on systems from both Intel and AMD.
Also, this FFH implementation can be shared by both vendors.

Though, as I said above, this description seems to be purely informational,
so it's probably not significant either way. I can remove this if preferred=
.

Thanks,
Yazen
