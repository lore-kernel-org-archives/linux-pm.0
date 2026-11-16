Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794849258;
	b=wjj566fgwCKFhqG73aACKGsucusm4Lu6JzZod+9h74cMWDH0H8sk+GcmymFyBFvtc5o/
	 720NdT3DDsa3PfnD4StDU3P/xz+XDcOo22hLTVD4Wjyp7kBLNAvhh/06GBOUSvzmWCLJB
	 rqfAlhsAqjsB0Xu28v4xjPFoWPGvERYW8q06pgUv/GWe0WSP5aScsMdEyPtHSzLM8ymnJ
	 MX2h2wMPLodYj3gHzeyQmXWC0hHBcNyt5kIlGiuU54ys5/vA3A36j6VqfNpaSwRlegQKS
	 Fg3ZExuSqoIXiczQzq1iWKQcnTX7jGcLkChn4bROj7zo3HEQ4UjrTlG2Vp486UsWyXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849258;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
	b=nKp75NGWtpzS5CczH6qYpcBEFUPc9cjGw2pNma1PJsPAwwETL0Op7Q2Vt+9IRo13oOvd
	 jgSyTUojhqqwKemcSfyhJ8YzwjTYY1yUK1x03uRjzxqWVfvNqna8mqmdLxss6lY3ceby3
	 iPmxJ73w/swVbugZ4BDqc41PgwP3DnMugAPvFKRhyazh0cIphSaiQyljy9N6agzmwLiGC
	 4PVIvoihNI7Hw/tedlBUH7UXP+PqSRq+6FGItjlw4PiTee/Y+fSOe5giCfRm9CeBUNZv/
	 sw92xDoU/OaUJB3QUuM6x897zAmj17bdFPCZbITrrzL+qVU6bZlYrmbLM9nZVPkCeOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NywTcSMT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oavvq+Jw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA55606A335
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 17:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA55606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NywTcSMT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oavvq+Jw
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIGHi2126182
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 17:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=; b=NywTcSMTB0SjVUH8
	zpjux3PRGT+tY70cwKUHkTdZU6FQce64TaRkPm55vIxr2cJyMo+bEdnrpOKiv31O
	FFQIlEiLf9N9yJLplM7D8VMht3Te2bvxzvNzib6F+Fh3/GJE2YfxEfkSh43plUNn
	0U1jZvUAj1k0ASPm4mybE5QcXm+kJol8yLMjkVb02U85KmpF24PWjWCvAtJF/98A
	CoC5ifC7q+rvAkW3KWJF8yyVOUcN2Y/WhBKI04O0FA8R95QVy1aOW3+QGT7qfpqA
	LoOOYzr+6iz7S4t2RDspWL/9FPDi3hgcY3SmQ40L6u9MAWeAL6SOBB8V45aF1VzH
	4Zp33Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2hw5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 17:14:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94970ad532bso278200985a.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 09:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794849256; cv=none;
        d=google.com; s=arc-20260327;
        b=KKrk9T4EiWIKiZeQRBl7aldmRUKHa4/tVBG+cpOx/9W0QYL5BbSDAQnmqOBYRtpwn/
         3zWsFYH0xc4e1M5MxlSWKiLx9N/gyz0Kxjph1MZkuKLkwbUnXKYZnk0aYtxzDnoeBSlI
         csecB+/eHpBE6MUTpSDUlNBZ5F1oSaL4trPZ32MsL5CN3Cr+btZDYVxWK0FKk652ek6l
         +iReb/1hpIy8zPWURHuBTcgEOsbteuHL4UO8m8WfStpXUxl1ZqlBWA/KiZRG6/XUM+mX
         Q3nNJKivl/BtVor0PYkw0+3Qh4mYfF1Q5Y4tmiYCWmSQpZuCbbdsmM+T6lJtYB4L7yqy
         5PkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
        fh=7iUpt3rozyAAUs6MxijJkw4NHca4SKKDyDHNqIdqVq4=;
        b=UcZ5MYxJyevV1X8WHN7Mp99olW2QF2HyrPbjOirWp6jkPzRzsa+NKyWFjmV2cubO9Y
         RSDufotmClysmobRsoRLivs6e83ICjCafC8O3MWrNhIsstWZbtRLeYMvB0qIlA2BrzCK
         XJjbAzOKxxW3THBEzJEWMgt9kXHX3U6kWJqvOBdOMhZMeuWc9jJEn+k+rvIFRPbHjuXz
         lEWHhIDACzCGMy8NoYOuGnlvabnqfpv8xAKYoniXwb8EzsLIt/k6gGIRgXe5m6eIdbv/
         dSQZlFohkczC0zq3+Dn9motQaXrihv4pFbwgVguhCkFkfqrgto6YdnM4oq+s9Q2xOkax
         Cj9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794849256; x=1795454056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
        b=Oavvq+JwNQrTn5YmGNpTNeeEL/plcUcvqJpF8HaP0iHoXVlerGo8RsTb33IrKAIXEa
         UEbEmF6gVxDQsV0OCOX/zkrltHSnDA/k6NhQQqLfv/6Ae7kPJWuPUdYuJiX8SFb/z64w
         oS/RslhJ//HsCF29Pn7yZejEuMX6UepSDdxXS9kUADNYfKKIMW+iXQKSDTN1IpZsJ2Ni
         UkfUCxJeFnm5RZC6II3tEJKmWDl0zZgHtU6QpAPJfzsPX0XwjUT1K+lICHFXZ0umgsQt
         byVlH5niBMIQMv2sX4dAZoK9OVqMnv1CXIZqO9CQKuvg4O+sXSxeJJZsf7q/tDQ0S+UJ
         jxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849256; x=1795454056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGIDXdp2RIrXTSdgnrAspAZ/nkS4v0bZBuA1gb5G5i8=;
        b=pUKHXjo0EDgG3yeM1u2dqjF3KDRKcxA/OSMjqngFc9MpRVTaL687pO7b33kjhNc/9C
         UDsjEwc0ZtKy+L0kJOyAyPBqlOaiJyrn1N8e7Fq3e2xSpnHy4382TGu4edL4xXGLZUGx
         5OPNTtt42AsUovZeo2vHMfkqBSNQJP8xlyg/r5K22qPSUbkwlubzUpp1Enn0qZXevhbp
         YBFLiq/WiYCup1g27GKS7/WXaXiwClKmErckjTNrRjK7s0YVkr7nZv3XVU4W5mIifkMM
         WFp8GcJ+HpPV/i2brvZSqtuhkBkFGXN1k/37Ye1/QljRgi+cbF808xcDCmr1ds5G9MhJ
         /GSA==
