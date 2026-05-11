Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067835C1B6
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497344; cv=none; b=WBXrGXKMdurjudvWZXmoieP21F2MVEf8zNjpYRyOt4G1iEouDahD3SG29luV0bsRCJWP1C56FKRyo082GUb+sA0r9BB+IRXHH8b/pfoeBxQM0aigf1XXmPI+Q+GDtVeInGhBVZ76tTKlEgt38UKgGMFjuAq8V722cNTtQKqh0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497344; c=relaxed/simple;
	bh=tTNXMZH6Ae+7u/TjfyIMvdzqq0hdS/+lhtAgJD0DOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRHsNzYWNbf0lZzMeaOUA1sxBqgdpYQpZnPC53ELc5rh06i6MbaSaj9JcWUM3G5MFLNalAcUslkEAJLPYplObJly0+DSWDUMXANLPOa1IVkzOBxlYmt7w+aDYPD9cbQM1Anc+VPSiP6mNjeqPLwXkyjP8KHdcGBGjyI6LC6YNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AvffCpGg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ecIivv33; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AvffCpGg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ecIivv33"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B9HSpb017299
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 11:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yMmxsHM6Uj0ezvVVKE35kNxfWzaw7YGLP+g
	ykgxHWXQ=; b=AvffCpGgIyC4GPNB+NsO/7GqsYPjpKtpaDnvWyzJsXXHU2V8MVj
	u6NJiopbN8d3rn3Pb6mZpErVt4hulbzaPob2+Ymgc8YGqXgJEqcLkbee1Q0N5nVB
	sC30wU8p5ypVBbJYDhfJgcsR1x5VBgpcBiQzHdSHJdVymSXEUcaxfWKiAs69oHD1
	uX9NcKp5YleHe2O1D4Z+SelyRvlYkQomvH7elqgnbYR/f9QysOUF0yLK/1qpU0B8
	OyO+dgirOSmkA2rJEyWMZlKcUs84puxBy/zHCWYSBjiLNWTxnjGAJA1zEFiyOsgm
	ZqBquMHFEUKk4AWBf7zjTG1ugAxSibri8aQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfsdf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 11:02:21 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6967b799acdso8036147eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778497341; x=1779102141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMmxsHM6Uj0ezvVVKE35kNxfWzaw7YGLP+gykgxHWXQ=;
        b=ecIivv33XunAofNSIxlBPAvQfTP4eukYK7c0Ai99cmduzWuqtU4tSqMqoJ7De6lae3
         2lzHVHgwLDgvcbFLtGfbXnBuaoB5GojP0OU3nzIM5uWu/cPrcrsdBqyQCCjTAoKnPLxw
         1HXWxKJIjKgfdHswfTYrS5lXzFZt6EZEXxAsjdm3jucjp2rvbvIzytsXwQlz11Ron39A
         8DT6+UO0m3wkAljBNSJtGvpaHnbqbV5qo4WZ+TTSDRHBJW4s/HpoFj0rYWsl8KMfQQZm
         RhIp1KK7Zi3adUhqxBRQgaAq1aiQlz0/Ie+Il4aPP4zFZ0IAtBs+cvgS5O/CjfWzF7BD
         WxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497341; x=1779102141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMmxsHM6Uj0ezvVVKE35kNxfWzaw7YGLP+gykgxHWXQ=;
        b=ohHAtxwLFuTPBJ7a6lggACfEReQc+J3eoZ3Ol8fF4pS0Sl9B5IAydjbUhvsnJL9o7p
         bAASUaaGwrEy+RkOXyNk2LBvtj3t+FqHRi2J5bFU50zYdKK55frX74k3C8Qko98bfl89
         fQe57mJqK43Snz2mcGZLnUQ2LMGHFVYTV8CRxIJOThDVeexyZ0x+/k/9WMFwMmdFQcNR
         q6S3zy3Navt/hkkrfU6A+H2LNtmqnF8HpkWeGEZydgjN8zLLZab2XA8JijZbp9p82QIR
         4DZuEMaBgTGA4de54Ms3ZV87WYIf+aYxjQ9//IG9a34xA1FpdAl3Sg5HVY/mMDk0Q6db
         rZhw==
X-Gm-Message-State: AOJu0YyChzRePcl10O9fPrDblMctfRgqV/pa1gdhDISA6N8iiJvIHwrh
	Ad8CqCyggnwIxjNI77PhwgGsQ5AqVVeSGaXd80+2/v2gce8elAIRvkIm5ykTSEWrcMuN3QUBJOB
	KZ19u4D76TcBh0UkK7i1UIuJygQiS95fWYCMsXxLzx2vN/Qf0jieaGhwSJNddWA==
X-Gm-Gg: Acq92OGtjYlvBe1lRAUerIuEhVxdZfbOXq6h0p+2fFD37bvW76UnQd3mmfcPzyDNAlF
	WujDtjcHkNTjAP5g6H0Djj0SaDxYYT5lki1v9LjLfnSIhtuYdc4EZpbTerFKv31inZrmJ4Ki4m0
	L5Dk4/bdaAyNxFjd7lEpPlt8eB8wY4vx7gsCkH6ZxPt8nR4bkkfuHOJyn4n/IN9Lk+e2MWL+NxT
	1vLz+N68QvTvbXIKdBQ4wRyAgwGrXv7eJ5UAPbOPGG0qeXiD7MQXUPb8JI/F+6P2QQINeGMVTwc
	e6N7lrTsd19+xcBdIenJ2eT3ZZaoS7iDD3fjzvL/Ma/i/7DcyL1HNV7fLzQia1VNoH/I/WSlKCj
	w8kT0oghCvOTS6eDz4WmVJENG+vXcNBAAZnVV/cSUB9PVY5gycjhyUoaNrV5I
X-Received: by 2002:a05:6820:160b:b0:694:9a8a:2ce with SMTP id 006d021491bc7-69998c8fed0mr12284336eaf.8.1778497340851;
        Mon, 11 May 2026 04:02:20 -0700 (PDT)
X-Received: by 2002:a05:6820:160b:b0:694:9a8a:2ce with SMTP id 006d021491bc7-69998c8fed0mr12284298eaf.8.1778497340436;
        Mon, 11 May 2026 04:02:20 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm109967955e9.0.2026.05.11.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:02:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org
Subject: [GIT PULL] Immutable branch between the GPIO and PCI trees for v7.2-rc1
Date: Mon, 11 May 2026 13:02:09 +0200
Message-ID: <20260511110210.46711-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01b73d cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=OnGjS8KU5By8L4kgiv0A:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: FERNQV_8-ZSNLJ1K2ohWe9i6oWtfVqZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyMiBTYWx0ZWRfX70ygZsOtsdZt
 c2SnBNVJqcgGttZbQHi0U1PXSul+12hyJopE5IxhawLBNdoIai+vKD40TGpcCmAQfk2J4uEJs9E
 +F6u2sd037nJTkA+ZRQGMbSmV8OyJlaFp0KgvGY1nTXDrUxBrvwsdzqJB7dLeqbPoHis2YuLcBh
 Y88lSy8lgawTOBB7c8AsgfpVK6ACcEmB671NNCIBs6nOzfqh8upjOfSKQfAcL5pO4rbYZckLpbY
 8p5Y105ZICJ4KrW0BOXcwj6gz/y9LKd4LBvOzeiwcHJvbTKyTYiQfXu5swPKCqamv9OKyu4yy5H
 JoBK0w/SejCMn7oPWqwnMVidDSBAyOONjeXcH/AsvQbweaGh9B0XuReOGfIpJUOx0h90axIkcQ/
 gRu+05W9Eb8U5BY3B8t2JSMCjpThg29X9PH7Fs+f+jH2AxY9s97QJQBpAHgE1icYC8Nb5gvbDXK
 LyG8/ntAGbV60gr5Wow==
X-Proofpoint-ORIG-GUID: FERNQV_8-ZSNLJ1K2ohWe9i6oWtfVqZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110122

From: 

Bjorn,

Please pull the following changeset adding a new helper to the GPIO
consumer API.

Thanks,
Bartosz

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/ib-gpio-add-fwnode-gpiod-get-for-v7.2

for you to fetch changes up to 8a46bd2638f1ad6d1ed73dc3ab10919e67274738:

  gpio: Add fwnode_gpiod_get() helper (2026-05-11 12:57:48 +0200)

----------------------------------------------------------------
Immutable branch between the GPIO and PCI trees for v7.2

- add fwnode_gpiod_get() helper to GPIOLIB

----------------------------------------------------------------
Krishna Chaitanya Chundru (1):
      gpio: Add fwnode_gpiod_get() helper

 include/linux/gpio/consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)
