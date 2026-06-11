Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880F4D90BC
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218239; cv=none; b=uaJPTFibW24NEVW/TpaUpYppJuPtruKJblOnY61C8DG0X2VPx9mZKOCC2Oco0ut/Eh2K0s4C/g2f+N0gWub9B6qBQvVvLk07UovisghphS441Bxmgq1RCtNzvS58MgcsDaKpiDgNx3TEklRZyHqlEGJ8vibt+Ybho5XHb9++DZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218239; c=relaxed/simple;
	bh=s0FsxZ8z5GOCbcGydgexdsiQkwaKpNaoKSvHRYjctOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuJ/hsBXXmVkH4G/HnxZctt1qN9QV+Cd1rw7vB6KCC+C7BgYWifEDlPd+43T64hPdvZV11uJULPpwYmr/DnKnhrXL+YpgszYPB1okMc9coyaugPCftY9i6cFz3F+Ed+ePKjMsRLbnXn4x3cult7KT6q+MjcTK9s54uTKle8tygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BdYEYy+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MFFAHAjX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BdYEYy+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFFAHAjX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMV3Ym1950474
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 22:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mVojuXfDpKf29IEBlpCKnH5S
	CMLDZ9dYiwNIOQ7FYs4=; b=BdYEYy+AJ+/FZImkM0YDehyqVgsMSXFIg2Y5Isy+
	FVhR2Hx5hN95Q6CIJtQdKdMVHog0vWyPoMC3rdNizn+1dlI5wPuCtdyTl+WXK2dg
	ek6kUTHeL7JisGrdckG+S4ktfGJrkc2hyToTITB359sd4Irk2GC+GD1CMsV8LZFW
	u9JTxroA8xiO4XZWkLET4wlgRNkoH6VrwsCtYqVgbehcVUBkLKS1Q+ETeKvRQNxC
	XdDENj/Izj807AUPLH/aewkReNKuGYl2b/ecG52aP6/Mc5tevothfcuReb9e1Dhk
	8DGVdYNB40+6kDUJ0NcRUfmbJQPpn3gEX0fVAivpCtiKrg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5k8xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 22:50:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51768072950so3865791cf.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781218235; x=1781823035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVojuXfDpKf29IEBlpCKnH5SCMLDZ9dYiwNIOQ7FYs4=;
        b=MFFAHAjX6W+Ck4ExOOZOOVpsBH2zddxd3PFZfN+1W4zO9m3sw1RItG9GZ1DGaTuMa2
         r+5+weiHllDY3W6UFsUmww0Iwp1ZeuI2wI3ipR8hVLr2KzXpthDrdFsGCbsZ3JLM572c
         rgsJZUCltCnf9qmSxNLA+hKDl5VO/EUo+sYSseC2gXgv1XXoSgwkSmNx138TQGhEVM8o
         4q1QCMqnRqzzRwmJIx9uwy5FxUnE1i2tkRzFrMi8hdPG0Vry+6KcozVWF4ahBHmIOmmD
         QZVkwUhB+rkjhRhuDt7NvCesQyQjIxlksP7BhC9CqdBKo+yI4IXSnpG6BUTViaEYuK4f
         LTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218235; x=1781823035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVojuXfDpKf29IEBlpCKnH5SCMLDZ9dYiwNIOQ7FYs4=;
        b=ffeqwiIbvWhyrOih+iNJ5bIBAgSQBE9YOP00RICDhHgBmago82pzo+JOsweshQWofM
         JAAK1d3qa9dMh8eHm2F9DKWr6AY4Ep7skhSFWz1DH3x4ffljRFGRpGl7bvxXJHh0cE5N
         JvJmHL9pDN3rNOrrNsPD0TbXFQJIz/iesji//gGMbkpO/wdrl51xuA2q5eRC+HA8N8Kt
         DBNfZZi0JuX1nzBAD1NXDDOLdeqaTK0pbVomfuxA9E2gCkkPW2bFbk4TeaSZIdxVnRQZ
         aYnNFUZAk1EsGHqRfRnPwxSXGukA2M8zg5eWK1Czadu4n/Qow0UbZALFyfKhUZpqo1BI
         Ucdg==