X-Forwarded-Encrypted: i=1; AL+hErErlb6Dxfa5qtvnxGWX7PKZZzSpnNyF3sJvDw6WZvzKGtRNXDitzcY++GZVyqXhvWjIMjP0lofEWQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+VjCBZm2wLmgaFE6OdcE4HBzZAqavLWKHxA3ecwW4sJTMOPlP
	iD1L4ChOyqdOqbMIYv07TIvAHLj3IJhkzIoiEEonI0ojewNJXk8y9VAhUAz7/e/MwtQ1mMlGxCL
	BUvFCHt+zlYpZWCOWXJ5CFRuy5fglMBMxzDuA6KzsZUseaJ1fZra3T8Lr8j6r+Tdov5NxA+Q997
	ev4Uz7ZYgXtO0DTP2K6THPyQiskOUM51JxmUseUiETpXdnXnV8+A==
X-Gm-Gg: AYBFou2ljtXYapjRBtAai/YqeORHv0MRt3CVys60VPk8FmssIinIRswlUdWqdNYOcLX
	YFrLuRCiJC4gDy3Mqkil79m4qI+g/s0bx3avMKNIliOU9HGMo+2ZRuuITpg+S2cR3aVBqW9pF/4
	cXBZ55W0zu+sekvIBRblVRZCE4MnN0tMluOV7HAaW0aaVcGstyTgdJsXIWeDLFsl62dJlXvDKES
	dkVjHUHSatDQzkcCv7GkZ7ljsEFPLf8XFOV8r/hgZueRAsPiQPSE4LZcmJIf+p9ZKW7qVrgsS/j
