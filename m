Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CD3D524C
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093372; cv=none; b=sQPexg4ovLHUPLvaW8vJM0BVblSkcVwSmTCe5y+XXsJtUbbh6daxDmo+dXzugFO348XBBR904DIsTGww7E9QEW+xxzmrGnaws2SJnoBG5/5mWB6ZyyASWs56eFuYK1xsuGOd/azTtOCid/vAgwfGTFnDjAJMZtQXGStNkG/yd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093372; c=relaxed/simple;
	bh=dGpqlOqSR01XHv3OV+Dnkr1uupemNZ2RhLc1o8MWR6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Z+Ysj2ZMVIOSnhJfp8KtRFsuKW+6Nc1aAnvW13vE3l3asgEPaMFgyXmS9C7h8tv+Kz4OKv0zPBCNi/Y5Yem1w9GKJwoCI+HR3go+FPFnXm99d5kIPaCbjI357NFDPFxfWpNO5yA7PvRCZO2gn9TsGlqNUdnLtzkHT/ZxWs/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HS+QXMBg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lf/VWm2o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HS+QXMBg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lf/VWm2o"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D1HnA054343
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 15:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/uhlRmvz/WQjjbKiBFfgMn1G
	5ciXJwRFCcXq2LAY/Kg=; b=HS+QXMBgorYfQjx4nRPZii7yBz4DHXo1HQ2Sy2Ro
	rrmh9xWGHf8+peR+g7CzGfBd5iWLeAdPj7nvLE2Wxd4DKpC66uGuT6RyDVbiYagH
	mxbiKKOj0pA/0Y8aVS974AuJbvmz4t4BWDaLhSfFbh0NsjtQ8AGswe41W6fK/2/R
	F1Kcm56cpSK+imcs4mWRW5mAMSNSGPLDzVUoFOduRNBhrguhdl15uuc+0WoN04Lm
	YHNy9gNtwbmuaBvvng0B1A2TroJUwvLGSqILXgbPzlSEOov/5NB7sOfiruBB4Lec
	MwpjLwuiKJ/GWPpc19essRL1vnvF3AMoPez5pbDopGH3oQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkgh7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 15:42:48 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5954c5fbcc7so525264e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783093367; x=1783698167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uhlRmvz/WQjjbKiBFfgMn1G5ciXJwRFCcXq2LAY/Kg=;
        b=Lf/VWm2oyr1p06nhaEDvq10SNZkgr74dP7N58zP7Ql5zKelTAs0rrHsmk5orCAnnu6
         FYXIN4DU8GrHYPkOzK5LZlpD1iv7wXFOfk+BRIdN6cNSOvKIFScmi6YoD8AvFXOPCBK7
         QTrqN6UJjO0GOXAoogqYThLfTzzbNy4mhG2kl0JjK3SzTuX0ZBPDE/JhH6op0TZVdAhS
         FKfqoSySSYSwjIl/Gl8EiAeY2ascVh+q7EcOCuaG22bYTbWTL7ImNC3x0rkW52BHFnf7
         qQEVJe+xARQISJ96Jvb/t4tHWaBF8gWmrk4CoKnp8A6tN6mEBamGa/zoTK629mxaIJbT
         XAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093367; x=1783698167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uhlRmvz/WQjjbKiBFfgMn1G5ciXJwRFCcXq2LAY/Kg=;
        b=K7Z6aSscr2lGrcIlKwpFwC5kRfj/syuE0wiRFBJ8peMvMZ6wIYMa/SXLMLv1ocu/XL
         Zn7xIADHh7FxMSUQYlsZHJf0P7Vn60oz+u83VnT7otjrB9wUM8IWxIPpJYF+VQUoFF8Z
         JTToeTu/rUaN4VvEdE/A9O7LHZzHnpMYMaDaMK1HSOMKo61D9dtTScL/kBXc9qrgDQzJ
         9XbaSsOfCifpgrOLuUz0h59Qj9cJpnFcBSgUCsEVL3ij09BYWFhkmMFBBr+mOzcyIYnM
         6POwTA50ziEZE7hJBwRvfYkConCNjO99jMjPU8azC/mvwoLTe3uymtpDVB+ubofgg6We
         5t/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Kicx24LwCnVfZo6IXA6z11qj3uP+eVl/HPiWTbEemxFp34yCX8yI8W6r2e7u6jWFrV7qh0aK9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyht9p5jQ9ZMOs6+IuYv2e5CRbuN4i6FcCTgIIyyroHhMWg0fDY
	ylECll25aPchUSfmuEVJlMPaFdCU5eo05hgJUroV5Et0+vw+G0BpiRRYm17dIUjm9nUIhmBK5+E
	DytbV8rfXNAtecU7aoWW3mbAHjeN8gcPv69nvU6UMq7XHOlrjO1yxtgUxs02i7w==
