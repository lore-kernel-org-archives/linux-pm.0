Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063369;
	b=zR7u9Ixtf8RyV9uNK/P2A9oGtwN7XgPMdIrfvJ10WU8MWk5BG/yB+k/VH/0/mutPFLRp
	 hAYaj9fC8nFZ2E2tk0+M8EmOvi+YB2gfSfP8R91Thf1d/S3eArWyQV9vJENYf3M7E4ldU
	 WVeOCY9m6pywxtffBKsXEHvrw/mTlV9yIrWXTEnRKs9PqtSn01ovrVAbM1SFteCxIr/2h
	 WI4mD5SuabA5CuybBOBtX+OLPNJhpSCOwXpmy5kJs7e4s61tNEZ4R95Uw7EeZfplF4m0e
	 IneJIrrZKEeO0Y++j8pqK/Zkes57A+c71avgNC0uRSD6e7XjN85OGcCu244UrKCkqrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063369;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=Sv9tRvnr9TF/tmGqWJfOuRnKtgkf41Z5HKKYDQ+jKyo=;
	b=11BDON4YAEFLXN1LaxqSy66lN+TGYXZ5SVge81HMkD/mXdHsnY1t0k3jMAQVHjWWAqSV
	 1v5O4nW6vQWO0z7vRlXEN7s7llOiImFOx4CpEO0dZ9orYHHiKH8FpLKNPGLzJMJ9qNksp
	 DaVM2u9GUwDetpBaBcPBFflfjrCbrNsxfuDX6hT8orVgjL+mR0D19NPV225Mf5O4Nudkp
	 k0GB4Sm10oOMVPO+A6/vMkiNFQObS4T4w8ZhrgKOE8OmVb9xuUvKGgVazQj9kYhv1SjL1
	 eUhYOkq7NQK0E9thefN9FFdgjp+7ZqY+KRDaXP0ABpsv3YwSmurJSnzgr1lTIeio81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ixkdVo0Z;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E8606D802;
	Sat,  7 Nov 2026 14:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488E8606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ixkdVo0Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Sv9tRvnr9TF/tmGqWJfOuRnKtgkf41Z5HKKYDQ+jKyo=; b=ixkdVo0Zqz03Xevev6+EHeeEz1
	IVMALVClC0XEpqnA2KMMA69iQ2nCyZsMbVYFmIrRrf0fzrlBb6SV2Oh1T7Wz3yfqJB3/rALSUPsHs
	flHyyzCaPXjSYOkyRXtBp3X7Df6y2BXW6TGYxzUMPSmCji4ClqojwoGl4lkDI52LK6YODb84z3hrn
	KWzM7saE9G2/x4gDV/D0e2lDeBEyNRb3KFXqH29Iutzwowxw3ZwSaW6rQjTzyxQkbQ1woSv5qD3Gs
	Y7tmcC3/V2fYBKWfowJHPQZsWE0CIdH3XTl80RtZ/LJF2D7yKB2rmJPhgzQ4pHCOTTAz7R4a8QGMq
	lupSoPgQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH v5 5/6] powercap: dtpm: Rename Rockchip virtual node descriptor
Date: Sat, 07 Nov 2026 15:56:03 +0100
Message-ID: <3394748.l52yBJDM9G@phil>
In-Reply-To:
 <d58bc47b95fad310cb506ca01b59cbc54f0d8c75.1793666444.git.daniel.lezcano@oss.qualcomm.com>
References:
 <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <d58bc47b95fad310cb506ca01b59cbc54f0d8c75.1793666444.git.daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 3. November 2026, 05:48:19 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Daniel Lezcano:
> The virtual DTPM node descriptor is named after the RK3399 even though
> it does not contain any SoC-specific information.
>=20
> Rename it to rockchip_virtual so it can be reused by other Rockchip SoC
> hierarchies.
>=20
> No functional change intended.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


