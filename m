Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675E3537CD
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729024; cv=pass; b=VlcoFLSSiJcvNiM/3SsOqS3d8Coa9S8QZjXAH243wFyD7MENYT+cpN3I8der4hBDyxYmgjnUBZe+LG0zWmDWz0TWpo3nwIBZS03V+gGE1m8P0tavsefGjAsWNpXxJDog9xfQN39VA+KIb90bcXfnbcpi77UUXe8G7wZNZRoEK1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729024; c=relaxed/simple;
	bh=9BXUcoy3CAeMSxcvCAPOfPkEc4i39QOOqpzCKSbVSoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpHPbTdU3yVlNkjQn3vSAMwMXNhNYF1PcyIj2laiBB7ZXB0/RSZzk8eHG+nua8pxMogoa5ndyBXxoZvwowa/X3QG8z4qewBcAxhlBiGHLhbgMC39Zp8HVsaHCzDl5kGisv62azTXFG7xTIMJu62vJoqL5sYgNVDhb6FN14aiwbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYm9xBcG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+EiTHEq; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYm9xBcG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+EiTHEq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWr7s755476
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=; b=dYm9xBcG8kVwxrky
	/bur/aKqjVfS0RYCmkdMA92gzwoWHtMB3+dfmWF+0449iVJo6Xzt9+OPidVPjQwR
	qlOQeL1+aD7HFoOYHVZyHd7hBddQ2rCN+q7Kt1qcXMrd8JCH575c4AOpqrPv4W64
	+55Wxx5YEYiccsjZPZY8jUh43n/nPAR5HzVnmP1Lsv2rm5zHKem2qAjSGZXFxGgB
	3m44lcZ8bLTTt48tdRhi5Cg0tiNh6hIvh3W8fxtn5BzbcWdq06cxx22SOtorBN+c
	dd1EH/t3dHT95y5qhRVQ1FcTwQDJs/485WRooEDavLzNJlFwGnWI1pfqrb6dF1GQ
	nyu6kQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4tg4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:03:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e62e3459fso2188591985a.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 07:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784729020; cv=none;
        d=google.com; s=arc-20260327;
        b=B41qH9R2vZTyrt9mOku/McBznRYILL0u0fQkXWd+wwkBiLzSAdwB/BJ4bNn3Cck2+H
         Pkmj7p8EfXkUZu2D/pNsXYO/O2p2xihVw7I6JJ3Ntv2ZqXONt44BHN4i8mIDkIVYUQn8
         XIf4Jb33KdA1QCrAwUsy0MxfnvTLLAX1gqGlD5CQySbCpC3uyj2m37jHeUS5AosT5Y64
         zyiY1jXM1la/z7EGoU5uJ/NMUNdTigyfog0PrY/44TJaojvbmB9yA7qfuZFzJFjuXdsd
         cp+vF+c9mHxc8Zj+96b8LPKrDfTPtj5+L6BnKQk8pxvxWx5H311+ypMYVhd34QgaaHiQ
         fIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        fh=zfuaGBq7AkimkFO9qMykbLofKShp4FJBb/R7RkSlqWI=;
        b=NoOXKbPgBpf57fUnMBTECKPsZMypPEwcFqCScLtgO+gImEtoqSdNd8ZIN9QwhDyfAI
         jUHWScUlD4RtFMl9iWgQfAmx02HZytY3fTvIYcRy0lKx3qLNxmEb/HVxYsPdi1phjiEZ
         ZHUjlOUCchTQ8dc4ZrpJso5WgEO9I4XX6WGmpDAKfM/UCKRwqNPRITP5JvyVi0ghoyR2
         F1/+Cmww2LAuvtbMjVeeprhm9W6MEJUfC+an3utDhswT13tC2eUT9N8cVdB8P45V8mKi
         lP54DqOXVp5BLbmynys/tf/4M9dcmwcidG2aws7eeyQ13ROvG1/TcdBkzvFfGH7zUhPo
         Gdrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784729020; x=1785333820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        b=K+EiTHEq4bGq7B7wQS2xXTUsD2Rziwlc9qlY3WyQvkUfo+C1Crki3AmQZXcb2NB08X
         ANh76zXyUEv+6N7WC3umVwG8TpUlyBxQt4bGmt4l2E6QzJTdTKfyxiHRxjoyBi2/dJQJ
         g0eE2c+L6k0/Yo2xJrqn2mUmORUorktWR2eUCulwODL1ERiYNGga99DTSP94f0eCopCj
         OCUdQDBPHVhPfO600Hbvcy3Iq2CJafpxl4XMgQJk4BkPxknJ0serTF+m9Tu04INsWHdN
         M6zk6cNCSwf8nxKjtdJhI69XA40gas3Orfvsiygxjac0W78iyA30D8zza8SMq+vRW39/
         tjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729020; x=1785333820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        b=oNCSbM67dIsr2HJJ2eSLvSNiZOxKX8Q7t3hWzkxGQGOJ6Cv/+G6wRKj6F2gxbX+azw
         nK9n/qkRS4Zrlt9Z33UVP0KLz/H6D1N1z8gWP3UZ33QvtLvRG8ZQvJkOOjlaWhCC3/xA
         LHVgcaOmjelQa50mzpjR0nggbEVJ8YtTqtrvYraLmjar7FjuN6o+v4EdpUCMm2hHxGhi
         0hoTo7L6fz3omhza9iwbrAU87aZ+v4MWiFgnGObouHwL8XmWOKdFPbsCutsajkrD0U7I
         50mN29p7WbCQjTI1IOSOFw3OgVqtaFCAI5vkrbhwSc4rWgwjLHqxK3srVGFXVah6F4Ek
         e5PQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeBQ2eGAi2JmKdhkrk9GJDghxAg5XTNapaB/KhGOUHAPgkTdOTDdPbMpd+l8LZzFNJxDHANARlgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHYCGtFixN6OWjbLk8Q53XuimLSU5LVGWy/lFNHGbwICa/ZEB
	uFQnJXy9/JBQyI184WQdHNHc5buySx/6zho/2yFKMEgLaenSbwVkQ/h+gBbTHAjNJMnaFtXMG3P
	DA9xvf9hFHxY621C8xYwOJHZrrGdHDp4ObTdYmf6bscu4YnXl8/slNgLKXgpuVQuSvSC+eZDIGq
	Qe8Z4/Hv31iTOXLt+YFroBDjR7srnHdke3I1fu
