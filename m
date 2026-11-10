Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293388;
	b=vSY5/5z7p3VJf43XLfIx+3X34E/hMgoFZH9B7WDWsuJ8JLe0GhzIOdNWz2UpoxpfodHw
	 cCnvDsLfIjCztScNnKZP5jMO8Zj4ytfvRAthWAC2zDhd0ExnRwKgwbA+HVup+Sl1uNW2Z
	 AZ4mPjxh/2HI9H3Au1ahU2/i39DPuz1fMerKHYBSp9GHUqFKMnyN1MwZWI97LgKXiyM3X
	 i4MmXRWi0I3T/t8IZsEkTdw5ojfyuvMr8j9xLVcUfhaVbEHtzBK6OrYYA4ewQ7ZptpFBq
	 P6nw6yAsyIDb9Q7Qrgvwky+bHrgZoRotoEO9cb4hNMzA+wOdGxCB9FgY2clfdcIW2yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293388;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=/w5jL5vyA9upjdnw5WddL4HeRqRVj2qfta9DH6HupIw=;
	b=JhKQq5YT7MB8crRUdeygHwVIK/mcoV1cq4CADIe47WDVF+ri/GZaqsUbEwu0z7qD57F3
	 A4/bzjV+da5x2JXAwVj/y6wL4/1Jlmboq+VP84iU4vd+umPjb2TjjuiqnWzI29MWGYcnZ
	 Pz89C1Kv2zqv+cqXhsODqwJS8OO4T0gv32HiDl96Ja0sxLz+yEVttSbcXfGeS0si6UrMx
	 YvrdUATWwCbvn0f0/aCV0Z+zlE/lZL5rCv2ck6r1/IyQzxIyWxC3/+/zq54iKR+Xgu+hJ
	 oDBugmvEhpszDn0j6YptKwteD16BBjQfOVuqkmEvQ9JfWUa8mAeKQZFEphkxH4lbYew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=H2C7RqRO;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C4606A31C
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 06:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD4C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=H2C7RqRO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794293375;
	bh=/w5jL5vyA9upjdnw5WddL4HeRqRVj2qfta9DH6HupIw=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=H2C7RqROlVGP+ixmgnH+4GkgVDuaNWkVOPhG05Ne44//rgHczeElgN/PG7Y0af53L
	 DNmrap4cmbTth+iytcxMvfBlINVWV24Vn1/YeDwb6o0pgwHBiqtl71nDxJLV/3ynW2
	 Cq9ZTyFAsa5HbyXpJyEpHmJkuA+3eNRTUmMceCC0=
X-QQ-mid: zesmtpsz4t1794293371ta564256b
X-QQ-Originating-IP: FdOqUzZJzmmhkbZlIxz+KiVbEzGEuHwXiZl6I0gqZv0=
Received: from = ( [183.48.247.17])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 14:49:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14734344013771177668
EX-QQ-RecipientCnt: 12
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 10 Nov 2026 06:49:28 +0000
Message-Id: <DMRBWY2S42EN.1CNW1DNHJOKKD@linux.spacemit.com>
Cc: "Alex Elder" <elder@riscstar.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset
 in atomic context
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Anand Moon" <linux.amoon@gmail.com>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Yixun Lan" <dlan@kernel.org>,
 "Aurelien Jarno" <aurelien@aurel32.net>, "open list:I2C SUBSYSTEM HOST
 DRIVERS" <linux-i2c@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:SYSTEM RESET/SHUTDOWN DRIVERS"
 <linux-pm@vger.kernel.org>, "open list:RISC-V SPACEMIT SoC Support"
 <linux-riscv@lists.infradead.org>, "open list:RISC-V SPACEMIT SoC Support"
 <spacemit@lists.linux.dev>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261110061429.2036-1-linux.amoon@gmail.com>
