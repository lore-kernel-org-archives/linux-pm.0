Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD630DD2F
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410069; cv=none; b=Nm/5TuJvQip1Sg2qUCl0rhcIeuwHKmsaeAGKh1qHrxly9s8yQNBMV9Ic+VHUU7NjzbO83Zx3uWuqWdgtn2qdM/q/2EKwAXzJr4yQjWNqEDtfV/Ki2HaExBOBUwsxAfKFjE6zpU2h2BZidM7J3vTdu9GnQPQ4WrRKW25lgtatlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410069; c=relaxed/simple;
	bh=etcNXBBDDQzHCuhn9WyhQRQcwV0yDZKYkLQCSlrBMdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usc79hVL6fD0Y8OBSpTEMNyV/tw9XXmm8N3PbTK/TAjkSaPbKiqpIj6uHVfXkpuHF6VYAaed41I/P0+rhWC+jd+xVnWFhP+B1ufcN2kSeM1h23U3XWBwmavvYvvExvOkUAqqriqiS0AdpK3RoYFK6Xm8zhz4XfBomg2cVbXGVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FUJDVLMn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UEpF6Lud; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUJDVLMn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UEpF6Lud"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMpsLF3008669
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7AgUwPpZ6ylBFvFSPApEkM29
	i+AJLtwNGpDaxug4H9g=; b=FUJDVLMniirLor7pOsg86uadALTgQdrNocSWwq3F
	IsFkmukO0qWWrhSFxupaMigQcW7hXYokQxIGVROxMWAIrhOBzCNylgEcdI3JboL3
	qVX64Zn4unEqcYMi9qTnPKhxFlcNO59MTWNeYYkbO9qDyrYjjrhId4kf/9Ap34m1
	xkodpOo1nLbRiQwznfnb/CjXa4k6d7lgS5nU/NCsXTM4f8SneiQxwUBXp2iz0bZX
	OJYHb/7Qml+uH8dbVtXQr2F405c7YDE34BmuBcC8VWmkAamXqOyWvD+Z107XnpCH
	DItbWwvt+u8ozZ01lGJdyXHV+2NzPjkd75wqRUum3ZXlsA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjthq5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:01:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936708f129aso18247785a.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786410063; x=1787014863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7AgUwPpZ6ylBFvFSPApEkM29i+AJLtwNGpDaxug4H9g=;
        b=UEpF6LudAC4r9DjxgRwZ1ZTLVM/2BPavQ4H0qh+hTti59JSfU8q3N5wuuEYyQjqF8a
         LRlVLjTON/qUNL97x0l5PAM416F8kAPLzMyChTiSNltFFoKdJUqQX3SWHvJ4mc9zDBs1
         wme+llUrWCVcyLiUcsya5G+PI/DJA1jLu28ZMZ95DdrLyOwqkEk5+UL2YCN1/jjxkDzk
         q+FrHeIH9GHGwSg2AKDwM+22ndrjqCRdChwkyC9SHK7NhHHV5GGMxB1BHOQiBTcVZxjv
         BZlyJAi9XeXy5JXkB4pXn0LnRHLiKB+yRd2ju5hsRHyuFcAw9Uh6kGPCm69uJ7ekdS7Q
         xUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786410063; x=1787014863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7AgUwPpZ6ylBFvFSPApEkM29i+AJLtwNGpDaxug4H9g=;
        b=j/4aKiILKyYed8dX/vLtwH4SmxwfxBiH25nkitZoUhklxOiKAi/9uPPl7qfHupIB86
         tb7rvwT0j6sNLZBZ8sTnJ8EM/ob7rsxnQlWKHNNOdH+ZRRX9r5Uk/XZKZjUUurNHNqUw
         bjMTlqlwvbrQJ9tvuej27Gzeok6MCIEOvdm2CwlV4D13RtpzgsknUCFnMA5UevEY1xB3
         UXwb5EQovHkSsv0mb6WeootQtWtZ1kIulnRmCrwX4ZvuySH/mdLVHAZjIWkgB9XZ7q8i
         A8YsU566QJlC+FR/QScn7uRu4dDW6wAldptp26eh3Ip28hSdZMOQG7FAL9jMtUXQ45pm
         dPZQ==
X-Forwarded-Encrypted: i=1; AHgh+RomuGHkRpNft9BG/8pxIXT6wS5kLL8uKgWKXetFitrDKhquev4lTt+wUXwkjdKtCb2b4SUfbqlKrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tC+kdWm2d+aTr485dtDoIP5LK5TcKU7HKtGI78einxYEmLui
	vdgnaECcq4cDbDlr9a8fCByi0etYpx6iiPwlpFFiEU4bb6P7PyOlNdUrLDmVDPZfkChWpG2VlXQ
	Q5ZWc7lM17o5N09SDCVgBDu3jvWBCJHgiXddZe2ofNYAjK+JWHhEOSMZBvJa+Fw==
