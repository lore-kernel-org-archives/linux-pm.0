Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F143EF0AC
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146469; cv=pass; b=Ue+LRmEbzMhSUX4PDoqTcaJZPPT0X4Mmf16rM5b1hBG04ntdpi8I5tMK7nOoLMf4OKvcrnFRL53aYNGS90tThs26eoVN9QswPKk6wT2Shblt9PVQd1aw5c1j4tm+iOLOUWR5GYSoIX43ovDL2m9F3oU5fIsRzbUw42r5PZdbr8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146469; c=relaxed/simple;
	bh=PeyKN0baBhutHLbY8tpY5GwoAhsXPzOWCm1h3cCqBJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyZg2e1tjG91OOAcPqFYncr2cn9NwS08cwhhOtKRNVdRHNhh1qDai8NiSirobWrnfQvrsh7+xH5CmQRMkEdEwta4DzPUQKnpynsfxzWtPdNWbrVfTNsd9IOj3p2vur5KzVA1LZDOTKQ/iXNQO6Q5Im75CD614wqnZ42QClBB+Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pR4g/VVD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cwNo1g9l; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pR4g/VVD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cwNo1g9l"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Wxa83083756
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fpxga49hr34rpRcBFaAC1QHjhjtKMHjA32E0mhgUj/8=; b=pR4g/VVDUj1stCtg
	quKe4ihAM1gvEsgmlEWtE+21OkUdNfPYciwb+yeHh03cLS28HXTex7gEzog62RaL
	N2d+cDiCvfrdjXDv8RwdHJAPqnMTlDlAy0hkXz0A4ojGe/T2xLeCu/2mk7GLi0ZW
	UrFvVAjMy3d4gC2jrb7+l3RyUUQ7OWlxF76JT8b86VGb1eTfc3nLfUX9X43DLp38
	G3s+8zd4R4gvaQq4q7cW5lhV98s5ca06f27h24pcadY3WichadQZPEJz/PexHuYd
	L93y8Az+sWt+fkf/DiFr9bTxglVYH/hyXM8gz+lEINLIgpczhK8smEgferrZ3EUK
	vAU/MQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2asguvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 10:01:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e606e8f3eso210762285a.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 03:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785146466; cv=none;
        d=google.com; s=arc-20260327;
        b=ph59m5V8+g0rDB8JRSlbiVPz+C92UO1q8Ol032ooLxsZFA0kJgG18PijzJ4ypKMZJE
         2lQZ42zmYt1fx00Dlr0TvUw5ZjLir2sb3QWJeLVq4GnHr7mA4uJxz2jytTpJrbCqKcqO
         l6E/QKRjgaIOfkiDCtGufr5UIy82L+JUrNuuGsUS3FZgXJbHjbEkPL/C/SKCBNMTsF5G
         UXn2oqXKKIRf8kxuHWJqhBH3mG6V82ZbEa6oTSfOYoCtfXyjlgK0O8306l1Aqhz2mgLN
         Vayd/s9WmS/BsPgh4UMe8pibZTYGuI1iq3Z7PMOr9NbDArBXxTQjOZFKgKvcKG+xXmcT
         ujbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpxga49hr34rpRcBFaAC1QHjhjtKMHjA32E0mhgUj/8=;
        fh=0fFtKNQ99bpIbw6MleAbsSq7wBJf8p0Q2dovFQvz2/Q=;
        b=D3CG9TZ4QDspYA+VEXW7S0J8gzsQSaLjIIWrR8m2BkdOzMO6py1Mm3CcgGiZFCnUSN
         ST4zke9qUAJIP4K9n1NY069mu2BNjpg1C3a6SbfhfWkzWcR1sOzfuR8xq4Q7Evqg/izp
         34dnMlRXMp1y4+2ymsUqEOjQO4iqYNIEC6k3P+bQ/rnmRAX/Myknso3LFfV/9qSW1/+A
         GBrJv6rNv+82WIYQKz0wWdeEUwvVGNDLqSIcRXWnM7jw3ggk3/yYc5WrkvSQkMzEG59u
         pkNTagq6VgJ3c7pgBzMgp3FU1qTF4DGXUbTRxKiQMCCJYYBKqV71n3kySVY32mUcyq6y
         h4hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785146466; x=1785751266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpxga49hr34rpRcBFaAC1QHjhjtKMHjA32E0mhgUj/8=;
        b=cwNo1g9lAfk5jJXK5GVlbQQLjeWiCmTZYD759zdXTON+zAywP5wTT2OWzT0y4ZDWD4
         kUOWP1WQtSYRZOOeO8MBtNXZuC2DZT0kyVntZzH6LPytdltWpkOJ4L/RAr9ZalAdAcnd
         wFJCzlY1Kc46ItQFKMh7W0suQwJKjIhWFOow3hHi5SP9odsAxRcqmCJgQo9MDXFs90MT
         7lFKuapH93Y15lE7T9g9vqkqFiII4kG4p1LYlLhSPbaC35YdGnDo4LrFSGN+RQLq88LW
         RZS6HguUFkyCnUH8dd5/0klEBqYanDDjYowx0Fj3XtIW3H/hYVkbsa8U4qycOTiVzxIQ
         Ul8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146466; x=1785751266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpxga49hr34rpRcBFaAC1QHjhjtKMHjA32E0mhgUj/8=;
        b=SR4ERfyJfI73ltNmK6TFHEZIRUrRKKFCMizKRfeE7X0cRfqW3a7/K6DscMDp5JNjlO
         vTFAcOn1dTqPPySG7K+X9e91FMBS60nTRrguAzICxWgAwqyM4f1w6lhyJ77O4dVOrCMH
         STVNAUYsjdP1N6WhPTGpSwTQbmBJEzOQdj2ggLzFQQQrZJE4+60zO0mfvtDNiRcNnKP2
         KohxX6gjPrmUZXIYll2vhmwoimDMo9yUfb+hhHmFgz0mqbc5c54E5RXJ9oR1IJyPUTKa
         AiV4sTOfPrX2whwXZboZHcKz3XbjqLNcQ6KJaUshEaUFyj3Uvzu2csqnbqMcBBEsoIYY
         Y9SA==
