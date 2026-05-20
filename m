Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF613EA972
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287396; cv=pass; b=N34Fj/8sd9eIwc5n5iPI0rGUy0OfYCalgVclzDKpg4awKNUXuG2sAb4HIWw66Z329/cwIcZ5BDpHb35Ta+AUh+OZugOBkmPMyXbWvM5kpgMO3bc+2egxefCEDPDN9knGdQqbLQJ6L2cBkKFEqaWvJcVMtdAGu78V7zUFcYkfG6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287396; c=relaxed/simple;
	bh=uJ6ceiQOgOhCZfY1iBogXOpFqQfDep+SLyd7qBiSXHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RREG+ElIEy9dI6YEQJp6EoY2E0uaPcSvtV4EyHlofTNei4QCwQTMJiJB2O4Vx5fZntgbjeI5JHHQkXUdwwluM8bUZyRfSopOS5+hAd5UHUifsQeoHKzMS1htnXbWv+K718GWoF7UhrQbysoezpiRvTo0RijFacw/LwjYplwRb/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=luJfri1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsLs4rV4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="luJfri1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsLs4rV4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KEFZZJ963711
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 14:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=; b=luJfri1qCnaB0Kjj
	UWrcYoJTqlDFRc/7zTCpwCArKH9okmWvuSK2c3PJRGBpIdrHd3rUxBmvOG/DGM1N
	ZBZKzqGrmZykPnePYtJOf95m835cGrX9v3dp2ciKbJL1DYyphm/I1TcWQV1dAWKg
	SFuI9sLqPCFZpWzHKEz67xtpSqtKFXaB7KJLONUUVg6eRRxIgFO/8q5TcaGdThhN
	/BqkBeHGsbQgjjKxQ5XzXIvtn8h+OjaGx3ses14mebDDvOELLFMr1rbOi8F0UC9g
	i0E+iX+TJFBeHtkr9cSTbQCcTjHAcBuOWTeX2CE6UIyQHzsgwjSMS/3hqFD+Uclf
	F9wiNw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh021x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 14:29:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8aca4660827so77207236d6.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 07:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287393; cv=none;
        d=google.com; s=arc-20240605;
        b=dWz01A+ure2SWdKPuAVraw8uCrEutlyKTlcJLSQJ6A0MOCP1DkXLQ8aqQB8y3SeEkl
         WmswnLfsJZUUnJPptJ0RaHZ/GL2i6C/EPXW8tqHgpzvGptM4objC2DJzfPHgggjNuSJ2
         5X1uNhqD2d6dlLm5CmxN/gBYgXXoiWceeth8Z8p0/NMl/U7tKkpt64K5kvOiOR3+IYVC
         mznOVDqo86Ym1dgdyP9neCcN08TL7O2TLH/SNcQg+ORVD+tHb5D23fbyjj1ceR1kosjw
         bQg/UqWNnxXzLu3l/P/vK5qJePAze9/ADbDLTkBK/15fxGw6J7kRezoecfiFmtxkazLD
         s3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        fh=Wk6FyGY16nZVq2ng84bpHoU+BIy0v/xZzyn0kvWdpzA=;
        b=lLb5wSCDp5hb1yXUDDe51AsRau8ynWrXqc2nEBQ0UGQ2OKXBRDVVjb8dxZUWTnxow2
         Vks4w0uDXQpj4+7C14zxuv/BAPcEHpyajG5bIL/ajTa3IGVPuaQ8QmXJTZS8PEzM1jNV
         Ml2mm3TdLHTpFXB9SJLBZAM8IyRRSvi9QRIJVW5tRoTDt8kNDZrc5nWJXCdD5fSwhzQX
         dWO7OPzBsMh8qfqearyiHrxz0Q4NFnuUKOw4E3e6EYlH6w2RYg4xWnMp+hOcq3XgEYPt
         8Mgv5zPAM6dZMG7xpS+qzKrHm/GuMCLKDo3KnEo8+9sTjcR2Lud4sjloY1PEJ2efDxMY
         zDZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287393; x=1779892193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        b=OsLs4rV496AdoRsCxEjSxv7ldhYiiUwF0T4Dt1BANAFnOW5C8fKTAwGoMIs2Sxre8e
         PK0MOerharEiXS+SHvQgBjlilne6DUNq2ZW2aSeAoDrTUyogHNnAKXl7WuellmtS3IDZ
         M7ObPeskTWj6FlcDI7SyfkuvVI0hHxvrA4NPKkXRoN3KY3WHpAhp3QJ/56oH7D06uGNi
         Y64nRR/cyFWu+i231++xMtVgABhpHH8cDs5hnAleGnU6GHCqvkOzVDZNZVL/17/gQ/49
         Aa/7hJ307BJstxSzIkGsgXQv3JqjWHnAbhroG7Dp6tufsOfrRLV3QdDC3R5o0OjTUV1W
         peZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287393; x=1779892193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        b=EL0zbtYyj5mqvZDUvOHajgUn7hQYXCGyq0fNbOoRr+7/VtR9Fm7s/LZmo9laFngv9X
         nNpD+tSTC12CzfBELPt61v0vqMRgBXjh92MOshyvf+TGxGRP9uAtpcn+dxvFqq6UY1wa
         puEuCFu4F47NmGw9VLHDJI07fUX5MarHEiNO/BDc2tXNvvE1tZkqaLf3Y9xr5nakZoNa
         TsfUlnSzbBkH+mCey8RFerZ+KDZeoqKM705UDeS6saPUdFZ+dCoPvVlev8NXuDdCunLH
         30Mp2drVr2LcKwmB43TPpG0fC6bVtO+5XttujZonzod+W5MbUi3sLzcMSjM7J4tdk+1B
         0V8w==
