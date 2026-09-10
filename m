Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576E2F3C19
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025528; cv=none; b=OnR2rmLZumjuENgmoCQDUsRLvKBv+ARbMwLUr7AA3FKX6f8BDTCdSIysNXHHWis+DG8n+tuSbxX73xYVTjFqrnZciYKOyUUg4gaL06x8Zq210/0pHmprXVRs1L1PVjzyvmNEUujJGxg59daZPXovBRhjnv7lPyxZIfBflBf5muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025528; c=relaxed/simple;
	bh=eM3CqgBL4woW3uvSNQaMJnpyezKNnY1o9BhD8Hdd+3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3yZnRUx0hw/PmeCBv9Rik/LLxsnpbuyZX72FuDWJA/j54BGA4dSEr7xzSlwUWsfkOAEqmcB4+oqx4HHty4zboaUvJ04vGcrT0PZVmLZK44/r4Er7KUrQnGlsOnEpdGlPBwDt9YDEM9tDIlW+bzDd+PAss67lKesRP0P2Q0hmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQddMCG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCPE6aJf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQddMCG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCPE6aJf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GYQO4187818
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ScjaRXisa630raTeVAXO2NA5
	6DeU2lojj5oSTcac+p4=; b=nQddMCG24aHiOxH14YsKQxQveYr2cCixpJ2/df8I
	eZi8z4qjC+Qtw58AC+E3EDilx9xjtIEp32jaZfNVmoQOWQw/RF2BqrCUVmlD7QRA
	MCQfhgqSGkGvc5jBciKAh3jLb+NhZ2fyIDQapwuSnCVUpsvb3EGXfcQJnZ65D13I
	dn/2eUVH+BP+wYY3OpzuqPqJV4D/7QiokrHGqjZ8kwYOESEO9kurZX9HoWdaczML
	7npESgPByKoDYe4qrkI943K897uow5nW2cpmWH29ms5tHLIFsrQZ4KxywLHRbdKa
	Bg3F7o9hCPVZxXJensMAO0x6n3uUA+ZXwrYE6SXT0Vif/Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcygtna0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:32:06 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c82b120e93so466306e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025525; x=1789630325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ScjaRXisa630raTeVAXO2NA56DeU2lojj5oSTcac+p4=;
        b=HCPE6aJffHVNWeTbETggkiNIL6VZIdRchzSoWnQxf2NQ596dAo/UMKZ0eMePA31R/0
         NW3fe0C6FVoe8BfH0eFyH8anS8hyp5x4gjsBBH4sgBASwMamVcngad1WgENzG4ylol1W
         ZrcrgyqXiTTWTYnKekiDWwglMD5XZi4ASJQ6dLzSMZb1CnNl5tLnEBVFsEUjgpYd/Wxg
         eGLggRWEjHPAWAEIHL29XavaZgbJdhRLJ1dR2ruiJOtmbUMktkKXR85jt3LKBjU/dXKH
         o+N3NyBIbL6CfD7CNvDaA8A4gBSWX9IY4FlWb2pGegUVPjS2EodH+G05TBnKxcCMUXjE
         ZD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025525; x=1789630325;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScjaRXisa630raTeVAXO2NA56DeU2lojj5oSTcac+p4=;
        b=EXwEVhivzZ34aQTvTjtenXw7JI9yNEfn2rAvyePTzeMDQLmObuFKVsrVH/OzidQXv9
         dlalcxN8zx196d8A9oh3bGvSl/oSr5G8keEpHJoM+6BXfbt8iiYnwBHhMINzevcr4/Dy
         m/a3TyOgzRRa9q18UgVbpCCXD6OOPxP92K8ZVordeBCSpFp6YwrVHVfo6otufO4AUKS1
         +mkkpw6szuWdid1btZ7KlLhVbYQAJ729TlDsszcwupn0OHHGx36Jlbf3ph5HKkTuSimM
         7Mwx/nkPwRwnRVlsd72yF9W+7Jl0GC2OHdfSJ0kG8TOWgd2ZQ7AY5okCR7Pzt9hfUoy5
         qflA==
