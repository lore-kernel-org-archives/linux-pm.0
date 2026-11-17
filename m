Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910642;
	b=A9Rz25r+xaQVQsQJO4dLh2xR340Re8GfeI+kOkdfu6bSIZFltqk4Hh4V+DGbCYJ9Gyqr
	 dBjtOhoZ3aMigOgchbL4rMChZIOR+W6nCFzisEjlMFda23NchuLGUAt8Io+zg84c6b7OW
	 nIotuaqUCajrOOyqrf5qIxQ8BkBm3DYh5t9z5o6JS2dNmb1X/4kf6WcokBjU4TeLEc5tc
	 cKn+O2VlPtiHHmTkTPXVRpYSHIi7+jqCtxUzUbykQi4j2wg3KvQp2BLoJWb2xcaJZnTDe
	 UacN6GmkqyjIYAX1HVCon54atgQl2Y6czGaemCG75n3QF16L2lIBJBAIgYAlB9MEKIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910642;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wy0o00qQ9NmDrgxeDIl4krt4Qft031prUV52bY95lck=;
	b=b/rPy8HU0qAVIsk+FBORMUL+WJW0+W2Yf3UTikJ3lJ4OyeVCkrpYcGTujnXm2wSYyrB+
	 2wAtkeMdFlznBMnTMoWAD9JSo/JdKdeKwpwnDu2ioWkCNcc+iZUJEG/hR3GEBdH8FAGgZ
	 ztfS1ydAQfrsh4d6cHa8F86bUPnc6XrK4HdhYESK5/C0KnrQoTLJdQtcGmtJeSBBR3l4O
	 +9iSb7wzQ9qNdk5ObKsXLcFhdFtsENPycgOYCuiyhFfoWmPoIeQFnRY3/FYkWyKse3MnI
	 amDpQ2kBqMm1JVCsRjAGK8JVTTNLSpBbE1kKXDK/cnKVHcqkWgpMojE458yhK3EzGKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gmSd6pp2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eRlgvPkj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30CC606A323
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D30CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gmSd6pp2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eRlgvPkj
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH55hAg3350164
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wy0o00qQ9NmDrgxeDIl4krt4Qft031prUV52bY95lck=; b=gmSd6pp2gxmgeKJn
	lo7uVTqxtdYWP4b0PrnTpukDzwAaIStTUl5WZn8arC2IZ2/tCCWM34OWOyl2GnLh
	MaFw38aK4rpe/r3w7BCQmZQ221KeHz6KSJy0+XgD2A3eg6GTSeHrmOCUNKpGYeEX
	DQU+UaxfABfe+/t5qiVJH2UPFFOvyKOOREw9rrisAUDTOG1OM7GISdvnjcndlGKo
	zVYT4vv6Sb+iCgX+qFE3M9dKntJcGSbypHpCZ95wdeOj7t468LbIO2Yfcoqjg5S8
	Y3VvHh8BAY0xEnTMHzcugjF+GT0dmNBy2IPuSiQurcGXz5q0ChbsT0tywKA4JuLw
	R0/LEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr15gf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:17:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so151121585a.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 02:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794910640; x=1795515440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wy0o00qQ9NmDrgxeDIl4krt4Qft031prUV52bY95lck=;
        b=eRlgvPkjKtfuWOs7l9YMAeH8UFJnzxOUh8mhEhvkHFW3gcFGnzt8pOGJ11+dKQuC1W
         4dlbl/xXBoarfI3cLAg0H0B/VZphyvg6KLCvu+vL7fUMSP7EeMQbWly+VmoKQId4BmW1
         OHpHYieaI9kLwjTmxoMboeXHDrw5pWn3mJWtXPaKyIMXxlO5k/XiEN2X9J4xcHbnFKVB
         OdeHqrgWTZjnc+A+Sg+C8MkWmT3h8KzVxvgrv1laGMVYSiyHjqXgsUboiVnUHn630buW
         16PyC/Jio3ZnNNKIgzfgFL3SUsIs/ut9UQuemxavTg+55Um3wKJcZOeP1wkqIs3ChF+S
         W/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794910640; x=1795515440;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wy0o00qQ9NmDrgxeDIl4krt4Qft031prUV52bY95lck=;
        b=UW1OpJZptCAxQbVI2jQbNa7TxrTaIGNCEwqpUeWI0DGoBFD/Of0Avaevxt1ULr1B1A
         TtJtk1pTYAeTeSPUfDRSxKQGzv1qGifVhC7y0p53PIlvTz26Y+SSDgKuFHpgK8dtgG8z
         BKlsM74d7fgE2hwboolKQtf4XMJzb4Rm76bKSM5wgZqa9AhdiwzNU3Rg+U9fn73Tu5fX
         Q6jJFVummJflrHRu8B2b9RijmpvvMXbgjFCO3318yAl5ykD/xwUylPk9A+b4sInqlLWA
         vWJSnbUMDvBawjsPIi2LHrXLCCA8ajF2208FAvnbxzgch/bpXO8OHSiz4Y8kYcTEb1ZN
         tvsg==