X-Gm-Gg: AR+sD10tVY60tqrzrBVwSjV47SyEllXoTQ4Pmr7uDcxgikpAvrY3nfali1uW40OKRa0
	eOwTWgnkMSC7Y91+JfMiWZPBI4SLi2rFlP3IR4LsmnhmN5Wv2+SSxbRb7mtx/CBA1vt8IgIsCUF
	8rDNBHDC2mLuyoVgbUZpyeGpXyLyrXk1ngrte7mIr4JR3DIUYYiktMQgrTaCyv/iQ57knuEyNrU
	+fGwcCpR1D931wq8+BNauztQK4oU5Sa8+beos6JpHcIH5lGwGHquaEwwm3Teogw7n91ruiaXks=
X-Received: by 2002:a05:620a:4514:b0:915:a953:4b9c with SMTP id af79cd13be357-930b3e9c3d7mr2246943185a.3.1784729020153;
        Wed, 22 Jul 2026 07:03:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4514:b0:915:a953:4b9c with SMTP id
 af79cd13be357-930b3e9c3d7mr2246936485a.3.1784729019587; Wed, 22 Jul 2026
 07:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com> <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
In-Reply-To: <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:03:28 +0200
X-Gm-Features: AUfX_mzfczekzqEbUNlANz527n61RHWYJ2fg8CBXx6C2Qs9MbAYmlEYmPQ31HQs
Message-ID: <CAFEp6-2_ah4D2ZvkvwN2hYaJ9adYT7i3Rr9WPMLUXtzk984Htg@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
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
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: fBk_dpBA9Gukjo4CUrAD5Ngl9Nr3lXBp
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60cdbe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=Z-KoOJIlDxAInEDke3kA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX1bZ5HuBlAjAo
 TNYopjK68xK/z5wuA/YeVkssbPSet/jy4rbpuDyIsH0dx27qTUV6Jseve+Lv9Aa0mLIHpgCFLIo
 SVPUmUr0ym2wV+rpsJhR4YXhdWAFAOEQ9l8RUdDxXfUVQx6yo6Xg2+d+Ad6WQilwDctmz6+ejtM
 FncsgDpQ7PBR4awpOvxs6G72Apz6plPav8JzK2U5yEXHHzb/zZXjObLymV8PrwpVm9mUYCre33Y
 9hs2owo7Dvow8PAnSVe270GP1qfhmTewHR/x5dJoTVQ9ADWJ46TcC33lU8WAp6uI74jq9+6RgS9
 IxW7V9bJUqjxGAwTJnuKroQceuaki3cTwNQuodJLoJD4eBZQsAbKpcRpRkgqtUei8qMoV9QUQM0
 b2cIY/ewxADjVremelVzU8l8uXj9Dx8KMbi7jCzP29Jz6kORXegxFbCC17I4O2UqwmKu3xPVhmE
 IxFe5K0ENm/0whLafWA==
X-Proofpoint-ORIG-GUID: fBk_dpBA9Gukjo4CUrAD5Ngl9Nr3lXBp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX8x7op/aHjJuE
 1yn4FxDD0XOsgJpV+df5X0AQwaEl4sy2AgWnKMm1TI6LO9JJf/K/nOP139Xr9S75dFAkRMNWHNa
 vIGIJZaZ9nel49+Jzg3Sbb+3ilIrbTM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220137

On Wed, Jul 22, 2026 at 3:19=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:04:09AM +0200, Loic Poulain wrote:
> > 'bt_power' is allocated dynamically only for a subset of SOC types, usi=
ng a
> > switch on the SOC type that mirrors the one that follows it. This is ab=
out
> > to become pointless as the power sequencer path (used by M.2 modules) i=
s
> > independent of the SOC type and needs 'bt_power' populated for any type=
.
> >
> > Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> > allocating it separately. This drops the extra allocation and its dedic=
ated
> > SOC-type switch, and removes the need for NULL checks on the pointer.
> >
> > No functional change intended.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++---------------------=
--------
> >  1 file changed, 26 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 81fa41915363ce577ad7c6f25fe1b0a69536d462..7e4cb03d3db0722e5f9fa2e=
7a5a9a0894bf4f18c 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -226,7 +226,7 @@ struct qca_serdev {
> >       struct gpio_desc *sw_ctrl;
> >       struct clk       *susclk;
> >       enum qca_btsoc_type btsoc_type;
> > -     struct qca_power *bt_power;
> > +     struct qca_power bt_power;
>
> Can we drop it completely, putting necessary fields directly to
> qca_serdev?

qca_power groups the power-related resources together which makes some
sense I think. I don't mind moving the fields into struct qca_serdev,
and that's a straightforward change, but I'd prefer to address that in
a follow-up cleanup rather than here, unless you see it as a
requirement for this series.

Regards,
Loic
