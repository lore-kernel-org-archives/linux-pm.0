Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954882;
	b=gU8ifSpZHjoqnn/K9eT+t6/nS9lROMgMdtOG0jf7ZBUjfqNjTCfxvmNqAa7AKsLQGm3v
	 SQbe3EfXSkJCu+FPMtZv+7y3Uvlu1TVYW+zZ575Wb70wXjCiTWYkNP7lMfYST4qmyL6UQ
	 gwYsX1NDaq+6RCWA8xJ8SIOGccmXRqNlkSTZpkabWlblTEm4YEAkiju0KrGsHh3PwUbDv
	 DZmNe+G+jSkCxE/ZEfvCZowgp/69NJtjwu3zTLhN42qRT2GL0e3SnlFVHR+E0aWiIP/Sk
	 KnbFTykvm7onPdBnz48qd97MHHWKhuMWvvqwDSyoWz3/MoNdgJ4t+Y7uVwf5nxIMlbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954882;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=ohzi203yKMWUnbkmuyMG76MMrHD3zBvQvlxSie9xOmQ=;
	b=NqV1zhk5mzQzDsdal/RAHOQg/2htTlYJnyWtQkIrobVWXfxf0szc/ZZyGzFZVp/mZt2T
	 APM6EhNvphaHnbyCIc4WE+POBYg0NPc6BBXFsl59WjgaAyK/BrczMCs4IJa5e/maW5DmM
	 TYEZHV0l4wAUwwLEyV/X26zG6r+OzXSc53XUj2pCqMcWrjJiBQdFX35wnl/T4P/6/0dOz
	 N8+1p4+BLQlrWqonleJk9dIj+DGuNpT/ZxHrELCeQb1yyey4NeVMoEtNLUuOSQMkpYcYC
	 SvkTiEYGrUL+f2Htct62sPGFF/W/UWda4JVPqveSikCiKA4vTRQ0iPUYJXkSOOvxrpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sverdlin.org;
	spf=pass smtp.mailfrom=sverdlin.org;
	dkim=pass header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=dIhqHrpZ;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=Kq53aB+F;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CA606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=dIhqHrpZ;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=Kq53aB+F
DKIM-Signature: a=rsa-sha256; b=dIhqHrpZ2o7lgKWDF475+Jzn84Ku+ta2e7VDE9zTgbQzUzPaDnoDl2MWOmiEkOHLJfxI5P+nUjfRaXVhY2IW6w62VDEof6zlL4fdO0gdlHIv2ADrUPdZUo6Db+UskSpL3ja0WfRwhNizReBbjZ7vbmDNdLbDFzzUXJosdFgR1KBPe4FRHwB1nGW5AL//r/1msQjhfM11gSvcXqRLH9UyUH3i8xOv409bPkUpPnr3fy8hb424STcgKkYnCtp4vWN/5w6vxRKUw7zTT3M6Ifx1S29453eKXnNdaCee+i9TnQc4tdjRuz7K9DFC7ZA00fms6W/yq4yK0FXWFw6/sgLHTQ==; s=purelymail1; d=sverdlin.org; v=1; bh=ohzi203yKMWUnbkmuyMG76MMrHD3zBvQvlxSie9xOmQ=; h=Received:Message-ID:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=Kq53aB+FMbAK0mUP0TDBhtTnsPTxD/kdYw+nuXc4Vl+PEgAkB9A+mig3SbRW5VX2tZgsDxE7SJ3tZ396Yqt6yP4p+s9/ptB/0hWUe5vpU+yCEo6RYpONZktFmwW3PNVgLhevpJeOTFAWNhdeMN7ZeW3pccQUsg/VJjUsJ4FLTDCKyQw34jGQrtCdHCmGxSIpVolzKIIkw6Wom+xz1ePRldN/9U0t6gAMehQoA2+Qxq11oXCdN1v01U6opo2Ghor5t0QQNtg8rIUwhqGGlJ3cnGmtyJz0m3drnmFwjSQGUBSbn2U9/aNU3PUioMgZ/gxQrruFkcocfL+43f9nmTHUlQ==; s=purelymail1; d=purelymail.com; v=1; bh=ohzi203yKMWUnbkmuyMG76MMrHD3zBvQvlxSie9xOmQ=; h=Feedback-ID:Received:Message-ID:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1938573665;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Nov 2026 22:34:32 +0000 (UTC)
Message-ID: <6350ad134c9d09d9754ad79d942a9205c8cdaf84.camel@sverdlin.org>
Subject: Re: [PATCH 2/6] cpufreq: sun50i: Move nvmem cell reading into a
 helper
From: Alexander Sverdlin <alex@sverdlin.org>
To: rajanyadav0307@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Tue, 17 Nov 2026 23:34:20 +0100
In-Reply-To: <20261104-a133-series-v1-2-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
	 <20261104-a133-series-v1-2-58217cb33a87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Rajan,

thank you for the series!

On Wed, 2026-11-04 at 22:40 -0600, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
>=20
> The A133 speed grade needs several efuse cells, but the cell reading
> is open coded in sun50i_cpufreq_get_efuse() for a single cell. Move it
> into sun50i_cpufreq_read_cell(), which takes the cell name, so the next
> patch can read the A133 cells by name.
>=20
> No functional change: the existing users read the first cell, as
> before, with the same length check, byte order and error message. The
> raw bytes are now held in a __le32, the type le32_to_cpu() expects,
> which also removes the sparse warning "cast to restricted __le32" that
> the kernel test robot reported.
>=20
> Claude Code (Anthropic) drafted this refactor and its message; I
> reviewed and tested it.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603021703.aBD0w99y-lkp@i=
ntel.com/
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

I've tested the series on A133 "marking 0x1400, bin 4, revision 6: speed gr=
ade 9":

Vendor build had scaling_max_freq =3D=3D 1512000.
Upstream before the patch scaling_max_freq =3D=3D 1464000.
With your series scaling_max_freq =3D=3D 1512000.

I also tried to set 1008000 and 1512000 and `mhz` tool
reports cpu_MHz=3D1005.475 and cpu_MHz=3D1509.625 respectively.

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0drivers/cpufreq/sun50i-cpufreq-nvmem.c | 55 ++++++++++++++++++++---=
-----------
> =C2=A01 file changed, 33 insertions(+), 22 deletions(-)
