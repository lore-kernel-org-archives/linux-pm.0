Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC42882D6
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466286; cv=pass; b=L6sPzWQNvnLN5q/kgnbg67b4X/JlaRjsdGPuryxyc0PdOHerik4czlnPHgEgsh+kJ1zP+UqmlJO85uARlHiw597gIeYr98nXwZ5tzqdfXMSttKuNtkG8LwWxzMmALEo7dAMeymLpXezFSvOPclsCxDCuzVbAm/l584AmvlN5bKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466286; c=relaxed/simple;
	bh=bLtI2OBA5rafdql0eae6MY8/XGVx80bBush8lA9uIPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYbl7+9xXU/9LU8XJZqZ9ZmErZMttliOIbblLVItPa6PAAylgns4A1OPaJCWnkDJ+tdcv2DfWkq3k4KR5zSNxl9HHCDQ37RaMQFUmRezbp5CPreG9jPGUzUZvUlxMkRfYSpeNhpJA2n+OYzfKD/AzRBxJMd5iNw9Rk1k8jE+Xj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8UL5tlt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ab7yDX+7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8UL5tlt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ab7yDX+7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MBwFr01297937
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=; b=C8UL5tltXnXU+6nX
	jHhbbZeMbZja0B7v1zrospoXn2ug1pL3ImgZciQ7OI7Py4ei7tviaRBOQVb6TZ1r
	7I6Sb5E4UsdKg2h7pRgaEEj5/YV1kwv/Wjp+ceh6enYt2BxwvxAwubUsJLS51Ohc
	d5cBl0XI2mFp9IWXX0Kfda9Zl5qiwh42eMTwIE5X1jsDKzWDHLF8Zb5SGuy7KHhE
	yiAXYXtAXMz/bAsnEaIqUKCqh12KIGXxeMogYcgjahBO5eTLbxD6Ss+r2P1FRlzy
	8oLVz+bFkGxYTiKaz1mHJxjjo40BRWgU2Am9jF3DdDh2Uc8jvHTiiiE5YVNpqxGQ
	SlI3zQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0bwuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:11:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90f5248b209so355805785a.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779466281; cv=none;
        d=google.com; s=arc-20240605;
        b=X10CKZ8vckFY9OMUEwhSZae1SB8Tv2p6z1HJba/GdFbb25Ymy6tGwEbeINEj1WHibj
         TlFFcp6WT/eMZNTEYkoKRw45kONYpPnh4w/Vo9aylk2IsSB53nwB72ePWKFfiXshV/84
         6zYdIAa0EBwf2hhdGI48glD6PD0Mi23h+xBLx/+Wv54nxbIBLCcZcJ0ULQmk1WpxCeY1
         lDmV73tYgnpAChMyYsW3Arw2OgzdNNc4mu888HO0YDruqMgUs4Z5f4aljVEku7lMhlRt
         OpZLyikCWdjg5HhzqHKfbnCiN2lqdLGieen7ENAA/xDvhinILc48D45ZFFnGfHxtZBi3
         +Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        fh=7x8fuVPXWouGEIe90ylcymQKt6CenQNGJDVdVfdV1jA=;
        b=eyqLlonEDt7721UiRnUI9gagcrNjo4lD3521TzAcXaU1WBmrkYKwRcxeWFlLlZ2BLQ
         APFszj0mJbvYpkIu0zrqjqQuzqy01DVPZi4KKXM4AV47t65Refn6AkJ1Wh7eH858wTwY
         fDx5ZHh6RW7HXFswdr9XGOE/OgDWdsaa48ER/4H07qFHJh0GzyzgAf+6RDPOC8JZtTqP
         O7dlG2qHCLl+KgmTWcPxELN3GwACsfndqW8xyYpYrducbKTT86YnZK0fu6W2MgJy8Lcf
         pLFkEiDCIFsWsHHQsrV0bgN3LMtmlEJrwOvA5yvcM/ON5zmNMLh4h336df3bPXKFgHHZ
         X+RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779466281; x=1780071081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        b=ab7yDX+7wHyPQLuGi1en5pfbfQfl59c9deiCGFVI1FJDD/Nv/TMXhY+nMl2GjWOEBS
         tvLp+pUuuQa3E/W/Sym0mij+VVP9qVZL2bCsTA5iCizlh6cuiRqlpYgvPgIYvJiB1nkk
         lhyIeAOpdXHMxlbPFInMFsXW9mzOQgptTHJJDyJaCXk4F+4UUjX3oGCGtdMqUeTZNnSQ
         zjsAWoyZeTh9dboFkNypurPhcyML/Be8CWgYZVmUTyPOSSVx0MvRrcgrV9sIczJzkGGw
         ClFYASUKNyqw8A1NYTCI3HJZMTK/l3oTsSSqFWlDqMuOaVbUfmqcRdidoZMrN24lige9
         TYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466281; x=1780071081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        b=DI/jUiH5W9YGnhGGvBkTqolYKckv08nCSrKlGexr9eBrGtSJlSAd/ZHpLxEmNw073L
         f3R1HfW2VYUCqg1iVHL+fUI0BCI7SO17o1jANHITsSrtcDeHgAhzvDqGM8+p8boxhRBn
         FaXEDuDTJziITLaH52O/QVBX/sFILO7JMkW10Pnl94PziBxQesb6yS065fxe44QN8v8p
         YD0FP38JgdXgMihVx1ZHS1RkrauxGuQCge0vBvuTSqDKUvIYEb2JKQPrP+al5W5b5CCI
         zopUAktQTzF+pJOkK0l6RZ7E6ZKLmZzQR7fdRHf73ATS7KqsiY6sfmle8S/EIn/VhWic
         bZ8g==
