Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=106.10.242.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625604;
	b=bSALrAsbSitIbg8m1wIF4UVYLkDDUpwiCp9X6P5uslGHlzAMLnoDeH48un5lvDolKiLI
	 +PHQY2S1mwW/0TqlXxtc24+DHculWiFYcdyttYqnbgCQqNC0Js0CwvOrn+sdTL3R4nat4
	 EL760qGKBHfnKKneulQR2RuPogb5Crw+locyzRbR7zsq/Xh6J/NUYX0u5/s98UIHzMdrW
	 O0whh7XgKPdE/+pEGBWrOoIU73tDfeeO6zpf20BN9y3Chw/3ipkNFDwvOYmdttZk10rgk
	 ObTX2tnsVen4oTj7QzGx+cfSwCcedpVvi39twIzYQ/5ecDtG3vvb46YdxP3qhXrqo2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625604;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cORDD26qxIDDO7OrkN6/X50Dh9JdrNNXXKg+j/17MBQ=;
	b=K5+C6EFqBIA0yutUYZO3tZhPtsmDVjB2YuufDieWfMP71c6bJr7jmX4bey0atKUKokx3
	 mIzB6Mwpp1cQA8miZq6HM6KTZRfEl77w22w9AJH/zrDM2MlApOTXGtmwx2xZDeF7X//NX
	 /KuYyjhz1YgsgLPIxyiZ8rZtmGjDfN7atAvtDSX4IldmQZkbgNhzGKDGW+oJAA5tG8I/z
	 qHNL8fW5vEd5NLNalHL+seuIshZ9Glbpfdk9R2iMhVPLa2YjjPCUZqAA3ddIdogfnMUNr
	 gxwt8HlvTTEqdwopgIcXlBEhbFyirBedKZtXRwS0QOu/EsLwOGyeZt9I57UQRkMTCvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=LRUG962T;
	arc=none smtp.remote-ip=106.10.242.140
