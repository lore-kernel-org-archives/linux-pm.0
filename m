From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT
Date: Tue, 19 Jul 2016 16:42:49 -0700
Message-ID: <1468971769.4150.12.camel@linux.intel.com>
References: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0iCouZ9xU8AOOL51RZZEsuRmY7fLLpidY+0mmoGB+R92Q@mail.gmail.com>
	 <CAJZ5v0gGfRsaAPDSMB=AKYNoGFgrf53MdibdwY7bauSp5PDpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17485 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbcGSXoi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 19:44:38 -0400
In-Reply-To: <CAJZ5v0gGfRsaAPDSMB=AKYNoGFgrf53MdibdwY7bauSp5PDpgw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Wed, 2016-07-20 at 01:40 +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 20, 2016 at 1:38 AM, Rafael J. Wysocki <rafael@kernel.org
> > wrote:
> >=20
> > On Wed, Jul 20, 2016 at 1:34 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >=20
> > > From: spandruv <spandruv@spandruv-mobl.jf.intel.com>
> > >=20
> > > The MSR MSR_HWP_INTERRUPT is valid only when CPUID.06H:EAX[8] =3D
> > > 1, so
> > > check for feature before accessing this MSR.
> > >=20
> > > Signed-off-by: spandruv <spandruv@spandruv-mobl.jf.intel.com>
> > Do you really want this in the S-o-b tag?
> Well, it isn't a valid address even, so it can't be here.
Resending, setup a new computer and forgot to add .gitconfig.



> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