X-Forwarded-Encrypted: i=1; AFNElJ9jc/qlTBR523Gds4Pe8L7f5a7DeBdCg1whSRaA8QXdnmaolc4ZWCvF9j94LjJTcdVsMGiZM414OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9T6eCXDz9cHJVqTep7/A77Q415W1CFqCmfs0L/+azotThh+CC
	P8ETnNTd92DWxYoWd8nuOzeWi57YkUM6Cd6iyMiEMYtim297Wum69WMtU2y6m0jKaQHXGQ5jS/m
	j2ibpQgJ6WVSWl26rTc+NRNNzI+vjR+UPi3X9Gj2aHB6oJmT79VR5v4Wz3aus7ksCSjBJFellaL
	GTPAFAZ3kRAfgiMrp2e857ULvjvyt0nlRb7qRY
X-Gm-Gg: Acq92OFN7CX11hcRg6Cd458oTPHJuFRyE7yI1BbjJMx6bnn8IqQebL+M+28ff2ld8Cn
	OhHSmc55Msr0186aVpBc5e+pidnNzZ63jhiU4CQZaJahvbbWho/bB3y2X/qUVZLrCY5Pt74s4HF
	o3dyzl+GuJ063okkpTdZBdVR+GJdP1ValWkZBJlN+HhtwYnmYhf4wljfXymeZXMH/hxV1T7f1fn
	s0dw3vTDplkc4D11eF9QVrBqkKAFf6J+oaUCkM=
X-Received: by 2002:a05:620a:1d0b:b0:90f:9cde:9788 with SMTP id af79cd13be357-914b48d6853mr675636685a.5.1779466280576;
        Fri, 22 May 2026 09:11:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:90f:9cde:9788 with SMTP id
 af79cd13be357-914b48d6853mr675629485a.5.1779466280032; Fri, 22 May 2026
 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com> <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
