Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB4492507
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711114; cv=none; b=Is+Kv1HmNsv/usZnQrZzjkDrLTOkCJ63HidvnTXayTG/eVPsqx+ZTdt58HkIfIWXAusDwCR1+ybLiaty9Iw59gkrg6Wnuj7ZC9wuweDi8ewhOE3wCBXbZQLz7vNKQUNVcNNmN8Hz6HEOmmbt9hEgyP/eJOLJSL9H1llDdQTvpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711114; c=relaxed/simple;
	bh=baQJb7Ar7ZmU1hhzXFo7f1CrbqEmCoDf6IMkGA3MRCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlSvubTj8YXeO9FO+9lTbiIKXYmuk4Rj26cN6yChRYHF3USro1Ybq4Ojb3tXxzg3MUCawnDKIZdcSi6Y1mDVC6rwYwdWDShlkSy0Vfh+XSRpvyLxbMdZLtI5fP+EDYZE0jHoTWhhEdF766vkEnwT2+S3ZbyRwAydh8r2o6zBz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lb+Y2MtE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C67qv04s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lb+Y2MtE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C67qv04s"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xMkH015319
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ye0pmBSQNQpD1Ixqlj4iy6xz
	BJOLNvLjVgnEcTk9udc=; b=Lb+Y2MtEJL6mOdAV5TsbUJUb129e0wN+miUU7+Jx
	FKNDJWSplwfsPeWSA75BTsexEAgrOjgg8YE2bYUvzSLlzXEUNJVCXwUydVdYS893
	bOdOWNDMD24CoHqRbkKyJEpijqOu4bn7zvMBMriMWizf/yS6JtJy4YcagRetnnK1
	gknUkbWROgC4UKkN0FHfoH55XHKq7TXfJNJhzW639SSxUN44c2xVgDSvcEDLXlDB
	hCs2m+PgRXrJJWWXe+ORcJfN8vHz/dpE2IHrec4BVz/eTrs4SYxmJFR5yXpAhA/y
	BQNfKX8Zd9oVPNXcY8UD0aKKtfcdblHCz2wjkpuoVOdsiw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e36wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:05:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so3380325a12.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784711106; x=1785315906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ye0pmBSQNQpD1Ixqlj4iy6xzBJOLNvLjVgnEcTk9udc=;
        b=C67qv04swalWK/ATSzuejVNLhHuW2WKxREPzMq5yRKkNS0itGeX+JI3D8guJzERkDD
         nejvczhS13j8VFo13+67PabzTGy3axFt2rdFR7iUlh3jXOVwI0Ewx86Kmv2ywPni4HkY
         HwvF88Ul1l2issuFIO0U4d3I9SbYebqzY1O2RQbU0wwZiVkad7PqI0qpQcx7ELqLE5tW
         wB0A5psEsRaz882Xwjd2zGW16eLN1o0dQRZF0wEtAALOcVXSHFqXIcU/WRGg6wU+remL
         HmsHxSj0txSMaDw7NiviHNndv4VC/2CCceG12B3qXyJ/kyRrF0SXE3bs5ba7qElz49f9
         gSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711106; x=1785315906;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ye0pmBSQNQpD1Ixqlj4iy6xzBJOLNvLjVgnEcTk9udc=;
        b=LLLnsrJ5sXOWfjK7MFyQcFhnZv5gKM7JUhghO1oQmENWNnTVbd8h8hMveL0q8tqgYu
         pKAKh9vvkmgjLYBjzQoldWCav9iaFLcU1ycLBy9o8foXkqyhsS3shpAoPRf3bvC2JjC2
         Yn6jC6WL7Kg/kfntwDiJizLVCiVN/ZymYkYH/J6iHK0KPNR8BVhxd/fjpciRndY6D8IX
         GAJ6Xyhix3/j/7TKk7KPyJ2+vjr4TLGIyv1sonfGkdZTxEnaMkSECqbpQ4paIBaaPqOi
         mTLGaVFULFYfmypBB2uqD0hASmlPzUpOIFdJf3zNoCz9OweKEYvCm/hSSxnXIwdg8wSL
         LjDw==
