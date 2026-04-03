Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E41E2858
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218870; cv=none; b=BBL/i2Kgm3R6nNXVsBr0PCX2VX62mzFCJvoWMGP1ZPxjX/Bx6+KHnatqNK/mmjOWNdeGoiUYb49VvB6pRsq1oct+ixIi0ajeRe/7dOuZL5lhbeqSd656N0z7JkfjhRDmB7HzS+Ye7T7eJ4+u7T5b/JBwlf5JSADFWmHPGUMBLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218870; c=relaxed/simple;
	bh=6uo2pYCFlf4VXCUefzZD9L8pGKoHNwRuuVxXUkS8R3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT/Y9wQcomgaZLUyuUwtYRuHUAHTduvW1al/kWi512uR/ODA4wY/Q0mnnM5orVugKyh37MEYFSg7nlXCeRFUclRcOHLdQav+RgM28U7RdgWantM7zfOhAUTLKDUxoMaAAKwB4Oz3XAznRopgD+GloxhNqpfwuZNEONy63roNlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YktWhMKs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VH1GogAh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YktWhMKs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VH1GogAh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63373sHh3449905
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 12:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lR8swu8tzq+dxl4Pi5r9ST0PRzndcB8lRZhy3FhYfxo=; b=YktWhMKsqPhDkxA5
	R1DrNP7TxXo4YYS8qoZ41ilTv7G0qWbk+GIlgSlT6r79IYHDOAcsYd83IIhguE+n
	eEp0QHVIXnkgZL16GrAoW/BWS34fmOuvNGMuzk2VVIH8clHI/9PmfnI64n9VlREx
	7HKgbC8Sz4hAVuM6u4l+aKfL7/+AkgJB8R8RDopymsBZe/5xJI4l5szixjyrQvtL
	HtpiF6ju7LzAjTU1YbPSo0vjA1TB3u4tRmwrAe4g9Lmn1ytNqSiSKFNXQNlb/276
	bmYH/YD8ezoiS323vOWBR055Ot/yepCizHmLn3vm9OSXKoPijQT96qVt2MduVVqM
	M0z9Wg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da8u58v9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 12:21:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so43209441cf.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775218868; x=1775823668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR8swu8tzq+dxl4Pi5r9ST0PRzndcB8lRZhy3FhYfxo=;
        b=VH1GogAhP/udjmet9EbLPXSwm9xk8kCTxRD+Lvcu0vNbYABIRRDohKoIrSdA4VIpAN
         1HCSzAKikqIfwnkzKPm81hXEATcAmHdrDMgzknEL8N/wKtbXLN5mcTqy396Pd1Yt2YpL
         OUUoT/cl9mrCK5KG0lo4eZJt1hacvV4Y70pDigvMQK1iVEEN+xMsFBVFW0FARgy+YoJT
         q/n0zObuRLfUiRy7i/y+qQei96gp7saM25hJ5R62kXT6MHMsOgSOY/sKtjB78bACkFXu
         VsPek+NM61FjHJjw/E3afChJc28IsSE7ZHW0OHicTpCtOx7585lno+ODOQGp4U9tccWg
         ibhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218868; x=1775823668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lR8swu8tzq+dxl4Pi5r9ST0PRzndcB8lRZhy3FhYfxo=;
        b=dHy9JoydsDihryHspPPxMz2ij+uu6UubPm8hFw3QnXdUHZB/ONKZbh1rS9DdPbGPFq
         +9eE1ALWDnM2Qffg1J0I+imtSF3Bv09IXaEfRnFRQfGDu2S0wwg//+Bri/PkfixK8uWj
         +Ku425PNRsD6iAyIzRsRTTSBCBfYHPTc0s5fS6ZDmvuKcbxsGdgzk5Tv3Q1gmKk38y1e
         dVyroP/1gbpx1mBJkOvbba0qIcG1nU0hocMaGcBntxpHpu31Rn8Rff4vIZigL6zq+9xy
         ySwdLYMZyLitzJTDGQVWcR557I400+ksQ4BQgaynOGKgSgRNht/SioPnJXCBf5Kq1n4J
         ilCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4VijIAHUWMe8pAV9FVcB2QAlBq3e9To4Wfh/hWdMClzrx6ajIvX+7mT4Bwhw/MgpjDF8PcY60Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4wU5/0U/tkmOmiemtPgdJwhVttFPt4jfSpKDumgBWSDD7rPb
	ADAH33VuZiicp+MiskGVfl1zR+bSjWplTQAwBzpwB7bZuWdOA/4mXVqBeeCVIaHIh2jRbTm3sJo
	ujRCC7zpqrild7dMalv1pH8hV4WE9sgB7Th2g18/tHFFUZUrTmrzAIESLxMuzkQ==