In-Reply-To: <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 22 May 2026 18:11:08 +0200
X-Gm-Features: AVHnY4KZcbVzn920hjyxYOpqLudIDkA1KQq_MhbagXA8SoEUbTo3JjxoNdQTHfM
Message-ID: <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX+hup6Hndq9Dx
 b7uw4mafTzpXcmdpPPTmMhor1t6w6Fwo+DeLYXIcPkQAj1jLcKH0qeGJRvRGj8Ua0NTu+SqEH9D
 FiO7f3bMtryBYaz5oqlKAf8OI53sdkR525Q4+5u+lKAGddco2cK145B9XFUIGhF8X04pS/iKYRt
 syd2l+N+yFum9U0i3/hB0wopud8LUAo7X6svXguOHG+31gi7Sfox5W25PjT+7TmKMILHWmWN25N
 SmF+ozQlpEDpRDqBh0nRE8BrZk+eTryhY6sNX3G/htq4rSevMO675SOx3nYRzEOW28Bg1LKzXX6
 uHSzzqt4LRn8RAZWk+H+nPLUbq/p+0rr+tkOTb8iGYwJcRkz4yEDdn3+igUI49VKysJPs6zx/t3
 cCvFaGAijgAbgAymF3PrpTU/Tz381N0A5LT7Sgb8oq1diBPunRfuRUNkV1UrxnIdpcTBvarEqE7
 AHVl2GIdVR/1M0hS4Pg==
X-Proofpoint-GUID: fRegqIemV2gA7T8JzqZLImRiuZd8rz76
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a10802a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=O2y7hZ9sxHz_cEH75X4A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: fRegqIemV2gA7T8JzqZLImRiuZd8rz76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220161

On Wed, May 20, 2026 at 2:33=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > sequencer rather than a dedicated BT enable GPIO.
> >
> > When the serdev controller has an OF graph (indicating it is connected
> > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > connector's power sequencer and use it to control BT power instead of
> > the bt-enable GPIO.
> >
> > Also allocate bt_power unconditionally for all SOC types since the
> > pwrseq path is independent of the SOC type switch.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5=
d670fa2758d3268d0 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power->pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >       else
> >               qcadev->btsoc_type =3D QCA_ROME;
> >
> > -     switch (qcadev->btsoc_type) {
> > -     case QCA_QCA6390:
> > -     case QCA_WCN3950:
> > -     case QCA_WCN3988:
> > -     case QCA_WCN3990:
> > -     case QCA_WCN3991:
> > -     case QCA_WCN3998:
> > -     case QCA_WCN6750:
> > -     case QCA_WCN6855:
> > -     case QCA_WCN7850:
> > -             qcadev->bt_power =3D devm_kzalloc(&serdev->dev,
> > -                                             sizeof(struct qca_power),
> > -                                             GFP_KERNEL);
> > -             if (!qcadev->bt_power)
> > -                     return -ENOMEM;
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     qcadev->bt_power =3D devm_kzalloc(&serdev->dev, sizeof(struct qca=
_power), GFP_KERNEL);
> > +     if (!qcadev->bt_power)
> > +             return -ENOMEM;
>
> This builds bt_power for all devices even though it wasn't the case
> beforehand. As such, you can drop all further `if (qcadev->bt_power)`
> checks in the driver. But, you also need to check that this won't break
> support for other (older) chips.

Ok, I will do, and double check.

>
> >
> >       switch (qcadev->btsoc_type) {
> >       case QCA_WCN3950:
> > @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >                       return PTR_ERR(qcadev->bt_en);
> >               }
> >
> > -             if (!qcadev->bt_en)
> > +             if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))=
 {
>
> And this breaks support for pwrseq for non-M.2 BT devices. There is no
> OF graph in such a case.

Not sure why, here we handle OF graph as an optional pwrseq provider,
but still support legacy enablement.

>
> > +                     qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&ser=
dev->ctrl->dev, "uart");
> > +                     if (IS_ERR(qcadev->bt_power->pwrseq))
> > +                             return PTR_ERR(qcadev->bt_power->pwrseq);
> > +             }
> > +
> > +             if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
> >                       bt_en_available =3D false;
> >
> >               qcadev->susclk =3D devm_clk_get_optional_enabled_with_rat=
e(
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry
