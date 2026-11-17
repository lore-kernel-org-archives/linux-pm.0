Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931150;
	b=Ez7A8aC2BaAaGHAwspnLsirM6Al3tA57Ktzf6FkIFIRZhcATonqMgQlDUlyM/50nGdo+
	 ocejVv+WrjCf4LvFNfSbPz0BALZc/lY0x726XBfW8wM1RP8DhtFniEuP6rpVVa5hrLwe2
	 mogfbg7st7dWxzpBXOWUd9+zqljnR9V2gkCuan0sgnF3zo7S/0ZNi4dwiVTrtDjvtiKOb
	 uvR+XIVE0daE2p6XyDQI87j6O/AmnOQoUr/dy12txiVebTY2tN/N09ZgzUSBtaL1C9dKF
	 lftVFYWulLkbj5Zb72jfMzBYwvAfkhKrWUggV0tZgXlYqTRLOa7bEuBu0pQ+ixtK1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931150;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=MO8dgrJcUIupioirzWqdAAfPqoIfWxoMYFNInic8L5M=;
	b=ctge2uid1pxhJDx/ezUNr0hXN6+hvJxlp8gqpJyRdNPoUwh09y1bsxF0FSbhm1zBVUbD
	 nnjAW4ntZyB0o9DZXsiE/dQaf5UzpD1I/GQfKJEGk+4ACZc1vi4Sz3wmYMtucp4jnSud9
	 ZbUlwpoPXqLdGJOrlLU5XNNYYugaUQN/bVvsLY5E5OQ0uXlT283U9wq4mxOXBpR6Zjss1
	 ZXAba4wPLb27qtsbpw7YKK7Ek5l+3m/KuR8ynb3jwSma9vcmTL1ek1rXsLJf3SVCHAvIV
	 E/1aNyW5tM4jANjswasF7qb7E5QIn/VX/ogVl+G/gQKo7owXjU8TlYMv6/V6sDI14Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cy92Nl0a;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC8606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 15:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cy92Nl0a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794931149; x=1826467149;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MO8dgrJcUIupioirzWqdAAfPqoIfWxoMYFNInic8L5M=;
  b=cy92Nl0aExh3Ox0rq5A2Z5fr7b6mQW4H6tcjjCtni68dp8NGzOlxAA2L
   rLVk5TJxW7ag/SSMetv/PHBxYEdTs03VqqKa4ul2icZ2Emj1z2DP7XKNV
   EwB031pMltzguRtiJZDXXX0/w6YhKy4hX7o4KPY5mE/wYwacXMke7kKGr
   thVa0c6QMswPn4CEqQPMF7fxlLehgrs0DWQM0zc7YeRM6muQvhEQDQiJv
   EMOpWbyWlaK0gP3JcmBaN7acwhWtgA0dnSlLcjTwL0ywB+jgdCby7TurK
   jGQqLq9hh4aQYRoKJmXAlgAurSUfkaca8WZmhJKxTHD6iu3qZ9OkKNLsm
   w==;
X-CSE-ConnectionGUID: 7aVdeUkBR2yIJvx8eP7hmA==
X-CSE-MsgGUID: udW3NRe2Sam7Tm+sxepOSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3743317"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3743317"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:59:06 -0800
X-CSE-ConnectionGUID: 4qthF8iYStaOUP7wB0y7gg==
X-CSE-MsgGUID: A2BNzoSjT9Wuu2AZgxM7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10125617"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.108.193]) ([10.125.108.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 07:59:05 -0800
Message-ID: <3435bb0b801bd63f989b04073b747c90c1ce4af5.camel@linux.intel.com>
Subject: Re: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615) through
 powercap?
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Lars Schellhas van Kisfeld
	 <lars.schellhas-van-kisfeld@schellhasconsulting.de>, 
 "linux-pm@vger.kernel.org"
	 <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Date: Tue, 17 Nov 2026 07:59:05 -0800
In-Reply-To: <BEZSPRMB000259539D5BE9BD203C5455E87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
References: 
	<BEZSPRMB000259539D5BE9BD203C5455E87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Lars,
On Tue, 2026-11-17 at 10:27 +0000, Lars Schellhas van Kisfeld wrote:
> Hi,
> before writing a patch I'd like to ask whether this would be welcome.
>=20
> Background: I'm working on a user-space daemon that applies the
> Windows
> power configuration of Microsoft Surface devices on Linux [1]. On
> Windows,
> Intel DTT writes MSR 0x615 dynamically as a platform peak limit. On a
> Surface Book 3 (Ice Lake) the firmware sets it to 65 W (enabled);
> Windows
> raises it to 100 W on AC. powercap has no constraint for it, so the
> daemon
> writes 0x615 through /dev/cpu//msr, which needs CAP_SYS_RAWIO, fails
> under
> lockdown and triggers the "unrecognized MSR" warning.
>=20
> What I measured: on the SB3, 0x615 binds on platform (psys) power,
> not on
> package power. With 20 W in bits 14:0 and the enable bit as found,
> psys
> power under all-core load drops from ~35 W to ~18 W. Restoring the
> original
> value works. A tester saw the same write, bind and restore on an
> Alder Lake
> Surface Pro 9. coreboot also treats 0x615 as PsysPL3, next to 0x65C.
>=20
> Questions:
> 1. Is 0x615 PsysPL3 (platform domain) on all client parts that have
> it, and
> =C2=A0=C2=A0=C2=A0 is its layout documented publicly (time window, duty c=
ycle in
> bits
> =C2=A0=C2=A0=C2=A0 30:24, lock bit 31)? I couldn't find 615H in the publi=
c SDM.

This is not documented in SDM. So, will be difficult to add to Linux
kernel. When not documented, it is difficult to what each fields mean
and can change gen to gen.

Thanks,
Srinivas


> 2. Would you accept a third constraint on the psys domain for it,
> opt-in
> =C2=A0=C2=A0=C2=A0 per CPU model like msr_pl4_support? Duty cycle would s=
tay
> untouched.
> 3. Any preference for the constraint name? "peak_power" is taken by
> PL4.
>=20
> If this sounds reasonable, I'd send a patch for the models I can
> verify,
> and only those.
> Thanks,
> Lars
>=20
> [1] https://github.com/larsschellhas/linux-surface-power
