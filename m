Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695B371CEC
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066483; cv=pass; b=pOWJV/UQP3n50tq0cl6egQsB43RNXT4KnscGzWp9PzdpGYeY1+J/VXMP2mxctm9ycBrCwa2QcK4ug5i5V9fbaM2I3pYRTfyfn7vcN02OWW2gcO7CKWEws4s/vjr8qp0c8uVlrx44fEF1JGF8KCB0X0NScWWwx0LXauJgIqHFQ4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066483; c=relaxed/simple;
	bh=DG3DBAzMZXCcZwMJjwpNQrEUC4y5CbZfP7CqYXPM65k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FouAwc7DgPtw+sbtOxFFr71smIgMiNb9FVJs1N0JWZSCWJh858KGuD3YS5gr5vSB3jxpIHXNDJn6dYtzA5+90TXld3QdAgRO02a/NXIdknErYyN41CMGg3lYffXzn6tJYWP/QKh/pr6n4grGXdBn4LfJhZd9QPPabsXZMlIsG0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MvotkBA5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WYFKssT1; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MvotkBA5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WYFKssT1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rjxB3147423
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 08:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lTiIe2AWI7dyCNsEc6sxfDRj/RtXLlxXxI5lpZ35yqU=; b=MvotkBA5JAzigAkW
	rBJB8JfRPnwBRCY4xzzwV0/R8SNO3T8kvLLQoPbqlZWoGSzt6WxcWgNe1sax3bG/
	jTc4o2wKAA+vS6hCiagwcdKj0cOwo7eI5QriXX1GdDwzDBW3DDLWcV7XBHCHvQWd
	WZlH3tfcEwwezQ/vMlIvbh+9xqw1Mm8e0yBoMY+UXD2Shpepw1v2cVrguTLYx7lK
	GEMreut7CawoM70vrb0jUqMjm+leWM7LDLxoKBm8E26wHCk/f58vHEjjB4m+vzJU
	7Ey1z1v4v/1ozIvXse1nwXV/tTG47qiVdPMsoiaMfh2zn9mI0xgfQL4Vi+EJuA4e
	2Dh6MQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvww7e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:14:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5e38fbc5so24939585a.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 01:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783066480; cv=none;
        d=google.com; s=arc-20260327;
        b=hvqXgfeSv3yx1Bd5Jj6xhW5p331RZhdaAxiJC16bftqIjrz1k3GvjkaFgmyTRNRl1X
         /f9B5tnmcx8uLJGmap5KYMWb+GRIGM8LWJjjaG9HZiL14Wm1QsaLys+ob/VygN65J0LH
         Wk4Tv/M5V+Msg2JfbKFq0bU2/mFMxmOzf/9OnK3Sx5SbE12MfvIb/uOnTCbSDYYU0xc3
         1GXlTBrvAB2cqjjD7ox1ZZBAsQ9A2IFB1VidjleDG90drdWMU5OB+XUDsGdaaYlnK+f2
         Z7t6BFeWDzgU+cLE7VBxN7OhT4/R05IdRqcmdW9rvAtjkJD/KtZ8eBlsoqmQuVhLZF3H
         ivzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lTiIe2AWI7dyCNsEc6sxfDRj/RtXLlxXxI5lpZ35yqU=;
        fh=9dTR3AEgo3gLP1cK57//eJN/2SdLbih5U3AvhK+7gG0=;
        b=KqbdFi1OKa24c2MZLGpuaZIc7pQGBJuWAH13JgoUR2wXIhlBbBWVQkKFXhLO5BKwkn
         lggYPpFP0a7VpCdMXWkp3jl/yge4Q5zqpWunU2ClBo+594Y0Enb4oH3HMKhuAcKSTtJg
         IUEdeeopwuIRM68+Lc1122/9e/Vm4SrPNZkljaLV8qu4A3Xz1nBeB+hlmFPN5eAdUC4W
         fXf6af/Ni6YMGEFhQtvyTsRnY7EG2AbI1SLjl3A78iVsBpXnAL7zWHM322xjDfCTW6gm
         1LUmIq5wbrmtsseDipKKMXXu81UAEOb714spVsCHEJo2XhbU4Pt+FncC3o6XBnPo8hks
         Lf8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783066480; x=1783671280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTiIe2AWI7dyCNsEc6sxfDRj/RtXLlxXxI5lpZ35yqU=;
        b=WYFKssT1IrQc4VXF9ILkqrIjuZDhKkBdU+mEGpXtiRpJ0UkEj7Vi5lfCFRxGrxPyYd
         QqVbst9V2grNMOuj8Ps05G5POE/F+VYPAsUnJOQfkdZaiT1jAWQDszrUlm0aYXxOt1rL
         hPZJCvJXa6Y/XlFzsl/N1PkYTTGUpLzBv7KCPO6wifnLKbSkGL4rbPO1HdSE5ZWPMYQ9
         imnLa0Bo7OacBI5rgzaftUwXDe/3fBTiGE6SJIRxYaZNwFbALnuC9m1FtwMZ+DdAJW2K
         z9PMA03vpPZjX3No3Gsy4zU7dK6bNTRtv/02+XyRRmiRdEVy8EmhFztPZFVxFiMKBUcH
         MxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066480; x=1783671280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTiIe2AWI7dyCNsEc6sxfDRj/RtXLlxXxI5lpZ35yqU=;
        b=BkE/lJfJmMF2TjYr3Wqvg7oZ13xptFeDPjWYXN/qx0zFRgRdiVNDlc7IemX0EIXa5U
         ciJj7cXEMojqo+C6gfKxt08E7WZGnip/huoi48VJT4o06eHzbKSWMzmQEqgUIjk9F2G9
         BiYJuL3CBprJcBuXW82gcZXwaKWY4ysnvC6bz5e8BhdkTEaheNn5MRINPYwviysWNIqK
         4R26oXfiDGDUIqwEnd0VMqY6gNjdpJbR+lDzNk+cQHpDf+cxlA0FA36L7EcXJlactSK6
         ji9yMVtpV0xdqWqTQpKJkjOkp+lL6dxAGW61VnM2IvXq9ZAgE7mQyOC0Sg2RYU0UML2i
         a6ng==
