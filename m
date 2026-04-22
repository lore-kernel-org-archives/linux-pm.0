Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C73CB2D0
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881771; cv=none; b=LTehMqtG0dCPvLlbijrKjTZdhPQxKsSHdTxRYyD0QdKbAX2+ifFq7yem+zp2E/2MEbKnIR4rZRPn6I60URUqqn34RMvg+v1unriJSQr0hZojsc9YNHvB9KTUliElhKr40sHmQdkK9RzkVkfl236M4TG1vXKek/HTOcbYbwTQjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881771; c=relaxed/simple;
	bh=mf/wiGIJo7w2d/nZI+wHpViVNnpSzdppqqCqUoYg03o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNTLkwDVJW/EtYnqpkRlWDo//iAnQnUmA3U5/+y/xxY6KiyJ7OufPXr0VqUEYW55aM4yIetYxuXp4eK0HHqVM/ruU8Z3yIUiPez6q56NPP0LHmBpVqe3bY7HjghmI+zL/b/cb+ZY6oxCShRPWc+rYolCUj5SgJqxXPiv2iye4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFCWpEu5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3Lc6rKZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFCWpEu5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3Lc6rKZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG6aqW872740
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hmf2rPquk5TMbSfIW3+r6rwe
	dWNLP+19dSQv3vyH8d0=; b=NFCWpEu5Ahuf72qjLUAhRj4l6vSUmuYay65p7+iv
	ptcVKpVKo6/dhTqnDIil3vTIvVYesJBaO3FVNS3wPF376xSOwRlIMmRSFrDkPE91
	lzaKrc2wnM9kaOIUtj1ev8nazVEA+dYCk6konbnNGQXL8o1Se37ChIDR+Dx8m+0b
	ZZv5/M62/L9mQ9o0nA625voIcQMhdaMkKuF+x79tHyMUEJW2IeVac7bjcj6Dj+qZ
	yAJoY1+qRk6EJhP/+r7uG9zfGS4II0DAhS/8ftmnFfn67pPjC1Z97x4lWxn6ntLM
	x+CcYKYu4wgbgX8Q4GeaL5OzR2MgiI2hF/2yv52c4hJ4Fg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh0f71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:16:08 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-479d4674399so2575191b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881768; x=1777486568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmf2rPquk5TMbSfIW3+r6rwedWNLP+19dSQv3vyH8d0=;
        b=J3Lc6rKZWkEYsOP0Ju9K6iuYShEQ5eesNP+6LXb9HAUb9lcLMjnE8AD5URfjkp4wSP
         UHkHThfiyCVz0JZOMw3bz0WeNGg0KyNs2QMlXjSBXbmsGJuugToAvCrAqTcvV+K5Imcs
         vtKB5j2ThhlrD0aTpvLJVnIKmAn2Cy2UR/jGLkZ6lRbA7Z2cghRCK6TqNPFaY9O9TcGA
         p+LzbMUrqgzrcofLj98uxtwNXwXkWrap0zXj+byXDcbNmX5HhCShz6r6gpLBJa1yuHcj
         ktPxQ2v8BMkIU85Sr/qxmc4W/ZBoB0pPSfSrsBCOiWnMbDYtQ0QQ62+XwS7K8JsP7+RM
         UfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881768; x=1777486568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmf2rPquk5TMbSfIW3+r6rwedWNLP+19dSQv3vyH8d0=;
        b=QnRWPltcnzX1/LTvJD/YJVxd5Gg5tTeVgDpPPZ+/aFGZs5tkd0AMN/TPuULsOo2Cgp
         K2wS4Cq9C0VCp9OA0bzK01AAa/kmGj/aEqxox54jsBEPjL9icdtvmEaDgjC3wJMGCZ3X
         MckIvn+F+u6Q9gcGHzQXl4izpM8aGqNYLEFFzM4L0rE4wwhErEJbhUUChhlrhHRZhoR9
         Jh7FQK8o74dFY1RfK5RJJIN+tFFGOSyXLy73M07rf4z22/VsY/yKklC4Gyl2ZCU9VAzk
         iDi0aUaLWTg/hnRUJyLz+DF60cS6V507zIpvXEz/3tZhIH3gz0hvi+nCWGV53gpJ+nKj
         twOw==