X-Forwarded-Encrypted: i=1; AL+hErGDz1fRXEVfkPIMm5ETTnE2pMos42xtXMxk2zRsUESliQPSlpUaYr3VBXBkpwtIjnZns456vylZxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2PiClpbZnPSOGGoEa9p8LcHgR5cmTOH43KVEFZeFh+ynxV+Da
	T4xXTNPK5aINpceb1hTtXYeW0ywP04Q7NOnx9E/f8gSIvc0V7905uwAbfa8NHGEZ1RfXNIPDS5j
	4qs1vzI+AL0h6M9feI+BMONkB+N67H1YrxU9UjAPaLTkluWoP5Oi4cU8CDbGHRA==
X-Gm-Gg: AYBFou0MhHv1Abioy5JstvAfUfgH0gEKyitI/jt+dER8XUNldrF/IL7l5THozrGDIbf
	7XOss67zQOksi/dKLCwwKygJi5fyCBYi+yA4Ae4YvwpvxlL1moI+U2u0Uipl6AQCoYDk/AiAn5B
	ZC7KjONaXKOzT2N6llmiWgUL4km0Fa0/0hgh7p3aBR1K9RLLJbWKyuRCIs5vcRH+P3SbdmTZJuk
	3yVCp5TMFmJzhME3D+K60t0zLl3NOvBP6MEL/I3Neq6fJziZQALJUnpHDj+eBLv7lhIwj5fDUUc
	nX1MqJa1iA25e3cQ3HJ8pCsEOu/Nl49SYxZi39KU3Cm6Kj6cLzYwaUYZxpyGbko8Xr0yVui7LhY
	h5KgBK7uom8O4M4vcPhdNlFHeTqhWKubqECoGovfIB3nAAmpBMjLAtH/oX5+9zOU+5WClRMjyiQ
	Q=
X-Received: by 2002:a05:620a:4890:b0:93f:2571:c317 with SMTP id af79cd13be357-9498b922379mr349875785a.28.1794910639941;
        Tue, 17 Nov 2026 02:17:19 -0800 (PST)
X-Received: by 2002:a05:620a:4890:b0:93f:2571:c317 with SMTP id af79cd13be357-9498b922379mr349872885a.28.1794910639508;
        Tue, 17 Nov 2026 02:17:19 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm83827935e9.8.2026.11.17.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:17:18 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg+renesas@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH v2 0/5] Add ADC power sequencing support for RZ/V2H(P) and RZ/V2N SoCs
Date: Tue, 17 Nov 2026 11:17:16 +0100
Message-ID: <179491063406.27909.15006722116661437367.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afc29b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=yC-0_ovQAAAA:8 a=EUspDBNiAAAA:8 a=VkPfdC8VYmQ3GCa23YcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 2TX8ENoRUbp_n8S9fCM78Zf5ETJ7xTYd
X-Proofpoint-ORIG-GUID: 2TX8ENoRUbp_n8S9fCM78Zf5ETJ7xTYd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0MCBTYWx0ZWRfX5ufx4MKvtAoh
 CTyKvLJYzWiXH0BxSiOx6OFhZD+LISfwVIhTaoYg8mF9q8770MPX0f6j9aVev0Mn0cJnVnW+tPz
 Omf3pWKxR/H5XRGeudRt/4A9O5WfYaZXXwBJsevY17UqneUxuEwPYaEaBNATB59PcgSkb0F0x/Y
 VMBiETxkAvjmd5/umoBqhSm7C30QhRapwAQTjc3ixnHrFlnSaWMfNHYvTA/IQe7G6AEoT/nBFlm
 52otV11WgJiHkrmnRjAV6VEXEh2YPLy1TGWKoTKgrP9AmsM1MaoBGkXfwMD5s2bnaZcC/ZWYlcp
 24OviYbIXK6YtV+2d+XoQK9clIXDwsgagwTgZk0Hxct7g1E3eLi6kjagDGZqIPFH055++B88//2
 ucLJFL+OTU52F/EK3PXiNlX+/6nuYX+fHV/xxDAb44BeDn8R9mahQ5McT30E9PNKiz39mBzoznW
 MTLWgAgOVjP6+r6A1QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0MCBTYWx0ZWRfX/rI1hygaEtWB
 h6lfBaxKB2KEg7kDeb9nWwuaJ3AlrXiYrQCTMiO8JP7l8g8qj+/hmYJLBUGAgRH+OlnHWPTAnH9
 q8FHN+RO0l07eUf20W13XDTNZlwnczY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170040


On Fri, 09 Oct 2026 17:57:05 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This patch series adds support for ADC power sequencing on the RZ/V2H(P)
> and RZ/V2N SoCs. It introduces per-SoC probe functions for the
> renesas-pwrrdy power sequencer driver and ensures that the necessary
> Kconfig options are selected for these SoCs.
> 
> [...]

Applied, thanks!

[3/5] power: sequencing: renesas-pwrrdy: Support SoC-specific probe configuration
      https://git.kernel.org/brgl/c/a0e667a33418a0598c0a2281aec407134d66539a
[4/5] power: sequencing: renesas-pwrrdy: Add RZ/V2H(P) and RZ/V2N A/D converter support
      https://git.kernel.org/brgl/c/2b8b9c3cebe0f54a7bc5962b748d2c71ed2125b2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
