From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Enforce _PPC limits
Date: Wed, 25 May 2016 10:01:29 -0700
Message-ID: <1464195689.26461.63.camel@linux.intel.com>
References: <21572dff-ea5d-c0f3-6f48-66c9d38eda65@hpe.com>
	 <1464127905.4603.11.camel@linux.intel.com>
	 <cef22f9e-d60e-2065-e8a6-74c43e9b78f7@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30109 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671AbcEYRAv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 May 2016 13:00:51 -0400
In-Reply-To: <cef22f9e-d60e-2065-e8a6-74c43e9b78f7@hpe.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Linda,

[...]

> I guess I've lost track of what intel_pstate is doing these
> days.=C2=A0=C2=A0When it
> first came out, it totally disregarded ACPI information, which is why
> code
> was added to not load the driver on some platforms that are doing
> their
> own power management.=C2=A0=C2=A0The rationale for not using ACPI was=
 that ACPI
> couldn't express all the information necessary to describe the
> hardware
> capabilities.
>=20
> Now it is using ACPI information for some things, but not all things?
> Perhaps intel_pstate.txt could be updated to clarify that?
>  Depending
> on what the future is for intel_pstate and ACPI, I'm wondering if
> that
> vendor-specific code is no longer needed.
>=20
> This might be a nit but I'm also confused about whether it's really
> enforcing _PPC limits or _PSS.=C2=A0=C2=A0Are you actually limiting b=
ased on
> the _PPC value?
_PPC is an index into _PSS, the max frequency we will get from _PSS. We
are not enforcing any limits in _PSS. So if some P-State is missing in
_PSS, we will still select that P-State.
I don't know what vendor specific code does. I guess it does more than
just what acpi-cpufreq would have done.

I will check on the documentation part.

Thanks,
Srinivas