X-Forwarded-Encrypted: i=1; AFNElJ9TAXWFHoOD3NjWQxg2Z5DxaPW1ZqIyf1UWakzkMXjgrfvibagUi2MdKQrrcw0Tl5UklW/GTWbI6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBeZuE+70iB4kkEay1GDOp8KuD/1hs7QHU4lc5cqOlbkR/xOA
	WSjSozEHVt40laS/0GCGA9uaYfg/I1zmT5D1EJOXSRU/e2M0NOUQBqBJe1eYJuhAYpXuyGxncHL
	yQW6SoPRWzssKWZLjNGmTv3DMq6wgiyF9RdA31hxLR9vsVUyMUJQGVevNkKzmlw==
X-Gm-Gg: Acq92OGiFMoaIyI93yvhLwcxFbfm11YPp1qYSyxbMwYrpU4ZdjlmZktdiNJGWIDgTNW
	3XeC4vX1KZ0YzdErbxu6CdHfG1M5k6XoMEeX1h4Vrq9q1NUS2aXxlJ221SfnDYDwmx2MVtPir+S
	+uS0XIFcijgDMv1oPyB9dBExwhRR1WnOFa0ofDn6iACwnczMJs/sRg21ImXE/gwVKKg56j6gkHw
	jWutJFUdqwoHy4uKNQgcQk9WNREPu9hYZO2OBfhG67VIVu37FJ1DS/yC6E9aldapGQQBh/ef/io
	63v1ncLZGZTtjTOxVmF/U/AzDhMi0DYdevTuCD2bI3ETahSoIuXegzo54g6OrFkHzzgQzL7tpkC
	Msyev6Hgfx0uwWpAcIIs/DtH/tnAa97C6fDBGGEuCF+KmA1C3UTLd/aeR7UmwmaeJbhvKmN4iBp
	lmaKDqDm02cifiMVQRImn7UMGQAr1mhoruiAk=
X-Received: by 2002:a05:622a:114f:b0:517:146d:2db5 with SMTP id d75a77b69052e-517fe4cd259mr2851311cf.2.1781218235439;
        Thu, 11 Jun 2026 15:50:35 -0700 (PDT)
X-Received: by 2002:a05:622a:114f:b0:517:146d:2db5 with SMTP id d75a77b69052e-517fe4cd259mr2850721cf.2.1781218234881;
        Thu, 11 Jun 2026 15:50:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cd82c78sm202290e87.54.2026.06.11.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 15:50:32 -0700 (PDT)
Date: Fri, 12 Jun 2026 01:50:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v3 2/8] soc: qcom: Add support for QMI TMD cooling devices
Message-ID: <6nhhld2c24lbpxrylbzo4qgjqyhxu4pbcwoykwyps3lu4s2dh5@b6cwsomt4jvq>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-2-291a2ff4c634@oss.qualcomm.com>
 <pyt62qpa75nzdatp5xl7vcqrdzmrzsf5ethw6wq62bzg6b7qtv@ts2v53im4bos>
 <c5d085d6-822f-46e3-81f4-ef794b8040bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d085d6-822f-46e3-81f4-ef794b8040bd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX2dbKvbLQ+bB/
 4wiSkj8cvzar2zDCpll9xeHLI1lQ3GcPUhx7utHVKVST1TcRjcxoOMUtZ+AopbVR6jQIasMOIvh
 +/82w3SWHfI0isXVdaXBG2ZkNwXNScTURiWNnYL4wrWfTTb3iZfHH9RvpMKipC+cPfHMt9JDaCY
 9sfCnBQyS1dVILQdWgDgDJzrmazhQISpAfQbRyOmjCsxs9OcbtzUoevnwDwMQjP0KJKhgfb1pxm
 7IEkXo2CMefj4kUzuKNI/ybyfaKV3a4WHwMs2NxMqzawrjBLZavYk1uZGGqkCT94ijys/g39Zlr
 W2YVm/OgG9gXhuMnBa05XKhp2j0x38scsH8Z+R3qt/3j8nWQ4lN499tooY3mV+ETy6+Y54sebvb
 cHlcEodRb516/fXaYMZTar69aIvt3abB1O+f31q+/SKHOvoDlYZ3vc4+UsPfbTIJIPS1Tyhs+gt
 EEGdmvaFCTIo/jZf+/Q==
X-Proofpoint-ORIG-GUID: fanav79IdU3nngy2c82rdL0i2VM-EzUx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX1boA86rvp25m
 Jdhqxfol9Q+Os3ZAPsfYlTK6vfcVp8GW+40QzCHkwg5gtTMMF+01KMGT+/vGUDNKGcW0/R6NaDQ
 cCVjXMHGLJgNSq2PeWFcOcdDP7oCM50=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2b3bbc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=84pVzkcfbc7hDzDTJfQA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fanav79IdU3nngy2c82rdL0i2VM-EzUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110229