X-Gm-Gg: AfdE7clPYc/UhgFJWhpv6P1DEhVW+t5DjEMe4gJW3ouZI0SkmlkWY24JXGazlBsNp4y
	Ch6hiEINua8LYC5UZy1Q7KC2xP1T5wrdeUDRfTOuZs92gL0BdTil5yD7CX7LHQyu5uMZSt7cpEK
	eAtY3jHRXlDSD9xGTW2WQoCGR9LT2o90iGeNxJ3HGi26gi+RRwf1DQoYq35vqYUlhA3Vfg/QIs/
	ywwQ2zc1gH6/O5INqiPaEJ+WJMt/jcSI59mNVIWcWi2v3aZnfK8LSGxsxP2h75S9RdQXafOrozj
	3VGwQVQgSjXJpqwIQ884WhUvZUDmaB13ZmiU6KZ2lLrYCaNRTK4wfrfhm1DGxzXgfy5kYJh/Ebu
	xR0TRTiqnhc3Ga95611Plr/TT79QDVL0CFgNtQ0appTATuoAvot1KEM73DC57NN8gZ2nTdSKJyM
	jNVQpF4tw/lLMacLgBSX+/VjYY
X-Received: by 2002:a05:6122:3a0c:b0:5bd:95ab:fcf7 with SMTP id 71dfb90a1353d-5be0fecac1cmr95833e0c.0.1783093367224;
        Fri, 03 Jul 2026 08:42:47 -0700 (PDT)
X-Received: by 2002:a05:6122:3a0c:b0:5bd:95ab:fcf7 with SMTP id 71dfb90a1353d-5be0fecac1cmr95816e0c.0.1783093366681;
        Fri, 03 Jul 2026 08:42:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb768sm565664e87.52.2026.07.03.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:42:45 -0700 (PDT)
Date: Fri, 3 Jul 2026 18:42:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD
 device type constants
Message-ID: <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1NSBTYWx0ZWRfX0IJ9ppF50DcQ
 2VjcRC6eOzoDCX25Er2sU+x5xRzyaL9mWf9glK1x4reAfulYRZ57QPEPspc8KV+IEChTmZZPX8q
 J6+imAlbpwuMFxU7HKMucAQKp90ZGjMUwcP+bY2eRFCol/KYWvzIoZLpMfuJBsA+d1eSFL86BrU
 g8DeO4VCgkoDixUPxssbvNF80bVDeU5KI/ejkOSxVqkEnUqzU2e7n/+DfwMFDF7rTmzzzr6adOY
 PvOxDLqVFvwatlIAu7R+sfcVNVQ7LnmFWctL/foRImhsP0Vhk7DUaxN4c4qa0B0abPi7RN8H9s6
 MoQIPWE3E3uLpOpT4bJeYHYNOU4Xy28/cu0/dHyBT1VJXVp+0m8CVOrhrMgZwpF9AXyhGfoBIYN
 XFZ52BI6RahSeFaTKu+ZqT4ZnHNr/4lubjVVVb7CRCumgpFY0qG/j2InM7upEsgyAMS+wrX0pqF
 Hc121bc2wbirfYq6fGw==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47d878 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0Hel9obb22bScKhzErkA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: N60hAtIDdJooQXqwDb7YIXJ7bfHuw0yn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1NSBTYWx0ZWRfX6RQ20QR5xuv5
 rPMq65ehK3crCSP8fqQZ1Pfj7cxVRAxpm4gdfjMbcU6PSYlBSjq5c2gQ8tD6j1sp0RSwslXpxKJ
 Whp+HIuQjlhb6EZnywDiNveRryV0Qbk=
X-Proofpoint-GUID: N60hAtIDdJooQXqwDb7YIXJ7bfHuw0yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030155