X-Forwarded-Encrypted: i=1; AHgh+RqCmv72riYqWmAYH3gTc6Vf1Qw7U/ZOl4LFhLaKR2NDjn0Wa6ZKUsnnye2GZd1DP0sj6muSoPgtJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqsVS14hrMqJSOvyBP31kVStqmCe1rKlp30ajmZvDiXY9blp8
	s61NMtHpCy+FlM0VCXefADuC88XqZJeU9D2AGC5QTUlYM6uCZ+E98jv7/7vWW3/EcPv2Q+4q2Lu
	tlHT2AGgVR+u5V089iwkUTCCKd3PiZfPOjZMePj6Ie7ieR811vl2UcV0PTLhfj08wAqk3RyhuyT
	IoWcQV30S0M0EAXXNIydHBJNw54UHLWFTkGxXc7lUyF2GE
X-Gm-Gg: AR+sD12xDeCJ1j7nNN5NgvgEjH6KQMQaL6tCyoMeUrx9eRa41WADjCJNio+K1maIzEO
	bLugfB1nEZquR5X+J5KaWtdmxll4KZR26Wjkdowjh1YEqwGdzllcJVM6g6qY8MPBUcx+tQo+qQu
	v++aHWJJ2C4Fb1TQuR8alJ9edjrp8Yv7tdfDpmwpjoTawGt1tTXiAuDP2szg==
X-Received: by 2002:a05:620a:2688:b0:92e:745c:6c5a with SMTP id af79cd13be357-932f948144amr15114485a.14.1785146466252;
        Mon, 27 Jul 2026 03:01:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:92e:745c:6c5a with SMTP id
 af79cd13be357-932f948144amr15109385a.14.1785146465706; Mon, 27 Jul 2026
 03:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
In-Reply-To: <20260723020524.1886806-1-Zhipeng.wang_1@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 12:00:55 +0200
X-Gm-Features: AUfX_myrKTD-P-po5naXNkkd8gbbZmT-1aLEtXL0NN10jCpUSfBDEv1NDisfyg0
Message-ID: <CAPx+jO956WAqXt-zbEyzU5btS7KsXn4fBemaj4r3qQNANNJCKA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pmdomain: imx: build the SCU power domain driver
 as a module
