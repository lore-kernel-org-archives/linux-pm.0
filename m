Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83633CCFAF;
	Fri, 20 Mar 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026168; cv=none; b=rjWBrWAnZxbWkiOuX6BRb+V+hfSoosv9jmGgT6vJVSRdkBTa6lDpHOHLpWhGtLpsG9VsInMFEOmgO20CiwJuI37yKqLuyv8nPaBUyqLzkxOl12eiCSD7l/MBlpa3FasCUdWcr2M697p4qPNyRXKRlJ8W7guaJwUHVJgBUdvhszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026168; c=relaxed/simple;
	bh=mtXj/5WcTX/XFolbT4MOXQ239Cv99tIh0Jepn1ieNYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xbpy/FVXFHkIcnS21kw5Znv/S5GL0hSIWu+VxP6DDmBp8hQUxo63+beEZ3Xd6g2clK1UAzx9PDgeHaV3R0M4VmdfWPLhQI7/uCa34X/mXz4o25N4noMrFYKzZokynY93GlV9Xzs52NFIyh1nbf/8EsVC6o4MdwOckjmggPI9ohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U29s6+5q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U29s6+5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774026167; x=1805562167;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mtXj/5WcTX/XFolbT4MOXQ239Cv99tIh0Jepn1ieNYo=;
  b=U29s6+5qM5xLyWXovy09cjRuuLl7VpWoM/yQJQylvcNNtBATJCVVpbmZ
   HRKGRw0ZKdfUqcaJA7M7Vc5FzLD+IM1ICI02AIXo1Cs6ShuysD+ORGLrI
   fiUqvp7HKyxVA2ZIx4kIWuS2VU2x4t9d7UQoB4pk6ElPNF4vpgyE4+LNS
   i/CkXyRtL5M97ZMtqpR++bHojuWiXVYhayw1Fc6PNNH9j6NpW4QFkIEEH
   cCRJp9QZdV49UUbVaf19c9bPKk4I8lzLz22x8GF5R9Toy+EOKpzugoCgn
   kUcXZp+uNeQK5jVfSdTUqEPKU7CYhX8l7e3aWqI3pp2D8e9VHMQm6y2Ad
   w==;
X-CSE-ConnectionGUID: Gpf7q11NR/GzRYVqupJmOg==
X-CSE-MsgGUID: uEQL6q5KSHyolymOUpV1Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="97736727"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="97736727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:02:46 -0700
X-CSE-ConnectionGUID: i5zJ5kYiRPmiL9NcJGWVMg==
X-CSE-MsgGUID: C0rcFy97SACuUF429wqZ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222436540"
Received: from unknown (HELO [143.181.48.233]) ([143.181.48.233])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:02:46 -0700
Message-ID: <43d464a89afdf955282ffe3ce0c5acd50e047500.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/6] powercap: intel_rapl: Move primitives to
 interface drivers
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  "Rafael J . Wysocki"	 <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 20 Mar 2026 10:02:45 -0700
In-Reply-To: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: 
	<20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 11:53 -0700, Kuppuswamy Sathyanarayanan wrote:
> RAPL supports multiple interfaces (MSR, MMIO, and TPMI), each with
> their
> own register layouts and bitmask definitions. Currently, the
> primitive
> tables and bitmasks for all three interfaces live in the common
> driver,
> which requires interface-specific handling logic in shared code and
> makes
> the common layer unnecessarily complex.
>=20
> This series cleans this up by moving each interface's primitive
> definitions into its own driver, so the common driver no longer needs
> to
> know anything about per-interface register layouts.
>=20
> All patches are no-functional-change refactoring.
>=20
> This series is based on top of the earlier RAPL cleanup series:
>=20
> =C2=A0
> https://lore.kernel.org/linux-pm/20260212233044.329790-1-sathyanarayanan.=
kuppuswamy@linux.intel.com/T/#t
>=20

For whole series:

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>



> Patch Summary:
> Patch 1/6: Remove unused AVERAGE_POWER primitive and
> RAPL_PRIMITIVE_DERIVED
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flag from th=
e common driver.
> Patch 2/6: Remove other unused macro definitions from the common
> driver.
> Patch 3/6: Move struct rapl_primitive_info, enum unit_type, and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PRIMITIVE_IN=
FO_INIT macro to intel_rapl.h to allow
> interface
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers to d=
efine their own primitive tables.
> Patch 4/6: Move TPMI primitive definitions and associated bitmasks
> into
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the TPMI int=
erface driver.
> Patch 5/6: Move MMIO primitive definitions and associated bitmasks
> into
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the MMIO int=
erface driver.
> Patch 6/6: Move MSR primitive definitions and associated bitmasks
> into
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the MSR inte=
rface driver.
>=20
> Kuppuswamy Sathyanarayanan (6):
> =C2=A0 powercap: intel_rapl: Remove unused AVERAGE_POWER primitive
> =C2=A0 powercap: intel_rapl: Remove unused macro definitions
> =C2=A0 powercap: intel_rapl: Move primitive info to header for interface
> =C2=A0=C2=A0=C2=A0 drivers
> =C2=A0 powercap: intel_rapl: Move TPMI primitives to TPMI driver
> =C2=A0 thermal: intel: int340x: processor: Move MMIO primitives to MMIO
> =C2=A0=C2=A0=C2=A0 driver
> =C2=A0 powercap: intel_rapl: Move MSR primitives to MSR driver
>=20
> =C2=A0drivers/powercap/intel_rapl_common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 206 ----------------
> --
> =C2=A0drivers/powercap/intel_rapl_msr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 99 +++++++++
> =C2=A0drivers/powercap/intel_rapl_tpmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 53 +++++
> =C2=A0.../int340x_thermal/processor_thermal_rapl.c=C2=A0 |=C2=A0 72 +++++=
+
> =C2=A0include/linux/intel_rapl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 33 ++-
> =C2=A05 files changed, 254 insertions(+), 209 deletions(-)
