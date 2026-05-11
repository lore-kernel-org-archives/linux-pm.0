Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5073BED69
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497083; cv=none; b=kqfqWg6OKF2L1oKSNs/z6Ds1z3U0p6GSamFlDYEHbZlmLvQGsrKDhJ9brzdrD41+UinNnUh+8RiFPFPDU7fNLhH7HeHXDzJ2aV207RSXTMVxPwnoP6gyQlpR7rnEJk+D8xwEvg5jm1gITtztAHwnpsc/yh5gM8HLtZNWbmiPM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497083; c=relaxed/simple;
	bh=idKSf0Y7Y4AVRyohvvU0Gin/2AbcPVLAoJEq2SUw1/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyEnfbXUk5JMGb48u+aRpDTnLeDUGOu4YxeLjb1PE61YuTkpD/zEdUoE2kolKaru9zEcI2acrdgrgykzRZ1AfF+he9tRST4/pAuqSeGwM9VgT8RFkXCrT8K3QopEtNaQGFWZJuWSZSknsGPRin86OpXez57tjuXiJ5zq6h1wnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PiLl/7Yi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XrAl3xGW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PiLl/7Yi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XrAl3xGW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B9A9oE017644
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sEtWHAym48gNPoa8v7LlK08pYl2QtT1Em0d4Un9steU=; b=PiLl/7Yi0R5gn+5i
	2hy68OfuaYkmHFrpTXSLhlDK+zk83/rRnwe64goU5qbMKvyG0CGjcN9ZvR1aFrA5
	QaX3qj18MpL6FvKb5Q4CS7mqsTLplElGPCax/l3UiXlGs5DV8VFFYDfcddEmWbRh
	5rA4NsRlbho4KGtmjLKn43mY0xHc6EVc7CwAYqEKgCegDzfaOrqJoezjKi/mhF07
	4sbepO1VFPQeY0uiTjtKPw3WIjq3ztMy9L+bLMbIods1sbK1MAtAYnC8yPLHqI4V
	ezyeqDymdwpAVbHV4MqYHncdpVNGAR35lG41AczSE6dxMolj4CTk9QHL3F9NgPuW
	b3WDcA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfscqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:58:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e136aff17so71693591cf.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778497080; x=1779101880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEtWHAym48gNPoa8v7LlK08pYl2QtT1Em0d4Un9steU=;
        b=XrAl3xGW6tMDdzya8MoqXMToh+ZDf5S3scEf7W9ZniEsi2knEay/0m/zgeY0uzVrcx
         t8+QDRFEKzLiajlppy1AZfZ4xsC/2ZmYXZGuslp+Z4k3y9FRe4ObXvts7nE4nUYDAExW
         8qHcQmAmqsDWJPCvHca4B5QBO/EVmobN1jpVZ+duoSqL2aH9IHREq+sNKIOH2jNnugLt
         kEGKDH8Jnwfl0AJtpF4ou9PE3i6+BcK3DQJbqKc3hePgSSIS+VdXIZRiJiyHu7YTdsId
         loeoxFPzwpvAWAb1kqyxBPrRkA2iarY935u5xB1O278oergY0ykKeNMPm+BSL+HXzSZu
         lo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497080; x=1779101880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEtWHAym48gNPoa8v7LlK08pYl2QtT1Em0d4Un9steU=;
        b=PsiC5lpHHf/A0dz/lbmt5BqRXiU/+ELixQmlVtPZ6TuRYfpEeRmUAxjaN7BbZmJztT
         fh387L1pykXJlksPZGKpBjAt3iBfnB8eHbebkHj51J1gcqvLgWzH6//6tQKwaLDGpSew
         Up0xCLHmI8v7t4wuG4cD1kmkcqD8xZmmsVxF+kEdQBTHZx1D5Rq6IUXwoTgRRtkxB4nl
         TdDjZb4FZmEvD5QnTSTMCYMUquw/gJ42L98cE1AgC7C6WAS+2Yy+uChkH2g8Vo5K4k9F
         Lw9o6fhkRlpaQiWZhjJPGLs0bcIYa44CYY9F4fVauJWNxl55pX++RXKaMBrw2dj6GcQJ
         +dGg==
