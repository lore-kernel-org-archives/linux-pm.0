Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889A39E162;
	Thu, 15 Oct 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034211; cv=none; b=M/npqxKWt1+RaF02hUi2XMu0D2NSdwgFsIZWz0GoSVBmPIQ9qcUDY6xbJUcqiZ7shhCTMIcRnhcPw0I9AC9d7OY+T6nyIi2PN7ruA4FSN4FNM9ZcIikHngqH5Hk3b5l3SFikH+5T19JFepGxAirkUl0qn167UHDJUNy7Cdomnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034211; c=relaxed/simple;
	bh=eGUl1EjHFcamJedCBJvDoNvoI7+1qfWz7Dp7Y+RswV4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=j5ZJb1h0G2NLkfhuoX0RPgx9/gj12DGWTjBJdYW9Ea6E1/YtERUubYzYww3z1+++leMAnxoP8sCZiDTiSS2CKQzAdJ/NawCGGDTEPUSuuLnqo16djJ8ATOC5Fa8KqJpQ+k0h5XyQmdOoqIfA2imh0K1zWoxRwFOSVA92EdMqTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi7XzO/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi7XzO/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60F31F000C4;
	Thu, 15 Oct 2026 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792034209;
	bh=2ou87yQuIEg2z7mT9ieRZYq1trZ1IHgqCJodj9CZDBs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=Pi7XzO/zUTN1unENBI/pj2wA7Mr5dc3U7XaaIyECGU5gB3+XfUjcU4JOkpTy+8oDe
	 y7EYQ+gVO581hDokD+dreZABYwcx9ijoQkU69wUblPq3CIs+hWboglgAZRh8+nTlzD
	 MJ1yQ2+mlu1flVdZKFH77UMusmFgkTa1+Q+YZD75mCaCaeWutm8178dkjrigwQzFVf
	 ZLyUJDEwce/K6dGaC0py/FnJEWPYbCmmLpITDilXghJyCOG/4VcmeK+0wkLPI2UszR
	 S0JpaMeUURQV/wLefMeVvevTReV1cqupGgPIMKdLHFGa4uRlRJxlM22EXO2wzx3Ii7
	 L47pBRvDOWdAw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <231214ab-9ae9-4e3f-a75b-d65a597e9956@collabora.com>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com> <231214ab-9ae9-4e3f-a75b-d65a597e9956@collabora.com>
Subject: Re: [PATCH v13 00/12] SPMI: Implement sub-devices and migrate drivers
From: Stephen Boyd <sboyd@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jic23@kernel.org
Date: Wed, 14 Oct 2026 20:04:49 -0700
Message-ID: <179203348991.5720.8006688809115365098@localhost.localdomain>
User-Agent: alot/0.12

Quoting AngeloGioacchino Del Regno (2026-09-17 07:45:06)
> On 7/21/26 11:36, AngeloGioacchino Del Regno wrote:
> > Changes in v13:
> >   - Removed `if (IS_ENABLED(CONFIG_OF))` check in spmi_dev_release (And=
y)
> >   - Rebased (though still applies cleanly) over next-20260720
> >=20
>=20
> Is there any further comment on this series?
>=20

Applied the whole series to spmi-next
