Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C93911C1
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618973; cv=none; b=NqMHCdP2Lk2upqrqFmDCpgWtZ4/GyKipkm9flbDQKLN6LQTgs3IHhoYYgR/AIBkIiEUPOU6fYzdf8rdPAvZw+kXf19STnPJO8LBKyCSXRAzaVK8sS8nORnwvagJCOk9HN0c0l7r1SKOP//bqxRrLb8Uq3DlwpEDWwado5GIXmkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618973; c=relaxed/simple;
	bh=+W1k58JBpvJmrhRivouQ82SbjAmlk6Yeva3tSpfthIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoZEDYG7R3tu75wGWcL5qkupZ1Wc9RO6eWFx1iyvJk7xrtTqByiXrVVef+s/6KGMbctyZD+rUj4qYIo65VvlzzDjAcpS1dS+RS5jAL28MNH+P/voSkzn6ZmAs4lARjOZ1Mgk/4tYA78CbkXsNxgMwUXTGvBkdXEc/m33ohSgw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YBaMnBO9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h7azXtik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBaMnBO9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h7azXtik"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O7DNlR3943850
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 10:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TL5YCAu4sH+fnNry4R/TvUCKep+v9hMJ+/m2KMh4fPo=; b=YBaMnBO9h7HfJ0jE
	UOUeV9LyRqaI0JG9SS+L0kXygDLIgjqh8mIDY2AskCV2oRrmVAx5v+FOPZk9Ufea
	c7ftwn66uALjMl6Tt3f/rdSeYOI9g+FsLjzC/p9AND4vOB9hWzth+YmzSi9XFXJg
	+hw1WL5R0Vn7Gv5vUf6PkqZOePRu0YMFR2cNSWZPTtj1iOykfGQYWEhCAgYqu4PC
	I5xUI928ebIvxm3o/s3dQwWOMwBRcwDX57Alf2WoVXSO58Y5DtJesEwp3SMus5iA
	09R5bAEx9m+LiTEgBk/OocwrL2/wieVYi43jQ6VKor5azjuDBeph0czLBvfEx2MT
	+BaQvw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmkcav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 10:36:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516d191f2ccso57677311cf.2
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779618968; x=1780223768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TL5YCAu4sH+fnNry4R/TvUCKep+v9hMJ+/m2KMh4fPo=;
        b=h7azXtiknPOO6BlLoB4hWU18D/9LJJsHT9UyuxNlH/ZVAbYOaKjNxtOF6SdX0oEa8W
         6OZxdpLAkHGjjNkrz4PZU8mbDIbPm95PqhgSFwNg3HB56gqvNHOaHJOClkBMNGfcDBdp
         dhRkkW2hm3dxGR5iHeUOiikRNgt2wjrp/z8DRG2lSoqhtBs1UuOqZAsZRslA/ajEGNu4
         hey/LfY7B4kBDv5W8+f8rI+A18p5JuRGUX0uky1MHyorveHLJ4RPX5Zg2WaLlLJjVo0x
         7avLPHazvz+jG3sI7By0jHE8yQmqXf/sxtlcr83yP0CuRvn6u29Tl3UkOaMpN9d6HUeb
         G0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779618968; x=1780223768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL5YCAu4sH+fnNry4R/TvUCKep+v9hMJ+/m2KMh4fPo=;
        b=dij4xxKc1sZw/v8kTF3KF+6vWFRcyOToqxG9HYQLb3Gavqk9bvk3oYDZ5VzjMWrCF3
         xF6Ptt1N1Qbu8DMwd/4uZ+CXB6kLRF4+sE9cdaetb0WwnwSSg83ZzQ2QxMtvsWJAptrz
         p6J4D2l4kHmULh85IvyLChHNdSc25V5yb5nyLMj2BhwSW0NBMzQ+xorwRMIza0KGmANJ
         beQyxWWDKIlHtvAgv/qmbjHRaET4KLww0SrVEnO/qCRKBAPuYtrrmlMTsZBzADqdeazN
         344XOGeUYaSme5pvbEUix2lsX/Ydunr1bAzWy9hsrGuyvOHn3b5FVLdeHS5cgxgF3cl1
         Nl0g==
X-Forwarded-Encrypted: i=1; AFNElJ8THHFy85Url368tmyxu71E7WmvVeuz1lK6LweQw3IISG9gmF82N6L/p34M16APfquOuD0IAVGfFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWGlgX4NVa7XlQSY/dBLK0FjMEw+MioxsLYxBjbXUzFYfWlZs
	xI8PtssKviEjcxfpH+gQfFt6O7i4V7rwJUwQxCaKJdlU3Du0bXbRCsAOg7MWoZgaKVm+jSSchvO
	86CWEYeQKB8vqSxWdNruciGWS4fnwCFudS/tC+LDCUJ6AoN5SDKEL1EQFF6VdmA==
X-Gm-Gg: Acq92OEaSPHoy1+KY7QgR/UcrM9VsVXtLKmLERTImAuOmdtRF/+aH8MR2rAYf91Bkzc
	VMGl7LUK3uqJFwQmbHu/6JaHOIJ/mV5dxe8lhwMmLInA/PwpDNl5bIBHX8AZ4qMtUPKSx1fGl+g
	aOsKNsKtvABAE3nG1LiNnf2GwVpJYZaMn368f0HTIhTbpg53eKEFuxYPNI/OGQS93kM471ozB2v
	1nY/laWO0lHTXjmfFsrZXvnFUOWc1SgFc5aLBDy9ucEtGIwkFGqCrImRMZ0knPfCe+Z9AEb4n81
	WdHTNPPHBRvEC9stFxj0zTMGLjvCgWm1LVJJ76aPzGuM5R7/qqnp9Xf7GA9mxWC7hdmsA8QBSOg
	Qb43+5zzPCQxUj5QM609odPlWGYTpSAFAjzCTOd1olu7rbzeEPGFlD6ovtei9SbqoUM0HxbFncB
	Sd8O9HPgAjt43TcLCorvQcMx2qGrvjs2TQLUg=