X-Received: by 2002:a05:620a:370e:b0:949:7502:6a8 with SMTP id af79cd13be357-94975020921mr757118085a.56.1794849255689;
        Mon, 16 Nov 2026 09:14:15 -0800 (PST)
X-Received: by 2002:a05:620a:370e:b0:949:7502:6a8 with SMTP id
 af79cd13be357-94975020921mr757111285a.56.1794849255104; Mon, 16 Nov 2026
 09:14:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:14:04 +0100
X-Gm-Features: AclHuK-gzqgD2ofKvkGd7o_qM6TFIZRuqcKLnoXo_1NUG577lrtNPElPOvNnw5A
Message-ID: <CAFEp6-1ys9CibgvvaQL3dvA7y0GjJbhNgf0wD5YAAFz3AqFkaA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb39e8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AQfUo8DtNGVBezQI14YA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OCBTYWx0ZWRfX7YdsVsKe3G4k
 JJB0PuQwBvDoxCUqGjOCLpu2PpqFxJPOn3l5NgyF8j+S34e2i6ebGT8moNGxs1GShPBSl4D2Smr
 jA5kixgzx8FDidk5T0m8FXPzPJRWsCc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OCBTYWx0ZWRfX2HjdHm0g+OmA
 onCHR6uXQKfnzTJE7xnqtc76q1QPGDcVsybapzcN1jMI+Q6yoICkax/UPi9UEtn9DTqcngwP5FT
 hiCM5im13nFs9AZdXevFyQNuB1SpU2ySTpeoSnL2lva3mM3Xch8v94e4ZQmXSspCFxg9GJ8nYHm
 CMUQoN6MB8X0oUh3SriquZ+3jfk6ptCqMwwl8TGpcro9IjMpiL4CU60Uq40CsJKubJAe171gRuy
 iDBsAe0498GsYmODgqyyR3Jap1lXH2c9YBly8gHID9YutKsy2eubppjAwJOmH88B+MdSFQnHPEf
 g4g+INNTkk1wUMm6KdOOJlWikAR4dKce7/FGjIoVkzWMCW3nRRBF1o0Z0a+McJ/8fHzeCt1FEkH
 fb/kkUz7CJzaNBWyxZxDYwVEeRZIcH4Yi/UdOuc5M5CfPe2eyszWdIAyDvKBfK15KkxIzzgtBV7
 ryQTYDJ3Wyt0o2M1BEA==
X-Proofpoint-GUID: Cr71Px24rj79FIcBuLyb6UK6OkvXGYZl
X-Proofpoint-ORIG-GUID: Cr71Px24rj79FIcBuLyb6UK6OkvXGYZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160068

Hi Luiz, Bartosz,

On Mon, Oct 5, 2026 at 2:21=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> This series describes support for the onboard WiFi/Bluetooth module
> present on the Arduino VENTUNO Q (monaco) platform.
>
> The board provides LGA pads for a wireless module. On the VENTUNO Q
> these pads are populated with an NFA725B module featuring the
> QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> the design is functionally compatible with the M.2 Key E.
>
> The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> signals, as defined by the M.2 specification and handled here via
> the pcie-m2 power sequencer.
>
> This series models the hardware using the existing pwrseq framework
> and connector bindings, allowing coordinated PCIe and UART bring-up.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Is there anything blocking this series from being picked up for
Bluetooth? I've already rebased it, so I'd appreciate any feedback if
anything still needs to be addressed.

Thanks,
Loic


