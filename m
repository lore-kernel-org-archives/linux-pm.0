Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937646;
	b=UBvt4Ny5mdOlh2xIyHkB68wuJ60x913ErCPxgDZAe6ue2UI9VdV2V2hOqpAdfpDDJ6mi
	 gpwaLs65Q8I5xnzU4JLKvHUZoxLiz0Sgx56spQXJcXmf+macbopi/1C3Ln1iiLarK4+yq
	 17+B8Epxd4sEBOVh810ZIZ0Mrs2p/Tq5AHqn4UlIdEiaBVI9OOByTauc+wropJv24xpO7
	 zetNh2MqrltSxM+CzleH4aXldkUyKmiqBU+rhspEYy3vUY7JJhLmxkkovoV55rmyeMckF
	 1B2yf4g0tTk1fHFChLJuGOyDMEh+th7u/SIQ1xH6WSoDOZD/GYpXTGp3Hj0KfBTOM8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937646;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Zb59v2sMAZA60HbDEm7H2EQo8KOVwN9+aHTMOXk9+RE=;
	b=ubfJTdrWo+djpI91onK1oBip8rfAk1sTYViXYxSBHLVDyC9YwR4myjkH+dUwjmmGB30P
	 BSF3IyRKlRzxt994v7hYDwJ3pQFyMciYfrqKS0zD0rcGxu3cB4dUESveVVIJ9+nwJZhug
	 dA8+ymGlM8O0hhF86OtiW7gbaTm7ijKY13iJSL5yDZEC/AYPMsNHk+nERLqpIZPbMHdFV
	 Dh4i/QkWYMtegQ29z6K0LhNtcAnI8ZnF/68fzUPQp6stFj12yz5XrbIiDdP8i2YGIH3x5
	 9TmEIOBBZ+9+c5mdfITN36By3xJm131T8izJqSE12iTVYBQ8vGaVl11yx42k1V4RFag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eBlhIYX8;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD40606A33B
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 17:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD40606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eBlhIYX8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794937647; x=1826473647;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Zb59v2sMAZA60HbDEm7H2EQo8KOVwN9+aHTMOXk9+RE=;
  b=eBlhIYX8CJxKBFQp3gh/hQFc/p/XhecOt3RcOUuf5ncGYPUNUhcRKJWk
   f0GNjIh59NfwaWgTnrkLzf6ZqKBYtVYe7qiXBmcarc6n3BAxlB8yJ5YLk
   Do3Hum21jgdbQEwRYU3zaVF4p+HxojD+bS2ieX2P8gwCYS0NIzzG7PkOU
   IjDPYWafB5J/2UI61SIxfpc8zKv6HEuLxSOxHwuqw+DjUh80nmrfz7pjQ
   zXDbNtVOGVSyzplqHoUekRWzqY2BG+jsZ7ai1g/jQEno7C9pB/aPL5I3T
   kDnE9fM4Im8dFPx7Hs+xq9PtPnEn3yheKeXTEBCzYFOUIkHjfCzvVjc3s
   A==;
X-CSE-ConnectionGUID: 8D0uVOh6TpmrW8EDlNuQCg==
X-CSE-MsgGUID: FQtGKS/DStSjcZi4PQ/iHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3754010"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3754010"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:47:26 -0800
X-CSE-ConnectionGUID: v9w3P4hKTaqMkIGmhOyKew==
X-CSE-MsgGUID: nyOvLl35RxKkinNoL58HNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10274542"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:47:26 -0800
Message-ID: <c4dde5279405d4724ab1043e2884f29051f69f11.camel@linux.intel.com>
Subject: Re: AW: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615)
 through powercap?
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Lars Schellhas van Kisfeld
	 <lars.schellhas-van-kisfeld@schellhasconsulting.de>, 
 "linux-pm@vger.kernel.org"
	 <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Date: Tue, 17 Nov 2026 09:47:25 -0800