To: Zhipeng.wang_1@oss.nxp.com
Cc: robh@kernel.org, saravanak@kernel.org, ulfh@kernel.org, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jindong.yue@nxp.com,
        xuegang.liu@nxp.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX6QLs5dpGwG4l
 Cp77Cwkh8HRl/bAsWTalT0oBcW95KQ5zcyokaIzvKCGZw2W8MPkvps6NY/Ku6E/xTqgD0s1zJVp
 s6xF6l2a1Woty1Nr8zyD1jd/qSaYflcwGI3J8jnNIfB9XVzkRIm4k1i7jm1YAGhDpD2WWc1CqDc
 0qhVV0HSuH6wCILQWuuJIAzcBm6UTtzPdtGhOCL9Fq3o3SIu7sfldT7L+fQXt8Tfgc+W1+zDyv/
 GiZK3NXW7ExFK8IvBHq6oEAfRVXX5MViQOyGC3zmCVNJKoS3RY15SkeWFZuyZRhM38IobWB9Lj+
 BGA5nIdn7f73ZGjrXbFIp+jvezCB6MyXlh/nFhfUCG03NRSZz7YYg7q/xM1KLcNJGKluWm9UCEz
 doU4t09tO1LN5jqqE1PuHTPH9VGWglu4uROYJtEsjowQSfysLw1taneyFX0RCWMH9RI5i8I1lKg
 jfdsQo0AxIpK32TJE8Q==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a672c63 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=8AirrxEcAAAA:8 a=73SNKA1z6Gcgn0qlyfgA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX0xCYaFv9TSBV
 fUgncBf1C7l7pnYFDhYyX5R5xeTO8X8FrNJqYxdlz0x2lOqBQcoCPbI9Q6xaEpbURFlI9aoJ3WF
 iHyByro1LpZKR2meaoFNjhGf4Ajc+yg=
X-Proofpoint-ORIG-GUID: IfM8oWXCF534jKhtPM6NxnzQeyjY5Xdl
X-Proofpoint-GUID: IfM8oWXCF534jKhtPM6NxnzQeyjY5Xdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270097

On Thu, Jul 23, 2026 at 4:05=E2=80=AFAM <Zhipeng.wang_1@oss.nxp.com> wrote:
>
> From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
>
> This series makes the i.MX SCU power domain driver buildable as a
> loadable module, which is required for Android devices using the
> Generic Kernel Image (GKI) where SoC-specific drivers must be modules.
>
> Patch 1 exports of_stdout (which the driver references to find the
> console's power domain) from the OF core with EXPORT_SYMBOL_GPL().
>
> Patch 2 converts CONFIG_IMX_SCU_PD from bool to tristate and adds
> MODULE_DEVICE_TABLE() for autoloading. subsys_initcall() is used so
> that when built-in the provider probes before its consumers (e.g. the
> SCU clock driver at device_initcall level). No module_exit() is
> provided since the provider cannot be safely removed at runtime.
>
> Patch 3 adds MODULE_SOFTDEP("pre: scu_pd") to the i.MX8QXP clock
> driver so that modprobe loads the power domain module first when both
> are built as modules.
>
> Because of the cross-subsystem dependency (patches touch drivers/of,
> drivers/pmdomain, and drivers/clk), I would suggest taking the whole
> series through one tree.
>
> Changes in v5:
> - Fix MODULE_SOFTDEP module name from imx_scu_pd to scu_pd. (Sashiko
>   bot)
> - Add Acked-by from Rob Herring for patch 1.
>
> Changes in v4:
> - Add patch 3: MODULE_SOFTDEP in clk-imx8qxp to guarantee module load
>   order when both drivers are modules. (Sashiko bot)
>
> Changes in v3:
> - Use subsys_initcall() instead of module_init() to fix probe ordering
>   between the power domain provider and the SCU clock consumer when
>   both are built-in. (Sashiko bot)
>
> Changes in v2:
> - Drop module_platform_driver() which provides module_exit() and could
>   lead to use-after-free on module unload. Use module_init() only, so
>   the module cannot be unloaded. (Sashiko bot)
>
> Zhipeng Wang (3):
>   of: export of_stdout symbol
>   pmdomain: imx: scu-pd: allow building as a module
>   clk: imx: imx8qxp: add soft dependency on SCU power domain driver
>
>  drivers/clk/imx/clk-imx8qxp.c | 1 +
>  drivers/of/base.c             | 1 +
>  drivers/pmdomain/imx/Kconfig  | 2 +-
>  drivers/pmdomain/imx/scu-pd.c | 8 +++++++-
>  4 files changed, 10 insertions(+), 2 deletions(-)
>
> --
> 2.34.1

The v5 series applied for next, thanks!

Kind regards
Uffe