X-Forwarded-Encrypted: i=1; AHgh+RoQh6XCtydo1JB4+PoxW1JbRrbtIEteLeMJfhnqWRHIsqakDX24V4b5O4JUkPxlEEhshZB1sc2Atw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dFuhMz4NljvZ/PTZ0hYwlA+qQ3ZwA8PjVAc0nM06/GgP8zTk
	8OX1f7W5Q0QK2/81jxYrIoDBTOMaLVC4w+GT8NG7uzjNoqe0YinUI3gRGeuLTZhQ+Ad2nnq6ot6
	EmF7tuGb1SbQtWO8wnslApR/mpngjTZFuMwX/0/S3RpbCxRzqZzM3n67nCfsDSQ==
X-Gm-Gg: AR+sD11ddfgJc67lOF2YzW6VicqLfkr5ZkXcRvntlUVNm/Ow6RqNKCisR400WLCtkYn
	rHRhqcNrJ8Nvz5q+Fg/rlcwyQVqt+OtWtYwnRLYdP7L1yftaE8DtSigXQE2lJFk2gelj9+KsZFo
	98fwUzt0eRM2TTvvIqSmXLGiP2DY2foJ90IEwmUaqH3MMkSzofJr/R2Y+/Qd7bG4t2pve6dnsIK
	ToVap+aL3RKdoKeambmWkQ/5r90GPENV5B+tMbBfbF6yWWeUPoj0b1cbrYl+oex3y4Yvbyaf/hi
	Qe6SpF0uOkJuBjYeTiM5atl0rdmzGXpGIW4uQWLDXxiJgMvVBxaPL2/28v9rmywLKKVXPOJclmm
	jzTsDfGdfTHo6RCgqLcHG6nEtTVIs1d0C9g==
X-Received: by 2002:a05:6a21:1506:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3c3ad665a9fmr23634860637.16.1784711106471;
        Wed, 22 Jul 2026 02:05:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:1506:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3c3ad665a9fmr23634822637.16.1784711105994;
        Wed, 22 Jul 2026 02:05:05 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm6811568eec.26.2026.07.22.02.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:05:05 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:34:54 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v23 03/13] power: reset: reboot-mode: Add support for
 predefined reboot modes
Message-ID: <9367ec1e-d01c-489d-aa3a-fb361538331d@quicinc.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-3-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-3-e7453c548c21@oss.qualcomm.com>
X-Proofpoint-GUID: a13PWVwqc2g8qlRrqfGWqSG3zXhNbTEl
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a6087c3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=2P-C3DqZnQur8SwEehsA:9 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: a13PWVwqc2g8qlRrqfGWqSG3zXhNbTEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4NCBTYWx0ZWRfX4MmVmSiAsv+5
 gCg6liC5xiRY+pR9kxyo0rdbHBgzkhxjTlhFDLqtINJDhAbyi6E6VaFlUOeuNN6bSc+LzGnHuiH
 IXvCea/HBccymWBu21c3SDNh6x0/TQftxerfilN4nNNl1/7R44RF5QR5y0r/pZIZj/auVdCgaLD
 W8l1C0oDgqj8BFbtE5e2AL94XZNyEhrEiz+8zjXNUMAF10p2NkyzjgVjXNHGpjAQwAZPCX+6jKx
 G6nm8GxzJ1pl8tsmnqcaRfzfB6hQJo6/bGH6gDzu5QZgUVLR9CNgVMbw0ZuT0uUw1OM9pSgnPjs
 XJ6cnot7o2X8kMOlRGT5rC9iuUks+63qOIULrEPe4haKzpbuaY+ZATl8vk4O7plowknJz8hA4n3
 N1waQoVn9QarNFbE6tYC2299GJ0o2UHFmzY+JM2B+CI7bz1KSaQbyKvllmVCLlGa4rd35H0xJWe
 0BnGBnWW3lRtulcsfAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4NCBTYWx0ZWRfXzs5fcvzeHWrW
 xxSdUn/MZH9JvFbzBFAC1tHI0gt2B/8w3cqH8/MBcy97NDBEnCk0T9pCHG/C6c0LXpyghiW3ooT
 q/Mvp22e8oYMG/8G9/NrhYTcw0CrwSs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220084

On Tue, Jul 14, 2026 at 10:46:31PM +0530, Shivendra Pratap wrote:
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 34a81e4b4f95..b216c7595f7e 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -4,18 +4,34 @@
>  
>  #include <linux/types.h>
>  
> +struct reboot_mode_entry {
> +	const char *name;
> +	u32 magic[3];
> +	int count;
> +};
> +

I see some where `count < 0` check, should not this be size_t or u32?

Thanks,
Pavan