In-Reply-To: <BEZSPRMB0002E04ECF84B3BD99C4B68DE87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
References: 
	<BEZSPRMB000259539D5BE9BD203C5455E87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
	 <3435bb0b801bd63f989b04073b747c90c1ce4af5.camel@linux.intel.com>
	 <BEZSPRMB0002E04ECF84B3BD99C4B68DE87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
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

On Tue, 2026-11-17 at 16:26 +0000, Lars Schellhas van Kisfeld wrote:
> Hi Srinivas,
>=20
> thanks for the quick and clear answer. That makes sense: without
> public documentation the field meanings can=E2=80=99t be verified, and I
> don=E2=80=99t want to push an interface upstream that might behave
> differently on other generations. I won=E2=80=99t send a patch.
>=20
> For now I=E2=80=99ll keep the access in user space, restricted to the mod=
els
> I have measured, and I=E2=80=99ll leave all bits except the power limit f=
ield
> untouched.
>=20
> If Intel ever documents 0x615 (or can tell me that it is stable
> across client generations), I=E2=80=99d be glad to revisit this.
>=20
We continually monitor for stable interfaces. If it ever becomes
stable, will be glad to revisit.

Thanks,
Srinivas


> Best regards,
> Lars
>=20
> ________________________________________
> Von: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> Gesendet: Dienstag, 17. November 2026 16:59
> An: Lars Schellhas van Kisfeld
> <lars.schellhas-van-kisfeld@schellhasconsulting.de>;
> linux-pm@vger.kernel.org=C2=A0<linux-pm@vger.kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Zhang Rui
> <rui.zhang@intel.com>
> Betreff: Re: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615)
> through powercap?
> =C2=A0
> Hi Lars,
> On Tue, 2026-11-17 at 10:27 +0000, Lars Schellhas van Kisfeld wrote:
> > Hi,
> > before writing a patch I'd like to ask whether this would be
> > welcome.
> >=20
> > Background: I'm working on a user-space daemon that applies the
> > Windows
> > power configuration of Microsoft Surface devices on Linux [1]. On
> > Windows,
> > Intel DTT writes MSR 0x615 dynamically as a platform peak limit. On
> > a
> > Surface Book 3 (Ice Lake) the firmware sets it to 65 W (enabled);
> > Windows
> > raises it to 100 W on AC. powercap has no constraint for it, so the
> > daemon
> > writes 0x615 through /dev/cpu//msr, which needs CAP_SYS_RAWIO,
> > fails
> > under
> > lockdown and triggers the "unrecognized MSR" warning.
> >=20
> > What I measured: on the SB3, 0x615 binds on platform (psys) power,
> > not on
> > package power. With 20 W in bits 14:0 and the enable bit as found,
> > psys
> > power under all-core load drops from ~35 W to ~18 W. Restoring the
> > original
> > value works. A tester saw the same write, bind and restore on an
> > Alder Lake
> > Surface Pro 9. coreboot also treats 0x615 as PsysPL3, next to
> > 0x65C.
> >=20
> > Questions:
> > 1. Is 0x615 PsysPL3 (platform domain) on all client parts that have
> > it, and
> > =C2=A0=C2=A0=C2=A0 is its layout documented publicly (time window, duty=
 cycle in
> > bits
> > =C2=A0=C2=A0=C2=A0 30:24, lock bit 31)? I couldn't find 615H in the pub=
lic SDM.
>=20
> This is not documented in SDM. So, will be difficult to add to Linux
> kernel. When not documented, it is difficult to what each fields mean
> and can change gen to gen.
>=20
> Thanks,
> Srinivas
>=20
>=20
> > 2. Would you accept a third constraint on the psys domain for it,
> > opt-in
> > =C2=A0=C2=A0=C2=A0 per CPU model like msr_pl4_support? Duty cycle would=
 stay
> > untouched.
> > 3. Any preference for the constraint name? "peak_power" is taken by
> > PL4.
> >=20
> > If this sounds reasonable, I'd send a patch for the models I can
> > verify,
> > and only those.
> > Thanks,
> > Lars
> >=20
> > [1] https://github.com/larsschellhas/linux-surface-power