X-Forwarded-Encrypted: i=1; AFNElJ/e0YEsT8Y5rFFNZYOMh7gWuQPQj2ItQG9ghTa0uP0cvWtNXFkEcT671rDEtbjkecJ0eLGp6Yjduw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbR0JVeu3LZWutpaJ9NtPK5wNjhEmBT8nN++dWZMtNqZ9swMKY
	6IVpajlCwHmzYd84iskQHYNR4M5w1fR9ZCDbo7pzfh+UHw9IXIiE9/S0d7jRu36irZN5XL9D9zb
	peTPYKVtk0Eo1X89s3/S/OG0JVv32EX6Coq5KiUly/uiLOQuI932evuV3JV76Sg==
X-Gm-Gg: AeBDiesScwTil5U7lsOmDDJMUce3zwHd4uQJi+MVHVdWLUhhXfp8CHdqY9Cf+b0OIz/
	PfKtWkq3Ms2v9cbiIYugxrz2u08UEsz2RjOzMeYSyCQty4EFXSXFmQ2+HOfLNqqHQ21YCFg6+ku
	v/8nC1W948QjBiHDznjuw9rv8rOOD9ISUZl/Bd58kHAgxprfmzA30cQOwgSE2BoQUBImtcneN3I
	p4XFIeE55w+d9pGL5ddiOYIDgCUz8R2MrXLLzFRivs/ZpeUxhhYZiIeNN1aYp89V6Yop/saqtAq
	uVVzhuYrSabirUqZnV7Vd27Xqbv42hLsp0P7Tke1Us6X0YP8F3IfOo/v7zg/jtuEHm2yjphnurx
	xRUDidWsvVAm1tvzPNMWne19SOx7+1883GCYpvfnnPBPI7bzDJ+n8UGSdUmeRe1U453kS6Uc6VL
	gqPUKm6fCYuKSPrJnGNw+uhERoYBHQbRUWihMYTP6tuhpq8w==
X-Received: by 2002:a05:6808:6f8f:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4799ca08539mr11775112b6e.22.1776881768363;
        Wed, 22 Apr 2026 11:16:08 -0700 (PDT)
X-Received: by 2002:a05:6808:6f8f:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4799ca08539mr11775082b6e.22.1776881767903;
        Wed, 22 Apr 2026 11:16:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6b20sm40071291fa.18.2026.04.22.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:16:06 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:16:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 10/12] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
Message-ID: <cmeufrfrpongh77x4leqbxugc5mrrtryjbn7talpxnnxgjd6ho@fcif27twuizh>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-10-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-10-720d02545a64@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NyBTYWx0ZWRfX7/R3wDeOO095
 X2l73SeZbWi2KOCpC2T+5iPeyBMsN6zNL4ctlfsZQORdrNW6Ib85Wk72ZlXeoTYJXZWCmBkoyxA
 c6krU2dd+ho+tOaS+6AzsGt7QEmMBzwgvPY94aGepLv1ywMXN2NHUh6Rtg1WTcqp+UqGWxiRnXk
 ujkd6KhoSj1t2eXaEGxsfEdx9CO67Gr0REtUaWkNXIeJPL3GFgVLN8CmsijiJncsxXdqKXymmCX
 s9j3kFeRC7ENLP9DHAw+yPzERJfXS1ggqtzbjXIOpqa6bxBg10HCKko+BO058bZyCkngGwxsCvr
 GvsgjPFeFXyKYwQofWwlWcEMkAsxfcy2ey6VMaG8kguZwbO5UCRz3e7Yk1KSqNYjI/HOAR2payw
 xBHU5v9zOeqEk/WXjjaGkSnRzvS59d96F0vxdywXn9gyqq8jQ/8WeE4/isVSjY48uB2jtaY+CPN
 g5/l30PYU8Of4zeM2rQ==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e91068 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=yI0fE1SOOqVeyhB3FMIA:9 a=CjuIK1q_8ugA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: 8mJ9pIWfnSbu8srh6KL4RSFiXIXKljQi
X-Proofpoint-ORIG-GUID: 8mJ9pIWfnSbu8srh6KL4RSFiXIXKljQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220177

On Wed, Apr 22, 2026 at 04:54:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
> GPIO in devicetree. But the naming causes confusion with the new pwrctrl
> framework.
> 
> So rename it to 'bt_en_available' to make it clear and explicit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