> ---
> Changes in v7:
> - Rebased on linux-next (pwrseq changes dropped)
> - Link to v6: https://lore.kernel.org/r/20260904-monza-wireless-v6-0-d8c5=
042b3efd@oss.qualcomm.com
>
> Changes in v6:
> - Rebase onto v7.3-rc1: drop the now-upstream "power: sequencing: pcie-m2=
:
>   Add QCA2066 (QCNFA765) BT serdev ID" patch and adapt to the
>   pwrseq_power_on()/pwrseq_power_off() -> pwrseq_enable()/pwrseq_disable(=
)
>   rename that landed in this merge window.
> - hci_qca: fully drop struct qca_power and move its fields directly into
>   struct qca_serdev, removing the bt_power indirection (Dmitry).
> - Pick up Reviewed-by/Acked-by tags from Mani, Bartosz and Dmitry on the
>   pwrseq_is_controllable() API, the pcie-m2/qcom-wcn controllability
>   reporting, the bt_en_available rework and the M.2 connector support
>   patches.
> - Drop the pwrseq-m2-bt prerequisite series link, it is now merged upstre=
am
>   and included in the v7.3-rc1 base.
> - Link to v5: https://lore.kernel.org/r/20260720-monza-wireless-v5-0-69ec=
6743543c@oss.qualcomm.com
>
> Changes in v5:
> - hci_qca: comment why the M.2 'uart' pwrseq lifetime is bound to the ser=
dev
>   consumer device instead of using devm_pwrseq_get() on the controller (B=
artosz).
> - hci_qca: note that dropping the always-on pwrseq handle is not a leak s=
ince
>   the descriptor is still released by devres (Bartosz).
> - Link to v4: https://lore.kernel.org/r/20260716-monza-wireless-v4-0-9b02=
e6f549d7@oss.qualcomm.com
>
> Changes in v4:
> - pwrseq: rename pwrseq_power_is_controllable() to pwrseq_is_controllable=
() (Bartosz).
> - pwrseq: move the is_controllable() callback from the unit to the target=
 (Bartosz).
> - pwrseq: add might_sleep() and guard pwrseq_is_controllable() against
>   concurrent provider removal with rw_lock, matching pwrseq_power_on/off(=
) (Bartosz).
> - pwrseq: clarify the pwrseq_is_controllable() doc (Bartosz)
> - hci_qca: lifetime follows the Bluetooth device rather than the UART con=
troller (ChenYu).
> - dt-bindings: also add the "qcom,pcie-m2-1620-lga-connector" compatible =
(Mani).
> - arm64: dts: monaco-arduino-monza: rename the 'pcie_bridge_ep' endpoint =
to 'pcie_ep' (Mani).
> - pwrseq: reword commmit message (Mani)
> - Link to v3: https://lore.kernel.org/r/20260710-monza-wireless-v3-0-4625=
3587af64@oss.qualcomm.com
>
> Changes in v3:
> - Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
> - Add generic pwrseq_is_controllable() API + per-target .is_controllable(=
)
>   callback; use it in hci_qca instead of peeking at the W_DISABLE2# prope=
rty.
> - Implement .is_controllable() in the pcie-m2 and qcom-wcn providers.
> - Treat non-controllable BT power as always-on.
> - Integrate the pending Bluetooth pwrseq patches from Mani.
> - Link to v2: https://lore.kernel.org/r/20260702-monza-wireless-v2-0-7b56=
e2a6a6d4@oss.qualcomm.com
>
> Changes in v2:
> - hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, cal=
led
>   outside the SoC switch; drop duplicated of_graph logic and redundant
>   bt_power NULL checks (Dmitry/Mani)
> - dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
>   pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
> - Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f69=
42310653@oss.qualcomm.com
>
> ---
> Loic Poulain (6):
>       Bluetooth: hci_qca: Set 'bt_en_available' based on pwrseq power con=
trollability
>       Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
>       Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
>       Bluetooth: hci_qca: Flatten struct qca_power into struct qca_serdev
>       dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compati=
ble
>       arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT sup=
port
>
> Manivannan Sadhasivam (2):
>       Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
>       Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available=
'
>
>  .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 ++++++++-
>  drivers/bluetooth/hci_qca.c                        | 160 ++++++++++++---=
------
>  3 files changed, 157 insertions(+), 75 deletions(-)
> ---
> base-commit: f0406245cb9855e6318335a8a223551354291a46
> change-id: 20260520-monza-wireless-e6ce7f013f38
>
> Best regards,
> --
> Loic Poulain <loic.poulain@oss.qualcomm.com>
>
