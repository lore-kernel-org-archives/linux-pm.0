Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063322;
	b=pJ5CouKoX9x3z+JQGhgCxha6Rtnv/KjvKTOQmhKGi01VQisqQNG3M2esLeN5OqplEVkV
	 ppkf6xIPWefIFWVpxNz4pZpIU3c7EKY0hkHkuRMob/ijoDzsXD9QGcyUoz9nxO3DIaZWR
	 UdAtEjL4f+YbAUAv3Xd74562ebjrI2u697nZ4SNDmDF/gky8Jd0G9xYZCmKt0bY8MhpCb
	 +UkJebGb+Gm4gns9uTS7X5VDrI1a/Jces6bwKOJ3gO3eqvgGaJXu7UHdREyZx2aGEB9P7
	 juITjXPA/ZBI2cawLVIJfLCDRpIkKIjiOhNFBYTk1LqQ3cyUz3Ny30DO3n+IW0wvgVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063322;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=9fZSnTYT8MA9EbRBaUvLqKYLQu5iORlXOvx+G3Uf2Jc=;
	b=LW9exvLR/ep8ccOpKo60rB9A5fSjwLQnXFAOOwGeLwViUYNNDwqB8INBRxGGR75Kq2DT
	 z1238mP91j4xYPvaijw77hShk3ce7SnB13wzT+3mcqtehZi2MZsqK+4igIMTRPFjzWIOu
	 3VKbKfh9/jKVmtHHFpDH3SbIsVUMIIerSkruAHLwCg3kmqh1Yb/RGGw8tHxSDHYGUAv1R
	 SsImD26DPEQ20DWW9wy8Pz0Deev0sn56ROEtJKAAjIomtuZxGthTfqrvAIm+Ko8ggrgF5
	 HbYlr4yhPxNJWiFgCPtI3JdthX+geMkffH7VqLQQlIyKzOWSriXIz5/fw8VHagBgVHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Vx4J4G9N;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE3606A32C;
	Sat,  7 Nov 2026 14:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39DE3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Vx4J4G9N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=9fZSnTYT8MA9EbRBaUvLqKYLQu5iORlXOvx+G3Uf2Jc=; b=Vx4J4G9No9bGRJ4Vs0GPjrqjeT
	ToMpI2Vl+Ww2kkw+zMNU1/iDDpUDu3YRotlBkpj9gKNB74bBHTypCnSy/xC6d1DK5LDIQooU3Vn91
	o6AcmQvggAkz/uvzI1jyu03Km0tXEYX8qPdITP2+kuMINdoUeyob16qSdX45z4wObi5ieN66BW4ue
	BlgYsfBOIb2JOxJ6hUKlbwpjiJbWc7qZq7ZNfsQWKZFAPa6g2PANLncMplYImLQAgsqbMNE5yxtfy
	EccGTLdNgh9J4QLQXaN9VRoPbwqYorjGX0D+jkVxeA1ntzsyI4FcN8YGopY6zSra3Nd5Q2S7OUulz
	BvedVQwA==;
From: Heiko Stuebner <heiko@sntech.de>
To: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH v5 4/6] powercap: dtpm: Use generic powercap hierarchy helpers
Date: Sat, 07 Nov 2026 15:55:14 +0100
Message-ID: <4204877.2iPT33SAM4@phil>
In-Reply-To:
 <bded992091c92baa7246b939f266297f99c8942b.1793666444.git.daniel.lezcano@oss.qualcomm.com>
References:
 <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <bded992091c92baa7246b939f266297f99c8942b.1793666444.git.daniel.lezcano@oss.qualcomm.com>
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

Am Dienstag, 3. November 2026, 05:48:18 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Daniel Lezcano:
> DTPM implements its own hierarchy creation and destruction logic while
> the powercap core now provides generic helpers for this purpose.
>=20
> Convert DTPM to use the generic powercap hierarchy infrastructure.
> Duplicate the platform hierarchy before creating it, and use
> powercap_hierarchy_create() and powercap_hierarchy_destroy() to manage
> the DTPM zones.
>=20
> Add DTPM callbacks to create and destroy the zones associated with each
> powercap hierarchy node. Adapt the CPU and devfreq backends to return
> the created DTPM instance and use the node name provided by the
> hierarchy.
>=20
> Convert the Rockchip RK3399 description to struct powercap_hierarchy
> and keep the device tree path as DTPM-specific node data.
>=20
> This removes the DTPM-specific hierarchy traversal and destruction code
> and leaves the hierarchy management to the powercap core.
>=20
> Preserve best-effort creation: an unavailable backend returns NULL to
> skip its branch, and setup failures are warned about and skipped rather
> than rolling back independent zones. Invalid node descriptors remain
> fatal. Reject a DT node with a NULL path before calling
> of_find_node_by_path(), treating it as an invalid descriptor rather
> than an unavailable backend.
>=20
> When the representative CPU is offline, find an active policy through an
> online sibling whose related_cpus mask contains it. Hold the CPU hotplug
> read lock during selection and setup, and initialize the zone through the
> policy's active CPU while keeping the hierarchy-provided name. An entirely
> offline policy still has no active CPU to initialize through.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v5 (since v4):
> - Reject a NULL DT node path with -EINVAL before invoking
>   dtpm_setup_dt(), as suggested by Lukasz Luba.
> - Document that a missing path is an invalid hierarchy descriptor.
>=20
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
>=20
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Preserve best-effort branch creation using the generic NULL result.
> - Find an online policy sibling for offline CPU representatives and
>   protect policy selection and setup against CPU hotplug.
> - Keep generic API behavior and documentation in patch 1.
> - Fix __initdata placement; match-table indentation is handled in patch 3.
> - Name setup callback arguments and remove whitespace-only lines.
> - Update the description.
>=20
>  drivers/powercap/dtpm.c         | 180 +++++++++++++++-----------------
>  drivers/powercap/dtpm_cpu.c     |  62 ++++++++---
>  drivers/powercap/dtpm_devfreq.c |  22 ++--
>  drivers/soc/rockchip/dtpm.c     |  67 +++++++++---
>  include/linux/dtpm.h            |   6 +-
>  5 files changed, 198 insertions(+), 139 deletions(-)

I tried to follow along and the changes look ok, but I don't know the
more intricate details, so

Acked-by: Heiko Stuebner <heiko@sntech.de>