X-Gm-Gg: AR+sD11lGRGOSKiVURk9IKjZ6HE91D2iRNOCkTABpZOJHa4NBOElekReFvw4k5HoOBG
	LOiWwJ/a6Pb/7Z4ZYpt6ev005rdIVtpQjN1r/hjWYMvDUqB8aD3+kiwlvtKs8sEbONrwcntd4uE
	onRBVznAm2HPAhHW467MttxbgkbK10S3/Tk/XNyKP0wlz1GZgnXkaynFAaCDC5A50CxHUOm0V3j
	O9B5B1x7Jop3C8A9vsAM2zeib9XUiX5MOae7a4PtrcedbBV+gb6OD1AAmR5NrRp8PA35LR5R0d0
	Amva9jN0zJyGcc79v5ow/HjjHVmEgi8n7MymhC8/kIQJc0taPIz8pqzxQinzQf4ZCqce1hQjG35
	DOFC2gBsRXHPAvxrwfd4FKueMdo9g64uRTPNTTo8tx4XB3o07zDT6X1C6wlvNfiwI/1XXk7HSFn
	i/hswLB2uNjLAr/w==
X-Received: by 2002:a05:622a:593:b0:51c:21d1:3852 with SMTP id d75a77b69052e-52ce5f63740mr489635591cf.5.1786410063047;
        Mon, 10 Aug 2026 18:01:03 -0700 (PDT)
X-Received: by 2002:a05:622a:593:b0:51c:21d1:3852 with SMTP id d75a77b69052e-52ce5f63740mr489634881cf.5.1786410062529;
        Mon, 10 Aug 2026 18:01:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fddd6a796sm24711921fa.36.2026.08.10.18.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 18:01:00 -0700 (PDT)
Date: Tue, 11 Aug 2026 04:00:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 07/15] interconnect: qcom: Add Kuno interconnect provider
 driver
Message-ID: <xmj3xhnvdixooy3l6wro5f7eeehlrlrq44y2mwojzzeb3yjdjf@e3eo2772qctz>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-7-5e0ede4a0c72@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwNSBTYWx0ZWRfXyVhb2DgNn3gR
 5YDifO8FsVP5unjxUkzIFnfxEH58M/hnCBt/Y5f2ApDx/ZjdnTUgLJfb8NsOqnukCDtgCkij+cD
 Pwzj4+l5XKq0noe4IC7H5trv/rn0u+tmg+aky3tSgkwmZllN6md3sQMfqbcmhs6JwAu6a1wOJwS
 oCYMkPuA0ywalFapHcCyjS4QVDof57t/Rev5wZTNzma3dsiPG04XrbBq3HgPhNFy7bpW6Lswz7m
 oxNXLlWbBSloGtJnhFrs3i57fq2vYVvsLCMP8YY/7GP9qgGRHM2ZBHjGsqd27x8f8V8zUV7m6LM
 3m0oImIbuu5O9o3GeAn2ukFyC3HUpcRRLVD/OnkT8o4tTuNpCXUYITfk2MYHUTG0NS5V+/OmYdH
 /3rGoiyFix0Kx4g2RBClvXnm0CqDsFXm2NQuEukBlYNoxXvKE9GMW/pSIEeM059C4kosSrCUQb7
 Hg19x0uUnXHgun+uoHg==
X-Proofpoint-ORIG-GUID: mRCQDQOiPCpJ68TO8cgvXemnI_waMACR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwNSBTYWx0ZWRfX+NlIZXR7Yhuv
 HGnM1jM4TEmzr91WATZaaDELUC/fzFg5XHqAPIfPrZh182U0v3UaHi9s31gsITVlDdGvexGGWgE
 9Q5fCf++Qy/7zmt5DD0TtvveM0FDYGE=
X-Proofpoint-GUID: mRCQDQOiPCpJ68TO8cgvXemnI_waMACR
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7a744f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=pe0felBmJweB1gBNqhwA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110005

On Sun, Aug 09, 2026 at 12:57:06PM +0530, Hardeep Sharma wrote:
> Add the interconnect provider driver for the Qualcomm Kuno SoC to
> enable bus bandwidth voting on the platform. This includes the
> aggre-noc and cnoc-main NoC instances with their associated BCM
> nodes.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |  13 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/kuno.c   | 978 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 993 insertions(+)

Please add QoS settings.


-- 
With best wishes
Dmitry