X-Forwarded-Encrypted: i=1; AFNElJ8rjmnfCzHs0HkCqCE7Wkp+1oPLsIoV9Yiyx+bC4zMQqWLyUrLCcXLaZ73z417UW2PwCNQY+tMojA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHSKAUjpcxCzAxyp6UE67jnPKIbBhPSg9ebKI8EB4DisNI+Sq
	tkL2qJ/jbsITnLD67Xhe07TJmvkPcDb7wIOLOQ7013LavzFb2jZby5zt9Yl3xTL/EMpNTAvCXBW
	D2cLhHCCsxT71rgCvTojasz3YLVrOIC3P5nvwvlBrMjxpulfNi/8G2PKw1/A5AP7D3KIrDGeKeV
	nm9QW/uCc50UBIIxoXRBKxKgsc57+ASRQFoVdx
X-Gm-Gg: AfdE7cn5wFFVShmBBuzzem32IbktNZCmDlBY8vluw48VHqJPhJmF1IssTaiX6j2Rb7t
	+AXVOBApeBOWiY6zroGrbkuI87zVrNuoqNIiqIFL+kqCmgn2Iu2freCs57gB8bvfRkOpLRJ2Eka
	dF11My6OPoFDepRgrWKizOogmAu8tUJ2/GuBmzvoaucn6BeqYloLbSuDgxUfwYiOjFgwGMEn3M+
	wOoZItI8mzYUVDsmO/AqN+oDwyR5bTYHAfa300SGSo1hqYsCbAooElZRTys3US8lhcwYvCfSBDI
	SpPAciiQ2A==
X-Received: by 2002:a05:620a:258a:b0:915:9229:4223 with SMTP id af79cd13be357-92e78506543mr1251476085a.58.1783066479664;
        Fri, 03 Jul 2026 01:14:39 -0700 (PDT)
