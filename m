Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745962;
	b=izvtf+StfBci5pWkcyIVs2ErvN3VHhlQ0HXkbH1IPw/3Gm+DPFuxDkL8WbXGKJ8wrSVK
	 cfFsDa9/x0QiNcIhiLxh5wHOWUxwhfiz1N4otGaKP6qrxMSIsEO+/J986Pr+WFvscadEW
	 Zat1hnUxUHncQ4+IZk5gJcX5r0PxkXEij2aVRsFjPzTmd3M3mpGs/t6ocrHX3WF3m06dx
	 opE6MyBwgpGKSocHcbYkEzhPx+8XRPukQIMpQ1dgvBFr2jd3n+ZiFSsVyjGrqGGnhdfI6
	 xZ201Y7Yv/Pnw2ZOox8uWXyxeMmUzZtW8MFnV2cfJjSeo5iRYT0/gdBz5ax61/9M47w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745962;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=NnJsKtCTeD/Bzs882oxMSZxOAfNjNWrgvAYK1w0KvpE=;
	b=SHSExW0eexoBtzKjCLF5GTPrMGPGQSMkKahUindLynoAciCv1qTZYa8ICziVbCEOCGFt
	 HKe+jmUqdV3Jibtb6clsEpccMKf8z0Z9WjyJzQzxyeHnWpNdpmwavFfiq85JLtojWL+Zp
	 qj7CB/fPHgwzZ4idflhhMUwG2nqor051SYGXGuuMhx9xjWYBN2KmHGRpNUu959UZmiwJb
	 y5r/7QSLToKGnGmTRB7degX13QPnQzLa1xVtTfH0/EgzSuldLqTaP3J/3S4wRu6nsSoD/
	 P3VxcrxRZUDIZ+cSt+EZF+JonPzcJ/0QCf81epzt4VSPDJyKqgpjvf6uurs9k4+0jaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gbeLFUJU;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C0606A328;
	Tue,  3 Nov 2026 22:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D16C0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gbeLFUJU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=NnJsKtCTeD/Bzs882oxMSZxOAfNjNWrgvAYK1w0KvpE=; b=gbeLFUJUs+ZWxMstd2CPZDNWCJ
	oEGwJz+eQinsoD8PgZ6HLv/YVXCRvnPBhA4Ww09HNNMGR8WL673bexx07d/W3ve1Ah4rdE70367T9
	ib3wl7UXqSYXRNjkkyk9XcaK0PWB7xz1cEIYWdHhRF/1mArXTlyg8mOL0Mfk2p6T0DYAwfrvSjzth
	7BmORiJf0icp2wMCCbv9zzVUGd+9W/QSwNR8jdlMaVyeBynCgDSRmUroyqnNbFAgiw0j4m8kRbfBW
	8XT6UxDlm1gmfj2ynLX1HCI1d+gah7Yt/it3CKT28RI8Fqk+afe3ABDn1leZnfRiCSSkctZWI+RhV
	Ri6bN5UQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject:
 Re: [PATCH v15 02/15] accel/rocket: take the completion register writes under
 job_lock
Date: Tue, 03 Nov 2026 23:45:30 +0100
Message-ID: <3317717.zE8UqtGg2D@diego>
In-Reply-To: <20261101082307.151957-3-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-3-gahing@gahingwoo.com>
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

Am Sonntag, 1. November 2026, 09:22:54 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
> taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE und=
er
> it, so a completion can write its zero after a submit has written its one
> and stop a task that has just started. Move both writes inside the existi=
ng
> scoped_guard().
>=20
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