X-Forwarded-Encrypted: i=1; AFNElJ9RwcldreS+xt2siRkJ0techz26VJajXfxeMELpGDitsS70FTLNBmMyxcEIdg3TFkywd1DDdRA99w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnsX6311s1kafiv47ygPRSG/H5y/NBaqHC3cXma10zWZGLDcg
	AcTgB/4iCi7bZGvFkPu0dsfrBcsUxQ9z7xXu6Od2By24Q18k5O8OYGF6nzfAsarPJX4v533xiR5
	dFXI6dkfezNi79meRXYW6nj9gXcUWCf8LGuRyQ+8I7lvzpxl5Bg9n837sEaHe0lCRJP4HmJy/J+
	+rMkXtmo3vMxY/X7d40qQ8MKNdpvz355dpwKEe
X-Gm-Gg: Acq92OFmwdkx+igcnHvyEWka9Vg0s+coMUcTesPKUppuLk6UaMcPgbKxhtJjAPSGzFW
	6M6k0KhIkgqbMXL9whEnzZJpSJ3Zff7iphtN1+F6QxMT/eLXMb12bsKzav/jqjxg/elJAy0sA+x
	Of/7SOBQ/MVFeExtmcXDnqiG3Yb74ibihDLNqqHAqpvNE5emIV1PFX1qF+SnkhkAxQG5WXVg1px
	j4fxnCh0P7poonh4grQ6rVs0GD7vYHsy2tRreU=
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id af79cd13be357-911cf3f7626mr3622213885a.38.1779287392537;
        Wed, 20 May 2026 07:29:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id
 af79cd13be357-911cf3f7626mr3622205485a.38.1779287391929; Wed, 20 May 2026
 07:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com> <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
In-Reply-To: <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:29:40 +0200
X-Gm-Features: AVHnY4L4rWNphXQmeHCOQKyuxZcVbSpk2c2jukIzCXfC1OBduPiOmLNzgTemvps
Message-ID: <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0dc561 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=ncdiEfFe64kH1Y8Ome4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX0UAINSk8zWkk
 inuvd0s1TPgrvPJVvMpInVuu0axoBd6LkgbWcN/QsqjGSQ4ss7AMB2rywYL7eqcblr9ufTmvSLO
 xxc1a62jOfpnrCzLSl3TSox3CvU3nfgZIaSgzHI1zCciJgSUjGHeVQBCaKvtXWUSRYgxEEuYWGS
 M9cRo3wn794fYY1yrBQ/AoosQKxA38Ap6EiEghx48lh6D4pzvt293g+TgQ3LsStBRTC0FdPhORh
 Zfmtt7bsRfzyjEjTDe9xxp/StaoTjadJEW3RhA6YD5EyGK4zh3qRDy9khCpYf4kty90x2cT6ArY
 h4caVLaWxv/EsUUPbN9AFEbX2mMj1CN3gVUElW+B6bVcOY//LuCFthBnpXU4AjMg69BNTNO4PGX
 FR/p7HjYv7hyweNQ4zirHbDesDPisZWoLO7OOzaySVI6/N3U/JTaj2b1yuG0DHoaTpK1+2OuTOJ
 JHYx3A13CFVOAPLVaxA==
X-Proofpoint-GUID: 56HbiBojHkSsbn3jrlWvyi-u3fWMSRUR
X-Proofpoint-ORIG-GUID: 56HbiBojHkSsbn3jrlWvyi-u3fWMSRUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200141

On Wed, May 20, 2026 at 2:34=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > compatible with the M.2 Key E.
> >
> > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > the Bluetooth interface.
> >
> > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > the pci-pwrctrl driver can acquire the power sequencer and enable
> > the M.2 slot before PCIe enumeration.
> >
> > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > (gpio56/gpio55) used by the power sequencer.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++=
++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/a=
rm64/boot/dts/qcom/monaco-arduino-monza.dts
> > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07=
244d185abfb1976d9 100644
> > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> >               enable-active-high;
> >               startup-delay-us =3D <20000>;
> >       };
> > +
> > +     wireless-lga-connector {
> > +             compatible =3D "pcie-m2-e-connector";
>
> I think it was discussed that LGA can't be an actual M.2 E-key
> connector.

I am not sure I followed this discussion. Do you mean that I should
introduce a dedicated LGA/vendor-compatible string in the compatible
list of the pcie-m2-e-connector binding, or that LGA-based designs
should not be described using the pcie-m2-e-connector binding (graph
representation)?


>
> > +             vpcie3v3-supply =3D <&vdc_3v3>;
> > +             vpcie1v8-supply =3D <&vdc_1v8>;
> > +             w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> > +             w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;
> > +             pinctrl-0 =3D <&nfa725b_default_state>;
> > +             pinctrl-names =3D "default";
> > +
>
> --
> With best wishes
> Dmitry