On Thu, Jun 11, 2026 at 04:23:40PM +0530, Gaurav Kohli wrote:
> 
> 
> On 6/9/2026 5:00 PM, Dmitry Baryshkov wrote:
> > On Tue, Jun 09, 2026 at 03:52:57PM +0530, Gaurav Kohli wrote:
> > > From: Casey Connolly <casey.connolly@linaro.org>
> > > 
> > > Add a Qualcomm QMI Thermal Mitigation Device (TMD) to support thermal
> > > cooling devices backed by remote subsystems.
> > > 
> > > On several Qualcomm platforms, remote processors (for example modem and
> > > CDSP) expose thermal mitigation controls through the TMD QMI service.
> > > Client drivers need a way to discover that service, map DT thermal
> > > mitigation endpoints to cooling devices, and forward cooling state
> > > updates to the remote subsystem.
> > > 
> > > Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > 
> > Wrong SoB chain.
> > 
> 
> Thanks for review, Ack.
> 
> > > ---
> > >   MAINTAINERS                      |   6 +
> > >   drivers/soc/qcom/Kconfig         |  10 +
> > >   drivers/soc/qcom/Makefile        |   1 +
> > >   drivers/soc/qcom/qmi_tmd.c       | 604 +++++++++++++++++++++++++++++++++++++++
> > >   include/linux/soc/qcom/qmi.h     |   1 +
> > >   include/linux/soc/qcom/qmi_tmd.h |  23 ++
> > >   6 files changed, 645 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 57656ec0e9d5..3d60702a655a 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -22286,6 +22286,12 @@ F:	Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> > >   F:	Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
> > >   F:	drivers/net/ethernet/qualcomm/ppe/
> > > +QUALCOMM QMI (REMOTEPROC THERMAL MITIGATION) TMD
> > > +M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > +L:	linux-arm-msm@vger.kernel.org
> > > +L:	linux-pm@vger.kernel.org
> > > +F:	drivers/soc/qcom/qmi_tmd.c
> > > +
> > >   QUALCOMM QSEECOM DRIVER
> > >   M:	Maximilian Luz <luzmaximilian@gmail.com>
> > >   L:	linux-arm-msm@vger.kernel.org
> > > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > > index 2caadbbcf830..a292ce57fd4a 100644
> > > --- a/drivers/soc/qcom/Kconfig
> > > +++ b/drivers/soc/qcom/Kconfig
> > > @@ -128,6 +128,16 @@ config QCOM_QMI_HELPERS
> > >   	tristate
> > >   	depends on NET
> > > +config QCOM_QMI_TMD
> > > +	bool "Qualcomm QMI TMD library" if COMPILE_TEST
> > > +	depends on ARCH_QCOM
> > > +	select QCOM_QMI_HELPERS
> > > +	help
> > > +	  This enables the QMI-based Thermal Mitigation Device (TMD) library
> > > +	  for Qualcomm remote subsystems. The library manages TMD messaging and
> > > +	  handles QMI communication with remote processors (modem, CDSP) to
> > > +	  exchange mitigation state and apply thermal mitigation requests.
> > > +
> > >   config QCOM_RAMP_CTRL
> > >   	tristate "Qualcomm Ramp Controller driver"
> > >   	depends on ARCH_QCOM || COMPILE_TEST
> > > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > > index b7f1d2a57367..4544e61c74e7 100644
> > > --- a/drivers/soc/qcom/Makefile
> > > +++ b/drivers/soc/qcom/Makefile
> > > @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
> > >   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
> > >   obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
> > >   CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
> > > +obj-$(CONFIG_QCOM_QMI_TMD) += qmi_tmd.o
> > >   obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
> > >   qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
> > >   obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
> > > diff --git a/drivers/soc/qcom/qmi_tmd.c b/drivers/soc/qcom/qmi_tmd.c
> > > new file mode 100644
> > > index 000000000000..9d88ae48c864
> > > --- /dev/null
> > > +++ b/drivers/soc/qcom/qmi_tmd.c
> > > @@ -0,0 +1,604 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2025, Linaro Limited
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > > + *
> > > + * QMI Thermal Mitigation Device (TMD) library.
> > > + * This library provides cooling device support for remote subsystems
> > > + * (modem and CDSP) running the TMD service via QMI.
> > 
> > Why are you limiting it to these DSPs only? I quickly checked, my X13s
> > (sc8280xp) also has one on the ADSP.
> > 
> 
> Adsp is low power dsp, not prone to thermal issues and no TMD service is up
> and running. So we are defining for Cdsp and Modem only.