Received: from sonic302-20.consmr.mail.sg3.yahoo.com (sonic302-20.consmr.mail.sg3.yahoo.com [106.10.242.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3F606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 16:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=LRUG962T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795625601; bh=cORDD26qxIDDO7OrkN6/X50Dh9JdrNNXXKg+j/17MBQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:Subject:Reply-To:Content-Type; b=LRUG962Ts9EqIuEYzQhy92Lqhzw6pyq4htncAAGPooeMI/Yhbm2DYW97oPhcZCrU7doYPIn2CcJS/ViXXo9U/H4+qGqZ/Ct/bXiKUfZFftQiccATshUJoWv+To+pgplfVqtteKwbw7lvwbV/rXISWljrEVbUo8aZUXzdrIlNlEOLyswekpLri+flfROUoFyNEH+Iv9+/C2Kq1eHNwNEnLVQu0D55joByokfde/TfIwlcs+yveloDJJsjzyDUNenCOJXwHKmV3jjX1WIsoKMaDvV77dUTF/5og+4N+85LnSvbApZCK6UybPJlUWftu8cdBCsOQxia3hcBENyxF+x13Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795625601; bh=zf6oefWhu2ozSG4ZL2siPJ2ibqTO3RQgRq18eO1LCBf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fQNx8ciXKaMPuY5pLOvYmFy5BjaCJBC5Au3p7aTH97U0qIC4/ZLvlJLPkMk40RmDPoTsyEoqnl71PVG8qX5ADO2p9JLEtwLkM35b+6g3DKZTTDeccZkfJ8tcgLCiv9HIQmHBwTpuArlZwlLWpDyWfIV07WCxogVJ4jJEOQB4vbFy3n/Rxbe4/PKNgn44dJL/H0uUJscBPpAADjULAg51JwoUh+0QTxYjew1Qil7qofl39I/uYxGo2GzQf3Jrp5G9ppyIvbUbReZI0GttGbEui4JSYdX1j4oYTrJBcvmySF3XSAnmu36qw57MGgRpBliLUnTeONqzkF0GX0i3qnOsJQ==
X-YMail-OSG: rZM918UVM1n5g8ioN2E3NEfhd0mtcqyOi1f2RXjdYr0jg3UD0yrucf2Aqkm0VHO
 HIFo5DiA7tyEmStxstz0Ql9Oob2oUVIBZUpWGkhvvzRTLkKRMz4beB6B9dbSQ6Nx7Yt8cFXDmudo
 ArD73I5Cu2VRPwXt8QoU7M0DvREJvnl.jltKMdKGbYrck2hdRrikc9J2cgb_GGAItVQzF1SiAQEU
 1y4aA4Kcs6XQ2Tqx1gteRbcHXwIIEWbHJ1crm4S2.S7pmUhyviaPycxS7EaYGvZoEC5_1iQRuA2p
 abRRKmmwQF37iqHAxFlGU5ZYGTOxOoTKBy6GofOn9E3QqFGzmyzgMBZ9N8qphSTLsyg.YAln_raU
 ZIOHHYd8RFODx52s4IK2_x7lL5inzlbSKi0qO6vjhnY0V7l.7Td75ElDbJssdXnTBjqg.Ql56qPG
 _lVaKhvf6eUMOWjgG0Xx7k8BbeEzfw9SkqvD551seaDlEzqgalQtkb4BscG05E0QAP47ifufBw4g
 PKKPOhgv3dIDSyEhHqEPkSFnCU1z2XgKMbpROd6L02JHlVqfl8P3ajPtCAa.S.9oSoVhg04blb2v
 8M9WJ9VvbBhSucrRMCVnjnk5PElY73v7U7wHC1wlV4rhEuRfu1NiGqsOD4wvywpavIixiyWvdeAr
 8UrVO_GEYY8rjDVVErReMSiNzVkN.P8Z0hB_1qnXcVi_SISWQlZ42YB53f5UdCP4Ob8OotMmU84F
 oY8OPHd.aYmxQLjuUP2ROry9PZ3caxGesQu4DGWpy7MHzKQxzcAY4Uk2jgY7SnQ.OPK1xGQTmwy.
 ker2iOxu1gY0XPBv4Y5i40DBIHxH5PdnoUFw0cnZ1at7HorQjL3B8wc4anWixx3PHWNCl4j.Mr2c
 ok7.D4Pr3JiYuhmiiizk4uunmL0Bu.3xW9umq62BAH7ul2XfEqWS82DmGjQjAl2dqm.4IIYfszkS
 IKQ9AUPu1yg1GGufBvglGlIhdMcL2xur9_sZ4wmQg6c__6yQhtlPJ2LYArFuL_a2K_0GUm7uULZy
 _U0UTKSUlOzTnqRg_Xv_HwEW135eD49zxb53t5S5fa8J7PyS0FFeZ_aJo4acaQOTe9BOHE4YK0QO
 8IwMc79Z.RCV05O9yJ5ro1yVGnTqNOqQ4RwwI1wecLTRaOLVE_b.pZM5wLiJJwK2grUvrjY4t19H
 ZcmHCme4EUO5k8PZ6zTDoRgtEp9NGOL2JQeEYegCUbD90IIuMkTFyMZpLCsoTxgPq1zSlk4aUKye
 8VH3RUf5XydBt6oIcgZ4SMYftKKzebfS.PIXPYQLScX59xKQliBcSHtPWvx_dJN8uSUjVdY8Wjk8
 SVUIQo0rD.aRcox6Ls4odW7u8qjC02idUQeNwgBPHHVXr_NWQDMvC16CYWZGtKWzpKgAUaKhujEy
 rEQJ5.u9uhR_N2pLBH7J8K.xsetjfga4RZRme6eLa.6SbYymWE9IQX6GHCo38x985mlRSQPl40bk
 q02ZCLOY_0GbXM71QGAeTpbf_dOxA66Ut_atqvvtBrT2WfMAlaGT5zS170JVL0mA0i8YL.Ma9Aso
 .9ZPr7kGly11TA2JNvoJ7fEZpblR85RRv4t7FfT126zw1ddptao9x9pDGOn0eSEZcRZWT9iCU5Gt
 nbO367F2ripIX0CVb9MwBHMDuIgOL96QMGGiS5V_6bnbqxPmX_uMOS.U6Rz1eokIhVXpcxvVj0Xf
 1KbYO2FbSF4FgoviQk_ZVQZahVuy6p05s8CibqF7nK45MHeXsOoyez7iIIjATfZl.GljSeP6RcXc
 hjbvG7V8MWi_5MFVUkpqxrEAv6OMa.6mMIgzi16m3sUNqddskJW_BzAlQ3cvozhnSwZPnPrvnalH
 pJWbKBn8yNmCponszz3M1IvhTnrdXowzpl3UJ2dXzmhdh4DLHw3XR0ZueZ8yzsuFmDMVAGZZGtYd
 0UrDkCphQ74a4DVWXSYtQNAC86TzyDQXne189ajWpO40b1LwQ6q.liHkr2HCQyzvmHyX3lVGe_3D
 _.LW3OyRRcVe0BES1.TDLLLbgWiE06jjN60XWet0Q5jdU7ceaJWVM.hHMS17HSiWIS210edTu.kt
 FSnk_HH6ntbRsHhJGkWUZL_PgB0ONu2IZQESiQdr9lt7I0Oz6X0Qc0LXlzTCmsqfzeCnpX0Xyfqa
 k9JLucJc44hk_Otfqu13Y7fdtBUUhWq1E35.TAdubzCoAKVFfBriuTHcmICFLJKTNRUho81.wPAr
 yq_KEcx4AYDQk.t5JTj7LRCte6l739QPhH0f2kuDZAfFiVw--
X-Sonic-MF: <venkat.yadlapati@yahoo.com>
X-Sonic-ID: bc66c019-719e-45fb-9873-4e73ac6cf6e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.sg3.yahoo.com with HTTP; Wed, 25 Nov 2026 16:53:21 +0000
Received: by hermes--production-sg3-5ff9d6888d-mt5tc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4d5a9904d5e5043914c879cb1da06d3f;
          Wed, 25 Nov 2026 16:53:17 +0000 (UTC)
From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
To: konrad.dybcio@oss.qualcomm.com
Cc: Georgi Djakov <djakov@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: Don't read back BCMs without an RPMh address
Date: Wed, 25 Nov 2026 22:23:10 +0530
Message-ID: <20261125165310.1409251-1-venkat.yadlapati@yahoo.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <68573981-f9a0-480c-806a-0980cfbb6242@oss.qualcomm.com>
References: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com> <68573981-f9a0-480c-806a-0980cfbb6242@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 25, 2026 at 10:45:29AM +0100, Konrad Dybcio wrote:
> Fix the driver instead, please.

You mean a separate Molokai icc driver instead of reusing the
Kaanapali one? Molokai also lacks QUP4, splits aggre_noc into
aggre1/aggre2 and has different QoS offsets, so that would be a new
binding + driver rather than just dropping QPC0.

Or should qcom_icc_rpmh_probe() fail when qcom_icc_bcm_init() fails?

Thanks,
Venkat
