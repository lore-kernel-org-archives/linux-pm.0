From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Enable PPC enforcement
 for servers"
Date: Thu, 02 Jun 2016 15:05:21 -0700
Message-ID: <1464905121.3970.67.camel@linux.intel.com>
References: <1464828117-6534-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <2942391.Y8jFCPZgiC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7802 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259AbcFBWDk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 18:03:40 -0400
In-Reply-To: <2942391.Y8jFCPZgiC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On Fri, 2016-06-03 at 00:00 +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 01, 2016 05:41:57 PM Srinivas Pandruvada wrote:
> >=20
> > This change reverts
> > 'commit 2b3ec7650584 ("cpufreq: intel_pstate: Enable PPC
> > enforcement for
> > servers")'
> >=20
> > Intel P State uses max P-State as the max turbo P-State. This max
> > P-State
> > can be limited by ACPI _PSS table entry 0. After
> > 'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC
> > limits")''
> > the _PSS table entry[0] will be used to cap max performance for
> > enterprise and performance server by default.
> >=20
> > Even though this is correct processing, but when the performance
> > results
> > are compared with the version before the above commit, then
> > obviously the
> > results will be worse, if the _PSS table entry 0 is not the max
> > turbo
> > P-State.
> >=20
> > So to minimize impact on performance, this revert will disable the
> > default
> > enforcement of ACPI _PSS and ACPI _PPC. So this feature can only
> > only be
> > explicitly activated by kernel command line
> > intel_pstate=3Dsupport_acpi_ppc
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> Thanks for the revert, but I'm wondering if we can explore one more
> option.
>=20
> Namely, if _PSS doesn't contain the turbo state, but we know the
> turbo range is
> there from the CPU, we can still use it and interpret _PPC for the
> max state as
> a permission to go into the turbo range.
>=20
> What do you think?
Looks like a good idea. I will experiment. What is your deadline for
-rc2 fixes?
It will give me more time to experiment and test.

Thanks,
Srinivas

>=20
> Thanks,
> Rafael
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