X-Gm-Gg: ATEYQzyz5JrbCMpoUps+lfNSyx3KYfUzj9/tj1fGWik/ZWl+U5lXl7Z1Oz4bK5t7cqC
	MmjRWdJDjAQ4o7VaAVPVMdet/T7NolhSr5HvH93rtUzC1ukHsqJ6DA/lYYfu8n3K2+Qvm6FKa4v
	JS72N0Jz94Dog5lkd1nEc9xeTdoYG/abFTYU0m19jfWqkJG5sp3puho5DqP4Hc5i3RfO1nIzmPN
	cBcCgLixM9N0FBtIGu2lo2YkELsjnc8vG6Ip3NS5OUZn6YxXIPrBwYqNPSFql4ooshkjouxlUP1
	hfOZaZgUItV7UfmHFTXfhMhtm9NYq2v7L8OU/Jqz0YeCalMah5POspHbB+tNKDc2Dgrp4cFoEx/
	KMdmh+l5lOSdzsJF4k2waIS2tkTUKPEBhOAtXdYthrdA8cFP6hvk=
X-Received: by 2002:a05:622a:1b09:b0:50b:47cb:c600 with SMTP id d75a77b69052e-50d62c327ddmr38611321cf.33.1775218867585;
        Fri, 03 Apr 2026 05:21:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1b09:b0:50b:47cb:c600 with SMTP id d75a77b69052e-50d62c327ddmr38610991cf.33.1775218867072;
        Fri, 03 Apr 2026 05:21:07 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:129d:59e8:f7c9:47ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c54bdsm17479931f8f.16.2026.04.03.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:21:06 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Wilczynski <m.wilczynski@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: enforce PCI and OF dependencies
Date: Fri,  3 Apr 2026 14:20:57 +0200
Message-ID: <177521885452.18554.17367310851255954381.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401091847.305294-1-arnd@kernel.org>
References: <20260401091847.305294-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEwOCBTYWx0ZWRfX5wxr6hhg+Tte
 fG+YtGptEXC/aFzbXwXnyqLPYCIbfjGLSe3yOUaIEKIg6sliPBYsNf4AZPhlK/IVTV9X1fJWJPI
 SUnTnUvLyg1LbvKDcVbORnvO4iPhasxN+4I/AK/m5boRaj7WXSTXsKPQ/VrqdEW6ejPDkC4MfUl
 ++F+x3UShGZWzBs4WGvLPbANqeoC5XtOe1WqA7s49iMc/N3DcD5VeIffYwS7vkxwIiOWQNsC0lJ
 yY3XgEEjTzogTv4FWbylFsJKYxlwer5wlR0SexcdTYwJYYnfAHHC9wpjLpV9cmJGvCIofo0dHdK
 ONbuzDhYmQlTM8Id+NFjzTIbUMFY+YkJkDebeQRNm+Jo/pnMIGEEFJi0Njb4+dyUrouNF/+MGac
 3QCo2ji4lOHqSDRs8JjB03ENHa9zh9kPMRL1FYcPLNADj+vcukzYOH5AepUPqnuzVepEq81FiWR
 BW9KxzL2zp5NX383fjQ==
X-Authority-Analysis: v=2.4 cv=W5g1lBWk c=1 sm=1 tr=0 ts=69cfb0b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=q7eqT-KOLUvlUzSTmRwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: nOdCqmmo48pGHD6SDpUK44eHF7ZdvjZT
X-Proofpoint-GUID: nOdCqmmo48pGHD6SDpUK44eHF7ZdvjZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030108


On Wed, 01 Apr 2026 11:16:25 +0200, Arnd Bergmann wrote:
> The driver fails to build when PCI is disabled:
> 
> drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_pcie_m2_register_notifier':
> drivers/power/sequencing/pwrseq-pcie-m2.c:368:54: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'pci_pcie_type'?
>   368 |                         ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
>       |                                                      ^~~~~~~~~~~~
>       |                                                      pci_pcie_type
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: enforce PCI and OF dependencies
      https://git.kernel.org/brgl/c/19b8c8fc83f755cd52a2aa3dbdb091234592252e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