X-Forwarded-Encrypted: i=1; AKwUvBwuXR+tbn/l7wfhqZZotKl7y8QIFfZjinEwonOZMdySuLag+7W1C0ZKrsLX0oYkIwIAaXNy4s5ZeQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m+mjZlwOhZFTN1BxASAjT4zrMBsvhK3u4iYrLF7x+lVjVl6DLi
	QKttOcHISfrfZokwkRIy6Z2Uho3jG7YP+yGnCOA2X11LXui26ek1it7vYyRQaliQBOP3MLX6QuT
	5oDlCl/Xw4hz1yc4HHsoyUwjC3K2PWCp5UAlVZH6+EFx5wtHiil/Th3ct9AHvpZq/QJ9+Fg==
X-Gm-Gg: AYBFou1d7ONhQxwEz/MsjhtdP+J8Lz3QYNdU79ODg0RbdralaSwQXDyTQVmFzbwY2Ui
	IOOdZMz//p0+EPur49TPx5Iqu02AnMMC9uqaXPuLyiNYgI38Iien4BtjbpstcmFmLhWMKNbY8fo
	h47X3wxmg+MqFZWIlZnvyy808eMZpPHZjSitnyn/p6evf1Tnx82FJjE90gnkJibBCDvvSW1mwud
	CNz/k6ZRP0RgEJleK16GErii1Q2XrM4z6qr+lm9Yr+hE1fwmLnSbsedktr0vCZ7UDf8g8F9R3Ps
	5pCxBu9AjzIZeoYsM5tMKuydzFOj+CSrJxUFKg8JTKyQ7tqGyvQmRB3VgjznE/JxKXvEsbJ7ZBN
	GwJZPQhihneXH
X-Received: by 2002:a05:6122:551:b0:5bf:a179:b2be with SMTP id 71dfb90a1353d-5c7ed4087bemr17567174e0c.7.1789025525441;
        Thu, 10 Sep 2026 00:32:05 -0700 (PDT)
X-Received: by 2002:a05:6122:551:b0:5bf:a179:b2be with SMTP id 71dfb90a1353d-5c7ed4087bemr17567156e0c.7.1789025524876;
        Thu, 10 Sep 2026 00:32:04 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm52719385e9.3.2026.09.10.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:32:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:32:01 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] interconnect: qcom: msm8996: Configure auxiliary
 Venus QoS port
Message-ID: <swtgayqrm4lbjg6ayd6qovtweqyutjbtjx2ymvar4rcflq5hrq@k576b7geg7q4>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-5-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-5-6dc5b5e97626@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX2kM6/aMNKw+p
 1zqyeqzQJgKYFL2wPyxg59StEgo4b29m3AmCiKmFZZRgIRe9OVkq8ojXu1uU+3Pt5em+mabqqQ3
 1oXAXRg6KfCYAte0yU7Pjvga7ap6rE+w14yIJk5vUPwpg/tpPYmjo9geLkA782sQoJkHKQ0HmUe
 pXa5eY2smQJFNVGZLW9jW3Z/q7a3ROp+dB7m9Iva92F/Osv/zMSUjaVP6jIx811kIsSCdTg8iSs
 TR88JgUs7+oivOh09tUhW8bx2Z2/StRIDDBd6pheJC3lns+zeoGvoi5auOajHlfpQdWs6S7WpbS
 DxSerBoVCo7C/Ns9I0RTpcUp3CK7UHEd1W7qWY/nQX9zKAWbFa807BhRbJcKUdnrsWTM1OfIw9p
 +qKDxOo1kRGcJWm5WjqBY0+oA0B8HkJ7lQRmYCkzp9zGneUocz0Arsval5knXo4DsFdcbePbZxl
 cxaIwsYfuB33xx1GAFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfXzDSiwglOEooN
 5mvw8RrtPL2+a8ZOOHwwmOF16ElqnQKLmhcNUesEU9ZHK3Yq8gPrF6BsiTw3TPRtf46IniLI6iw
 3vp9wTKwC1DtNrOTZY4ZzByF2DQsH7k=
X-Proofpoint-ORIG-GUID: 7-gPUB8RPqRruCwuVMk91c_HOobZUwNd
X-Authority-Analysis: v=2.4 cv=VONIDNPX c=1 sm=1 tr=0 ts=6aa25cf6 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=YMW5T1WhuyZJOF4bxVQA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: 7-gPUB8RPqRruCwuVMk91c_HOobZUwNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100080

On 26-09-09 18:41:58, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Enable the secondary QoS port used by the MSM8996 Venus node.
> 
> Assisted-by: LLM
> Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