X-Received: by 2002:a05:622a:d01:b0:50f:be4f:465d with SMTP id d75a77b69052e-516d44096aemr112265811cf.46.1779618968337;
        Sun, 24 May 2026 03:36:08 -0700 (PDT)
X-Received: by 2002:a05:622a:d01:b0:50f:be4f:465d with SMTP id d75a77b69052e-516d44096aemr112265571cf.46.1779618967906;
        Sun, 24 May 2026 03:36:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca02dd6sm16266821fa.1.2026.05.24.03.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:36:06 -0700 (PDT)
Date: Sun, 24 May 2026 13:36:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
Message-ID: <hpcitldndtwoejbfsxy4e3f6flurmklepyzdpvbm56233dmwn7@eyvf6pycny5c>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
 <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
 <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfXzH+iddmlfrsW
 /RG37KkXlz2/IvVgB7sls1rsHvkcQebY/Hpnb6E7c9pOqKKSJVVWo14JLFfFpjeKX3xvcZM/n+B
 6sHmXI0KOkMenxGTLus8e/7+n9zvDnnxRnwzPTDrvNRgo5o4D+WBZ1qWnJtArHolGKSvKBKp/bQ
 pSDgZGKRAfcUDda+77EBA/iTWp8B4sKoO+iPCnd7wKCRFRl5WLaI2VMueX8ycg+l+wRguF+wuZU
 beyJSHGBk/1y+lfvaxkCiPiBu1iBVCrMOGZmAMgF15Hoj4/98XH3Pv/RYAAiWyz1t6xHaryEelr
 A9YNmf9JuwF79hdq3p6X+n+eVuEpbskcwAbzU62wyf5UenfeOV6zQOjWZYyMqK7JfZWOTmPrRl0
 ZASgPJm8WjqKUu3NFBFcJgklc40POOVoiw/w6eL4plaVX+LY7ZVmF8lrobfMvpFcczNiLohXRZM
 s2fsY14fMKaTx80Gg3w==
X-Proofpoint-ORIG-GUID: XCDV-nBJ8dnAVX858-_ncwYewGIPiZeC
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a12d498 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xdS1LbVOcY12UDyNXlwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: XCDV-nBJ8dnAVX858-_ncwYewGIPiZeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107

On Fri, May 22, 2026 at 06:11:08PM +0200, Loic Poulain wrote:
> On Wed, May 20, 2026 at 2:33 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > > sequencer rather than a dedicated BT enable GPIO.
> > >
> > > When the serdev controller has an OF graph (indicating it is connected
> > > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > > connector's power sequencer and use it to control BT power instead of
> > > the bt-enable GPIO.
> > >
> > > Also allocate bt_power unconditionally for all SOC types since the
> > > pwrseq path is independent of the SOC type switch.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
> > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5d670fa2758d3268d0 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
> > >                       /* Controller needs time to bootup. */
> > >                       msleep(150);
> > >               }
> > > +
> > > +             if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> > > +                     pwrseq_power_on(qcadev->bt_power->pwrseq);
> > >       }
> > >
> > >       clear_bit(QCA_BT_OFF, &qca->flags);
> > > @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> > >       else
> > >               qcadev->btsoc_type = QCA_ROME;
> > >
> > > -     switch (qcadev->btsoc_type) {
> > > -     case QCA_QCA6390:
> > > -     case QCA_WCN3950:
> > > -     case QCA_WCN3988:
> > > -     case QCA_WCN3990:
> > > -     case QCA_WCN3991:
> > > -     case QCA_WCN3998:
> > > -     case QCA_WCN6750:
> > > -     case QCA_WCN6855:
> > > -     case QCA_WCN7850:
> > > -             qcadev->bt_power = devm_kzalloc(&serdev->dev,
> > > -                                             sizeof(struct qca_power),
> > > -                                             GFP_KERNEL);
> > > -             if (!qcadev->bt_power)
> > > -                     return -ENOMEM;
> > > -             break;
> > > -     default:
> > > -             break;
> > > -     }
> > > +     qcadev->bt_power = devm_kzalloc(&serdev->dev, sizeof(struct qca_power), GFP_KERNEL);
> > > +     if (!qcadev->bt_power)
> > > +             return -ENOMEM;
> >
> > This builds bt_power for all devices even though it wasn't the case
> > beforehand. As such, you can drop all further `if (qcadev->bt_power)`
> > checks in the driver. But, you also need to check that this won't break
> > support for other (older) chips.
> 
> Ok, I will do, and double check.
> 
> >
> > >
> > >       switch (qcadev->btsoc_type) {
> > >       case QCA_WCN3950:
> > > @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> > >                       return PTR_ERR(qcadev->bt_en);
> > >               }
> > >
> > > -             if (!qcadev->bt_en)
> > > +             if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> >
> > And this breaks support for pwrseq for non-M.2 BT devices. There is no
> > OF graph in such a case.
> 
> Not sure why, here we handle OF graph as an optional pwrseq provider,
> but still support legacy enablement.

What about the case when pwrseq is supposed to be used (via the PMU)?
There is no OF graph in such a case. Please check that your changes
don't break e.g. RB1.

> > > +                     qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> > > +                     if (IS_ERR(qcadev->bt_power->pwrseq))
> > > +                             return PTR_ERR(qcadev->bt_power->pwrseq);
> > > +             }
> > > +
> > > +             if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
> > >                       bt_en_available = false;
> > >
> > >               qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
> > >

-- 
With best wishes
Dmitry