On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
> 
> 
> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
> > On 7/3/26 7:03 AM, Gaurav Kohli wrote:
> > > Add Device Tree binding constants for Qualcomm Thermal Mitigation
> > > Device (TMD) types used by remoteproc-backed thermal cooling devices.
> > > 
> > > Qualcomm remote processors expose thermal mitigation endpoints
> > > through QMI. These endpoints can be registered with the thermal
> > > framework via the `#cooling-cells` property on the remoteproc node.
> > > 
> > > The QMI TMD protocol identifies devices using string names (for example,
> > > "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
> > > `#cooling-cells = <3>` requires numeric device id in the form:
> > > 
> > >    <&phandle device_id min_state max_state>
> > > 
> > > Define common TMD device index constants shared across currently
> > > supported platforms. If a future target requires a different mapping,
> > > additional target-specific constants can be introduced while preserving
> > > existing DT ABI.
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > ---
> > >   MAINTAINERS                                 |  1 +
> > >   include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
> > >   2 files changed, 21 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 57656ec0e9d5..ffd85fd1dd80 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
> > >   F:	drivers/soc/qcom/
> > >   F:	drivers/watchdog/gunyah_wdt.c
> > >   F:	include/dt-bindings/arm/qcom,ids.h
> > > +F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
> > >   F:	include/dt-bindings/firmware/qcom,scm.h
> > >   F:	include/dt-bindings/soc/qcom*
> > >   F:	include/linux/firmware/qcom
> > > diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
> > > new file mode 100644
> > > index 000000000000..73efecef0f3c
> > > --- /dev/null
> > > +++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
> > > @@ -0,0 +1,20 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > > +/*
> > > + * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
> > > + *
> > > + * These indices are used in device tree cooling-maps to reference
> > > + * specific TMD devices provided by remote processors via QMI.
> > > + *
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > > + */
> > > +#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
> > > +#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
> > > +
> > > +/* CDSP thermal mitigation device id */
> > > +#define QCOM_CDSP_TMD_CDSP_SW	0
> > > +
> > > +/* Modem thermal mitigation device id */
> > > +#define QCOM_MODEM_TMD_PA	0
> > > +#define QCOM_MODEM_TMD_MODEM	1
> > 
> > What about the dozens other ones that Dmitry's laptop reports?Ri
> > 
> 
> Thanks for the review, Konrad.
> 
> We are only defining constants for the TMD devices that are actually used
> for thermal mitigation on the platforms supported by this series.

Why are you using only those TMD devices?

> More constants can be added as needed.

Kodiak is one of the supported platforms.

Running the same tool produces:

TMD service: instance=0x00 (modem) node=0 port=20
  29 mitigation device(s):
    [ 0] pa                       max_mitigation_level=3
    [ 1] pa_fr1                   max_mitigation_level=3
    [ 2] modem                    max_mitigation_level=3
    [ 3] cpuv_restriction_cold    max_mitigation_level=1
    [ 4] modem_current            max_mitigation_level=3
    [ 5] vbatt_low                max_mitigation_level=3
    [ 6] charge_state             max_mitigation_level=3
    [ 7] modem_skin               max_mitigation_level=3
    [ 8] modem_bw                 max_mitigation_level=5
    [ 9] mmw0                     max_mitigation_level=3
    [10] mmw1                     max_mitigation_level=3
    [11] mmw2                     max_mitigation_level=3
    [12] mmw3                     max_mitigation_level=3
    [13] mmw_skin0                max_mitigation_level=3
    [14] mmw_skin1                max_mitigation_level=3
    [15] mmw_skin2                max_mitigation_level=3
    [16] mmw_skin3                max_mitigation_level=3
    [17] mmw_skin0_dsc            max_mitigation_level=15
    [18] mmw_skin1_dsc            max_mitigation_level=15
    [19] mmw_skin2_dsc            max_mitigation_level=15
    [20] mmw_skin3_dsc            max_mitigation_level=15
    [21] wlan                     max_mitigation_level=4
    [22] wlan_bw                  max_mitigation_level=1
    [23] modem_skin_lte_dsc       max_mitigation_level=255
    [24] modem_skin_nr_dsc        max_mitigation_level=255
    [25] pa_dsc                   max_mitigation_level=255
    [26] pa_fr1_dsc               max_mitigation_level=255
    [27] modem_bw_backoff         max_mitigation_level=255
    [28] cpr_cold                 max_mitigation_level=3

TMD service: instance=0x01 (adsp) node=5 port=8
  1 mitigation device(s):
    [ 0] cpuv_restriction_cold    max_mitigation_level=1

TMD service: instance=0x43 (cdsp) node=10 port=9
  3 mitigation device(s):
    [ 0] cpuv_restriction_cold    max_mitigation_level=1
    [ 1] cdsp_hw                  max_mitigation_level=1
    [ 2] cdsp_sw                  max_mitigation_level=7


> 
> > https://lore.kernel.org/linux-arm-msm/4gs664zboaqgpok33x7bgorfmhh3f2fahjkt4jjl6fbzpwixnm@hxzz2xeogd4k/
> > 
> > Konrad
> 

-- 
With best wishes
Dmitry