Again, if there is no TMD service, what do I observe on my laptop? Or
what do I see on other devices (checked on SM8350, which I had at hand)?

# qrtr-lookup  |grep Thermal.mitigation
       24       1        0    0    22 Thermal mitigation device service
       24       1        1    5     9 Thermal mitigation device service
       24       1       67   10     9 Thermal mitigation device service
# echo stop > /sys/class/remoteproc/
# cat /sys/class/remoteproc/remoteproc*/name
adsp
modem
slpi
cdsp
# echo stop > /sys/class/remoteproc/remoteproc0/state
[   68.353571] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5
[   68.354150] qcom_q6v5_pas 3000000.remoteproc: Handover signaled, but it already happened
[   68.503057] remoteproc remoteproc0: stopped remote processor adsp
# qrtr-lookup | grep Thermal.mitigation
       24       1        0    0    22 Thermal mitigation device service
       24       1       67   10     9 Thermal mitigation device service

So, obviously, there is a TMD service running on the ADSP.

> > > +
> > > +static int qmi_tmd_get_cur_state(struct thermal_cooling_device *cdev,
> > > +				 unsigned long *state)
> > > +{
> > > +	struct qmi_tmd *tmd = cdev->devdata;
> > > +
> > > +	*state = tmd->cur_state;
> > 
> > Mutex protection?
> > 
> 
> This callback only reads the cached local state and does not perform any QMI
> transaction, that's why not using lock here.

And what is protecting the cached state from the concurrent
modification, ending up with the read of incorrect value?

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int qmi_tmd_set_cur_state(struct thermal_cooling_device *cdev,
> > > +				 unsigned long state)
> > > +{
> > > +	struct qmi_tmd *tmd = cdev->devdata;
> > > +	int ret;
> > > +
> > > +	if (state > tmd->max_state)
> > > +		return -EINVAL;
> > > +
> > > +	if (tmd->cur_state == state)
> > > +		return 0;
> > 
> > Hmm, again, mutex protection for the cur_state? Or is it provided by the
> > thermal core?
> > 
> 
> Yes, it is already protected by cdev->lock.

Comment.

> 
> > > +
> > > +	ret = qmi_tmd_send_state_request(tmd, state);
> > > +	if (!ret)
> > > +		tmd->cur_state = state;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct thermal_cooling_device_ops qmi_tmd_cooling_ops = {
> > > +	.get_max_state = qmi_tmd_get_max_state,
> > > +	.get_cur_state = qmi_tmd_get_cur_state,
> > > +	.set_cur_state = qmi_tmd_set_cur_state,
> > > +};
> > > +
> > > +static int qmi_tmd_register(struct qmi_tmd_client *qmi_tmd_cli,
> > > +			    const char *label, u8 max_state)
> > > +{
> > > +	struct device *dev = qmi_tmd_cli->dev;
> > > +	struct qmi_tmd *tmd;
> > > +	int index;
> > > +
> > > +	for (index = 0; index < qmi_tmd_cli->num_tmds; index++) {
> > > +		tmd = &qmi_tmd_cli->tmds[index];
> > > +
> > > +		if (!strncasecmp(tmd->name, label,
> > > +				 QMI_TMD_DEV_ID_LEN_MAX + 1))
> > > +			goto found;
> > > +	}
> > > +
> > > +	dev_dbg(qmi_tmd_cli->dev,
> > > +		"TMD '%s' available in firmware but not specified in DT\n",
> > > +		label);
> > 
> > If we can read them from the firmware, why do you need to specify them
> > in DT?
> > 
> 
> We need DT, because cooling-device binding is index-based as per new thermal
> framework changes:
> https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/
> 
> And also the firmware list is name-based and ordering is not consistent
> across platforms/firmware. DT provides the explicit set and order of TMDs
> that thermal framework should bind. Firmware may also expose
> additional/virtual TMD's that are not used for binding with thermal zone.

I've asked this elsewhere. It's not clear how different TMDs are used.
There are comments by other reviewers regarding the tmd-names property.


-- 
With best wishes
Dmitry