In-Reply-To: <20261110061429.2036-1-linux.amoon@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NJRsSVeNb6U+P9a3rSMLDFN8pcY9nswCdzdNjbD987Hzj79MN44bkDry
	K8oI5nPf++TqCklxnlt7cg4PRglzaE5O/VfOYbHrgmBx8vIz5ov3zF8pUzZ0ug4LvxHU2wF
	u7dV6UCCxaJfO4dzIj1x4a/DN9fueqlHqTGXaBgblyh2d4eSO0qLA6ceJ6//9l1t6OP+DPZ
	noOCrENzVuNHsmG1heqbZeK90sM0IyP9FPntLaSuSb/Hce/HPdlpNpZpXkAnzGT/H54RflJ
	+88LRsLPiKL+7+VLe7dXYg3IH9LQ+HTWplmRX/3m8jFFXgI5BWkmHOwZE1/T/uZg+6bkBpe
	QkSewBkJaaZkOKQMyETrP/H1CdFb0ICdm2MvnsMof3XP7N7qd1ccvsBNL2ac8Ce4Z+ywgFZ
	DyrG0if/nVAqncSFrquk9/klVgfAr4exiwRoTKe21xJa5p2c3zvIsnPZqflmVpqkDPHc/AG
	4B+mFxrPD/mndTL5wX7tYBInzRzhEjWW8RtOCWHMBl9E8llUznuT3d/3I+uTlUyIIqjUCeT
	gNYb2IZP0ne8ekvl4E0P5/KdvpTU9ztiaOI8X71GYGR2QIvle/zcx2a0fvQJNr1/4jlO3kv
	WqW7aSWLpP82SKmMoCBJgX+StmnlzJ6lD+xEhk838JfKM8SlPq1CnvsuhhLjrYXfQdgsRfG
	fpvvmdvwFxk/WEyjc0zVCpzJzKOWT5Rf/Mrfd9MvUjjMx6W2kPH5uhZI01WR8dLFa0LvRh5
	aiAaVtp2z4Y0o4uhkP546Oj3Bm/u4z+3srW7vwD1m+RBeIYMhOsn1La4QcPVFEudsu0WCmw
	k7aQF4Y+vq7tWQLjuWYcsOBIZeuvEb3zIGtNsc9OVji/yDwYUmaBMJexCcwo3mpSk+5BXBx
	CaQrLtZGhwXqgZ1Y3UB2f4LKRsgL4rJTQPx5fLncaIahQvP2/tqf8gzNEQPQ+CX7s3iS++A
	fDcbedZFQMFiMAjh7Mi0hiwjdwZ+8zJcOqEqh4H9+IxmJmdIW9iKkmBdKeGGD35KmoK8DZu
	+TPPzeY7GD9ApYZv3BaYw6K98Buiarehfd+Zny4FEL9hbmmwlIPy4o3PCf/WBMolAZY+nCn
	0sD0gy7Ge5TAbV6OcjyDLfMk1FZDoV4bA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

--73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 10, 2026 at 6:14 AM GMT, Anand Moon wrote:
> The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> to wait after triggering a bus reset request. However, this function can
> be invoked during atomic I2C transfers (such as power-off or restart
> handlers running in atomic notifier chains), where sleeping is illegal.
>
> Replace the sleep operation with the driver's internal helper,
> spacemit_i2c_delay(), which conditionally uses udelay() when running in
> an atomic context, avoiding "scheduling while atomic" bugs.
>
> Assisted-by: LLM
Also, please drop this tag. The same applies to patch 2.
See commit 1e035297ffda.

--=20
Troy Mitchell


--73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavK+eCEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC8WuwEAp7T345IGTixk
luS0mGzMpY26JPDPOjGWsAUNq6ZoV1gA/RWwn34/Jxu8vWe3risrvjxT8VoYL1gt
bpegaV9zkQME
=3GOU
-----END PGP SIGNATURE-----

--73e506311f5038c7b44d14906978b5da3e801f24689993eeee7050688645--