X-Received: by 2002:a05:620a:258a:b0:915:9229:4223 with SMTP id
 af79cd13be357-92e78506543mr1251472685a.58.1783066479187; Fri, 03 Jul 2026
 01:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
 <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
 <rxt4n6vuscu33mrw24af72lb3s6urqfpkhtia44yfo4j7wtu6o@3xp57owekrgj>
 <u5ieok3hgjcf74sxjdzv6xurmlbve46xa3imgfnom4hpjarmxa@fna5daqpyk3r> <zat6uuvh7jwfxajvqtif6d67osf6h5b2vxig3bmuch76btpdkj@bfxjj7kk5fjk>
In-Reply-To: <zat6uuvh7jwfxajvqtif6d67osf6h5b2vxig3bmuch76btpdkj@bfxjj7kk5fjk>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:14:27 +0200
X-Gm-Features: AVVi8CexGaHIFoFTXJdV0YYDv7J6g3Xnp1ITKoqBI9DhryS5xqq6T1BctXtOEr0
Message-ID: <CAFEp6-2y9uZc79WSTeUYoNb=y16RGtkk6P1sAqour9hR05dNCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 1bzC4Mc4f9mTBMwC75_92IMX2DTOhFbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3NyBTYWx0ZWRfX+TIZySEiTB9i
 bhHcUsMYoECTBa0s50UbMqaW22zdSOTGkXJnpfCBLIYNQ9Nu2cETHTZ4gglar2QGy7i0uGo4cWP
 1TU2jtUi8cUfbJ+Y9RCO+jRmdflSx0AtomOeThLK3P6JZKP9mNfxa57iF1PuwUHAcuk+K3eUOid
 YxQ+zQV9XbRgIHgMijM9tDEd/ByTnlRz1eLN5kLTG+jVEkPDSIJW9T2K2H5y0y95CFNOFWwQfhc
 4xpAtQy7YfXRqHF31zwdpzcrAFXYyuV5zQ83ayq5zGRxV2zfHV7Hg/H8Y08tKfoE0MoYMw6YCTC
 JrBrEUuuibl/qJh98VGgVCqCRaakMLUe7wUBOTmkmsYghCwcftNj3nW3COcSgTp6YbcgvUsznT7
 hnEGceFcyPtdSWdEzNPSlDMLl2eW+ARZhg/wAlkBwqtUchBNAIY3rijjFTOScmxMNHfP07RaTT6
 kE4NNnrRDCs/Io98PnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3NyBTYWx0ZWRfX2cQW4yxJmwEE
 Z0SEzyRvz1a2Fr3BvAYUfEqJmRa7TdZrNMSPU2U2qk/HvE4aJ8tFvFbRW+It3KxVkFIdQKwOOBd
 btIsLfZSn5Pan4csvFP+M4eO8/hYkk0=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a476f70 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jXReHmxAYlc0otBLIJEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 1bzC4Mc4f9mTBMwC75_92IMX2DTOhFbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030077