X-Forwarded-Encrypted: i=1; AFNElJ9q+dkWgafrGbVzQDEDt9BHgu4sRgw28Q/y/goC8xxViPZxH1K2pgAJsZboeVOPpsVByhOKMGr6KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwDHcysoZHHZEWuEtKCFnwuMFiF6a7p6fXvBpukg9Zk7wdVtE
	AOjRItZO7fnZ5gvp6guevkJKzHZQtmaTQg6M+BFm3n/0r3kiZO2mqq84Qw4rT3vzhOBP9GVJ6mF
	+UPNILmyOVy4I6qYMsHp7DplaDLqMFZTE5YPzynDC5IQveD0fsHGTGb/afK1KmA==
X-Gm-Gg: Acq92OGMNyNzHt3zwqT6oIDvlKM292aiEzcVb71AAOTvdgVMzH6J8482zT3fI+ynZoj
	3cYvQA3BBH5Z1Id9kjd//84D2o/AJertGG7dQcO3FDkWvUKSIeU/6D8+cFqUXLZJgFJL+9MoYqq
	6r/n1U2dkzOmjnkyqG1gbDkPpMFJwKZpCk4yoip3TgNHSoJ+28YH4vgSdenH0S8gpYj+nb4/zP7
	Ro5QuvMyND/ICEw5K4400dzc4+tcmK1LzmRAlbTzz5HuH6zabaxj7Wk8/o8DBPXrSGbD9blcky9
	3wt8BwRUASBxAhr8PbbsPpQShb0jhnQQxQYsisY5i8h3jKRj+O7HF4iKIOxX1IhUhbTYF4PaQlh
	1xgZzI+W/oVINqyEcT1A1T2fcK0edQSP+I7XOErsRZA79vESDwA==
X-Received: by 2002:ac8:5a85:0:b0:50b:526c:541c with SMTP id d75a77b69052e-51461fb1c27mr339570441cf.50.1778497080352;
        Mon, 11 May 2026 03:58:00 -0700 (PDT)
X-Received: by 2002:ac8:5a85:0:b0:50b:526c:541c with SMTP id d75a77b69052e-51461fb1c27mr339570131cf.50.1778497079931;
        Mon, 11 May 2026 03:57:59 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffb9bdsm166087555e9.1.2026.05.11.03.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:57:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: (subset) [PATCH v10 0/2] PCI: Add support for PCIe WAKE# interrupt
Date: Mon, 11 May 2026 12:57:56 +0200
Message-ID: <177849707405.46496.8165024025113766918.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
References: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01b639 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TmBss_aizDygq35vy4EA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: oA53C2tIjTXfCiqbnk9RDfftEWmyrlIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyMSBTYWx0ZWRfX6MnXFdJhLzMX
 u+fIeAk0T1HC/E5B/y2W8f2mE7FNlUWUd0Z3jyLxc8G47XazoW8DmSmmpFn/MxykBBm3eqFRlRM
 ck13jbb+rBnipklXQ4DTy0DDg9QTHHAcbCPALVPgCeYUJxDz5fES+y6WPxLy3dhqusAg26SjYb8
 E9VGn6gfgSqGcOPx7DYhrQUr8F0OUZApuQ+AuqR0R/rAF61XEzy9R+MTjJQewqgd3z/NYiYTa3n
 oypL3B8Wh/EGPc8QbPVFTpoSKsw67bmLvL5fJw4HmmjIgvMbZoX5EVmNuN+KQXpEdgj0I5C9zFK
 /l5hqVms/zjOhKwl5TVZYuH293EH6lbrsl7o5swPWff3/Th67Kx2neQ2fy7XwcY/y3b5aTRGJEI
 XZd8vhUp1sOIhP+liK2OxmeLnfpBFyd7JAZpBAMnCIqEQNu2jR3dOqec0dBHJlKUna+I8B5QQK/
 jaQag313quT+c4y4MXQ==
X-Proofpoint-ORIG-GUID: oA53C2tIjTXfCiqbnk9RDfftEWmyrlIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110121


On Mon, 11 May 2026 12:55:36 +0530, Krishna Chaitanya Chundru wrote:
> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
> D3cold to D0.
> 
> This is pending from long time, there was two attempts done previously to
> add WAKE# support[1], [2]. Those series tried to add support for legacy
> interrupts along with WAKE#. Legacy interrupts are already available in
> the latest kernel and we can ignore them. For the wake IRQ the series is
> trying to use interrupts property define in the device tree.
> 
> [...]

Applied, thanks!

[1/2] gpio: Add fwnode_gpiod_get() helper
      https://git.kernel.org/brgl/c/8a46bd2638f1ad6d1ed73dc3ab10919e67274738

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
