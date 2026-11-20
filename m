Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189015;
	b=3r+coM8Ot3cKnZeP3tAzmiKTQXya9UagRYcRl/eA5625TtUeG8hl6PEonqwifE3MAyWC
	 md9IXhlCwjLxFXskby7UbVkxw3y8zenkbkD8Qnx/XEVbSkU2Sj4rDvsFCIRgx0F+xLDXA
	 Ra+BC8bhOHzV/StV25YQHBG+/eBRIOXHptLEQBHk4Hrnjf1nnrZCJQUEp6AWAISmRZTnV
	 Xjnz6H/SDbo7PenTR0B57I8HPjbhwwkHtChE71pwnQE5TIyPM2rpkaJnJsDYX+3zXguuu
	 p2oIJaAYXM/wy44ze6qaDp1mv0aJbpVWDsX1tjWw5CHt2G8IHFB8JC2OwBFap2ku9rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189015;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=7KmBXSJwbLkc6zm80ZgtGjSBqv8Vr77sXePgwNVb9U4=;
	b=mez2v3Peiv7Ps4ReV6NUsOePYay3aYZ01a/JM8QddA4XH1U0liLhO2h9NrZ9Snx8dJWY
	 qiHJ0qh58U+tnUNi7d8Z5Y4Ljr+hmpDVp02T83YIsvum03MAyUjco4bxeAgcnwr57ZIjC
	 vPMvuwzy1FVzZwO6Pa8aKOrWAHWK+RVZgg2eaFsI59zR5BvsXsehlJIeA6SrTUFri57GN
	 mxv/fAlBh37o3eZrvyysEszx9cKPKD4UFpWO6qKGLTjEzSbf1mJUPkwNqvWt/uCxL6jgy
	 F76BlNJ2xtePASbKL/CwKTDULmmRFZIswQEm0OnLf3FLVeCAnVCX8QtKpW51tVyr8TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=edcTUfQl;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499760A2604
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A499760A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=edcTUfQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795189015; x=1826725015;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RAbsxB8sC9uVpjWoqa9Q+e6OwRDA2DglX8Lf+o2C4kU=;
  b=edcTUfQlDVNmSWV1OQHsOvMWlPoQ97j9hBsLBaL9AuVD12P/H1GVI3mF
   Xy4Ns86keFG1Hd6CV6vOogEf8+Z3eDWViyS0G7wRxtfnGj/KR628G3QOU
   WHBvKwsIJeNRqlBdwVzllPQOVOJhjxvT/4ZkUHohULx6G93YQaD2ZYnAt
   wVZphV1Hhq60yNY+HECvZmyFIXpJVqAfMisAL+SZ8n5piqMf57MfkHWfg
   d0qFK/FL4ASeCCI4mfFsQ2h/I5BTZIRotJbcRx869Zk1T3Ga6r5SsFctf
   hCl/mm0RqOa4v2bxHOnKqRvZu0k7McXOEUwt/3E6JHs7MsGe0SVca7pnZ
   g==;
X-CSE-ConnectionGUID: HYX/6xnURPiNj4Np1DNJ0Q==
X-CSE-MsgGUID: CY91kv7fRsyL15yuno/MjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4169190"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4169190"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:36:50 -0800
X-CSE-ConnectionGUID: I9zW7wmrTbyTVLgjYYMcnw==
X-CSE-MsgGUID: r5isLJqnRdOOq5xIzxtO9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10715068"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.9]) ([10.124.220.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:36:49 -0800
Message-ID: <cf4dd030efaa05939904042d211af7b564881ba8.camel@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Restore power limits after
 hibernation
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sebastien WALD <contact@sebastien-wald.fr>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org
Date: Fri, 20 Nov 2026 07:36:47 -0800
In-Reply-To: <20261120153039.33744-1-contact@sebastien-wald.fr>
References: <20261120153039.33744-1-contact@sebastien-wald.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 16:30 +0100, Sebastien WALD wrote:
> rapl_pm_callback() saves the package power limits on
> PM_SUSPEND_PREPARE
> and restores them on PM_POST_SUSPEND, but does nothing for
> hibernation.
>=20
> When the system resumes from hibernation, the boot that loads the
> image
> goes through the firmware again, which reprograms its default power
> limits. The values set from user space before hibernating are lost.
>=20
> On an MSI GS76 Stealth 11UH (Core i9-11900H), thermald sets PL1/PL2
> to
> 45 W/64 W. After resume from hibernation, PL2 reads 120 W, the
> firmware
> default, and stays there; thermald does not re-apply an unchanged
> target. Suspend-to-RAM is not affected, because of the existing
> save/restore.
>=20
> Handle PM_HIBERNATION_PREPARE and PM_POST_HIBERNATION in the same way
> as
> their suspend counterparts. The saved values live in kernel memory,
> so
> they are part of the hibernation image and available when
> PM_POST_HIBERNATION is delivered after the image has been restored.
>=20
> The problem was analysed, and this change written, with the help of
> an
> AI coding assistant (Claude); the analysis was checked against the
> driver source and against the behaviour of the machine above.
>=20
> Fixes: 52b3672c1354 ("powercap: add suspend and resume mechanism for
> SOC power limit")
> Signed-off-by: Sebastien WALD <contact@sebastien-wald.fr>


Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Notes (not for the changelog):
>=20
> Reported first to thermald, where Srinivas asked to take it to the
> kernel:
> https://github.com/intel/thermal_daemon/issues/621
>=20
> Testing, on 7.3.5 (CachyOS build, clang/ThinLTO):
>=20
> - Without the patch, PL2 of intel-rapl:0 reads 120 W after resume
> from
> =C2=A0 hibernation instead of 64 W (observed with thermald running; it
> does
> =C2=A0 not re-apply an unchanged target).
> - With the patch applied to the 7.3.5 driver, built out of tree (no
> =C2=A0 warnings with W=3D1) and loaded in place of the stock module,
> thermald
> =C2=A0 stopped and the limits written by hand:
> =C2=A0=C2=A0=C2=A0 before hibernation: intel-rapl:0 PL1=3D45 W PL2=3D64 W
> =C2=A0=C2=A0=C2=A0 after resume:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inte=
l-rapl:0 PL1=3D45 W PL2=3D64 W
> =C2=A0 The intel-rapl-mmio:0 limits were also unchanged across the cycle.
> - I have not run a control with the stock module and thermald
> stopped;
> =C2=A0 the "without" case above comes from the original thermald report.
> - checkpatch.pl reports no problem (apart from an unknown commit id,
> =C2=A0 since it was run outside a kernel tree).
>=20
> The machine runs an ACPI SSDT override for an unrelated firmware bug
> (\_SB.IETM._OSC references an undefined \_TZ.ETMD) and the out-of-
> tree
> nvidia and msi-ec modules, so the kernel is tainted (A, O, E). None
> of
> these touches the RAPL MSRs as far as I can tell.
>=20
> =C2=A0drivers/powercap/intel_rapl_common.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index f58649f..eb8c02a 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1878,9 +1878,11 @@ static int rapl_pm_callback(struct
> notifier_block *nb,
> =C2=A0{
> =C2=A0	switch (mode) {
> =C2=A0	case PM_SUSPEND_PREPARE:
> +	case PM_HIBERNATION_PREPARE:
> =C2=A0		power_limit_state_save();
> =C2=A0		break;
> =C2=A0	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> =C2=A0		power_limit_state_restore();
> =C2=A0		break;
> =C2=A0	}