On Thu, Jul 2, 2026 at 5:09=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Thu, Jul 02, 2026 at 05:34:31PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jul 02, 2026 at 04:17:43PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 02, 2026 at 03:14:49PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> > > > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART ena=
ble
> > > > > is controlled by the W_DISABLE2# signal managed by the pcie-m2 po=
wer
> > > > > sequencer rather than a dedicated BT enable GPIO.
> > > > >
> > > > > When the serdev controller has an OF graph (indicating it is conn=
ected
> > > > > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > > > > connector's power sequencer and use it to control BT power instea=
d of
> > > > > the bt-enable GPIO.
> > > > >
> > > > > Also allocate bt_power unconditionally for all SOC types since th=
e
> > > >
> > > > Can we just fold it into the main struct?

Yes.

> > > >
> > > > > pwrseq path is independent of the SOC type switch.
> > > > >
> > > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > > ---
> > > > >  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++-------=
--------------
> > > > >  1 file changed, 43 insertions(+), 38 deletions(-)
> > > > >
> > > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_=
qca.c
> > > > > index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e8=
7ae76fa00eda308e81dea25 100644
> > > > > --- a/drivers/bluetooth/hci_qca.c
> > > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hde=
v)
> > > > >                         /* Controller needs time to bootup. */
> > > > >                         msleep(150);
> > > > >                 }
> > > > > +
> > > > > +               if (qcadev->bt_power->pwrseq)
> > > > > +                       pwrseq_power_on(qcadev->bt_power->pwrseq)=
;
> > > > >         }
> > > > >
> > > > >         clear_bit(QCA_BT_OFF, &qca->flags);
> > > > > @@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *=
hu)
> > > > >                 break;
> > > > >         }
> > > > >
> > > > > -       if (power && power->pwrseq) {
> > > > > +       if (power->pwrseq) {
> > > > >                 pwrseq_power_off(power->pwrseq);
> > > > >                 set_bit(QCA_BT_OFF, &qca->flags);
> > > > >                 return;
> > > > > @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_=
power *qca,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Acquire the M.2 connector power sequencer.
> > > > > + *
> > > > > + * An OF graph link on the serdev controller is only present whe=
n the BT
> > > > > + * device is attached through an M.2 Key E connector. In that ca=
se the UART
> > > > > + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer=
 instead of a
> > > > > + * dedicated BT enable GPIO, so grab the "uart" pwrseq target fr=
om it.
> > > > > + *
> > > > > + * Returns 0 if no M.2 connector is present (nothing to do), a n=
egative errno
> > > > > + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated=
.
> > > > > + */
> > > > > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, b=
ool *bt_en_available)
> > > > > +{
> > > > > +       struct serdev_device *serdev =3D qcadev->serdev_hu.serdev=
;
> > > > > +       struct device *dev;
> > > > > +
> > > > > +       if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev))=
)
> > > > > +               return 0;
> > > > > +
> > > > > +       qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&serdev->ctr=
l->dev, "uart");
> > > > > +       if (IS_ERR(qcadev->bt_power->pwrseq))
> > > > > +               return PTR_ERR(qcadev->bt_power->pwrseq);
> > > > > +
> > > > > +       dev =3D pwrseq_to_device(qcadev->bt_power->pwrseq);
> > > > > +       *bt_en_available =3D device_property_present(dev, "w-disa=
ble2-gpios");
> > > >
> > > > I think here you are looking into the exact details of the other of=
 the
> > > > graph. There might be other devices on that side, while the code no=
w
> > > > assumes M.2. Or, consider having an M.2 controller which handles
> > > > W_DISABLE2# internally rather than through the GPIO.
> > > >
> > >
> > > This code only deals with M.2 connector in specific, so I'm not sure =
why we need
> > > to worry about *other* kind of devices. Let's worry about them when t=
hey show up
> > > (with graph interface ofc).
> >
> > I don't think we want to go through the drivers using M.2 connectors in
> > such a case. In the end, the contract should be that there is a power
> > sequencer on the other side of the graph, but the specifics of the
> > connector should be abstracted out. Do you know, if in the x86 world th=
e
> > W_DISABLE2# is a GPIO or is controleed by the hub.
> >
>
> I tried to abstract out, but Bartosz didn't want pwrctrl APIs to do that =
level
> of abstraction as pwrctrl APIs should be generic and should not be bind t=
o a
> specific connector and exposing its internals.
>
> That's why we ended up having pwrctrl core exposing the 'struct dev' usin=
g
> pwrseq_to_device() and letting the consumer extracting whatever informati=
on it
> needs.

Well, I'm not a fan of this solution either. I think we could imagine
a generic pwrseq_target_provides_enable() helper to query whether a
specific target (here uart/BT) is autonomously controllable, instead
of peeking at w-disable2-gpios. But that's significant work I'd rather
discuss and address in a separate series: it needs a new capability in
the pwrseq framework and changes in the pcie-m2 provider, since today
the uart enable callback is registered whether or not the GPIO is
present.

Regards,
Loic
