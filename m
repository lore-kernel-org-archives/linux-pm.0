Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468039;
	b=O5pTpWJtyS5FzX9Yvxt1n9PuMBNyXNfGowZvw+Uf8bdqgPEU5Ert5z94ngXS3qxzcBYk
	 29tPThUCBceXlP56makaQNxt8gAaI25RMLUKgvscN7Dj5gsu6FiwDBKwSjKqIH9HHdMfb
	 J0Fkat0UkKXidFxb1+L8SnUMZf/wpYIWrZv7vOyoVkUjYYNDhRK/1fqB4xEzzHTLRTV8z
	 HfZBQ4LwGITBcKTo4j/r+YY7ZGFjLkaaJM3kkrjlqWuHmg65FfbalT005gp4P0GaeBrfL
	 NciYrrpjRoEdaHAwjO4FzGerTne4egutJ1CrMOdmR/t2C9T2sjVKfrJEGrsTcrcR49A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468039;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rwNiXWlFQ2u5PDZW9/aSnB5LCp1bhEw06E4ToHfhjDE=;
	b=F2MllkgWbTcaumvb5JgloFo91Xezuz5kNfDE5mvT3Cn1HxFS5rMmHtLDmZF5/21hYNoZ
	 sZnMmzAD1WXeJn2ryR2onAlv5OuuZJxaVlov7TSz9ZUcMcDEi/cvZ2c9y4fzIhkoE1HQf
	 zpgq+K0JaBKaUfgnWwWDmbcssVMIwYlVWckjlXGuyKyGLzHxL7+RS3Sgb5DoZBvLHIqzN
	 g+qvqDPaMnLJzx5VZEi5pdCpWkZi86NYs+bQHqiMd+2bGgaBezaL+lwSBGEWkgpFsEY10
	 k+PsSvsjf3e4pdbGJcqlwK1n8RChKj7m2+8Cmo2gRg7o1KZF3lnaXOYrehI7sC9z8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nx8cIear;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QATD8S4t;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9A60A261B
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F9A60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nx8cIear;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QATD8S4t
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZfA03812887
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rwNiXWlFQ2u
	5PDZW9/aSnB5LCp1bhEw06E4ToHfhjDE=; b=nx8cIearCKz2M7jUwCP0l6hGYyq
	nNQR4T7934+K0oNS1sC9kAfxW+5MP6Y/jsIGXdZ39lIsKIEEoG9Vpi3KbVT+PmMP
	xoR++p/dg4Nb130XSwcTiKIJceUdKsOG99f6lASdWzXjpa5IImcf5I8rMnIK+Cf+
	hxUOCBm+OIPGacas9l/+N5x+hPz/WmsZCorYKUFLxH8DKfuGuCio84OX5Qbgf95t
	v0HV2NJNJbCkn0YSIOOc7QtH5KHhGo/8qxLyCaPqWnj1eTopghiwtsAl0oYrw4P+
	vjV/QkXtxi6iqWZM2EzbjlDE845H3JG8JymJ/slwv0RwaJqOVg55T5ksAHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0jpqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:20:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b08727641aso320726a91.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794468037; x=1795072837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwNiXWlFQ2u5PDZW9/aSnB5LCp1bhEw06E4ToHfhjDE=;
        b=QATD8S4tJeA0mmBBT74w5H1ea6PH4eVxGnt9euzkrkca9iPfMRCX58BCzf0V6Xy0sd
         bQ/ckFwp/TpbHFJKC0JvzHaiqVVL4tgE9ZOL0NzCK3eXpnZRQLKMyYEkTV5W8cdoR+5A
         Wk1u/ZKlAwEB0ChWSuoQlRPDaeDFDMSpTsBpsH0kdiNCyig8Cley+4SZaN6/UkGrSTew
         2q5MWfeqJU48BghtIb+OgmWrs8DqvxOaRbpoi/bQhQhqSUn/NXuye6kTHFCdkht71Fnx
         bcpFg539N02bVnog+cbbPsnDxLVZwtZGZF2OTKnwRMm1ifWPu837J5USQ18x1v5l7HHZ
         qyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468037; x=1795072837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwNiXWlFQ2u5PDZW9/aSnB5LCp1bhEw06E4ToHfhjDE=;
        b=inaeNsCgGH2OcRXPAjOOYRrCZNEqAyzfjvdVbMHROzfjwm5rMgHW8tepAtatqZ6xoS
         K/MlGzZnmEbGYSQXLMYzBXNbxfmezEyzT9Zs3d9dtqqA4mrPAde3TkBKZXmgCYpwSj1W
         YDnlh1OielkT8coNOgo25+bzTjy3NzaCNoU+/thVpR5HrTLFh8WvQc9RYJ7PrPbGq5S+
         glmFYDdayoJU4dTVc8ATyJ6YBj/0WbmqUf2v6dhHSu3SDzC9yxZNn/3VpH40dajBNEiB
         fb2oI/i/L8Js/kOWAbpOtc+vkRQvJHt0dzvW5dqUm8mDgu8UXlJJvlJTrHWGFAl8QQY7
         jXzg==
X-Forwarded-Encrypted: i=1; AL+hErFRDAxLUHZAL6LFnjJYamODu8RA0in144FwhRCEZuC4Y8DwmSbksXEr1Hvt5rRNeFKBojncCSxfNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+tZfv9eq4og3sLpPic2vOTrMVKyg14wdLIXkWnSiS6SHqqnZmc
	OOcnUxaQOLtVzrx+ppp+5LgmH9TQA7wEdDhoB0JLjnsfDglQvCjmugbX5/3H9AHgWQUuThB7x7D
	6Mh/3XfMTiwIorqcFjwmkWeOKWqiKnicjPWc0toN/ynpEKVkCuPgjpv0L+rjaLg==
X-Gm-Gg: AYBFou1KMr/hcGG0VybwasvXNglXwgaMa+mNqcBPQ6BE7ujEXjc6tIZE8ZJXNDJbAvc
	BzkxWi8OsGmYGqY+DROeHJ50e7mt4shaI0xhqOu8YThDiG9WC2mGJu6lonh9nXoxqeD+khixptd
	iwiQcq6WnJ0MSLCL+uKP/VUe0VlR5CbULKznZ+ZhOgCB9Y8ZlmNDiuB/OYywxePZhAe9kHqC8KE
	WMfZL+sYb0sH6+guY6XkzDr6LJhvpR+Yzub7SH/4ZZAnHRK8oNFqoZUxunKOTiTmAr7+AeNybhL
	usHs6zWydiEMtgRtMb1YuRjCj64zghqXWeXicTdeIHe8HIaNfFxUYm7V/gUwlt1dcASEzvA1urQ
	PqrD2z3anUF4TTtSGMbPxj/dRzYi6S+ZoMmlAEVqH+Z1NwPITO7syekAAxep2/T2N/os27fG4ge
	0bGw==
X-Received: by 2002:a17:90b:134e:b0:3a0:c162:51af with SMTP id 98e67ed59e1d1-3b182d6a766mr7549748a91.0.1794468036651;
        Wed, 11 Nov 2026 23:20:36 -0800 (PST)
X-Received: by 2002:a17:90b:134e:b0:3a0:c162:51af with SMTP id 98e67ed59e1d1-3b182d6a766mr7549707a91.0.1794468036206;
        Wed, 11 Nov 2026 23:20:36 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c73e27sm3149185a91.9.2026.11.11.23.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:20:35 -0800 (PST)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [PATCH v4 3/3] arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup
Date: Thu, 12 Nov 2026 15:20:09 +0800
Message-ID: <20261112072009.3815276-4-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
References: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
 <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U-HduBJFGvDe0Rq07HeWCYGjen8hMlsc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfXwIJ09HZBER9f
 5ReQOVtsxI5pihWtX3mXwUUtOmrdDQFljyDxBFUwJ/zS3HbAjBMEvmJAgQcbjK/twj6W49sDPG1
 l0qmA3BjxklMn3XPava5qLyYzcoJqf5sTGs1I3qucOljsNUxMwttIPSbPiqJUtqpo3EbCVnRsU5
 tjzK7b71RLizlhb0pVZC3y1umkQrXvBx1MzQvlk+DWa8LR8ztrzKZ5tpisNkeBBDrO7yv/IufN7
 HEMBKVoX2YPYYdHpJfcdWEcZ4IXOUYEmlguxqoAn2gv2qWpYogo0noY9JsDvD8vK17YbWa3MXf7
 4kzVDUyE5Wh8qXOnO62j2BnMr3eDbUf1CzWsFIVEbD1SgPCuZlOLb4VzNIAab3h7QT11LyDjWlW
 wAn217vvN9ldU5WyWBK0ars5NHqi5diG57Z+gbTqmqswoQj0D1tOybF4uAcfGZ2vV7/5i5//7qX
 hTS79zeHv/FSW6nKOTQ==
X-Proofpoint-ORIG-GUID: U-HduBJFGvDe0Rq07HeWCYGjen8hMlsc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOSBTYWx0ZWRfX2fTifDS3PjOs
 WkZj7XLaKb33gQd5TjttvSinDoSpjXbHt9cZPwHfcVUEHqBbaelrvLftTYy1MNuhUtLKOy8QU0x
 RSIilkkAajx7GOyeYUEwOgxXBXhpW1s=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af568c5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=GJxj0BfhqkdqIuq2HFIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120029

The WCN3988 SW_CTRL signal can wake the application processor on the
Shikra CQM, CQS and IQS EVKs.

Mark the WCN power sequencer as a wakeup source so the driver uses the
existing SW_CTRL GPIO as a dedicated wake IRQ.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 1 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index 95eb7255fb22..c7b894b6126c 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -102,6 +102,7 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 
 		vddio-supply = <&pm4125_l7>;
 		vddxo-supply = <&pm4125_l13>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index 99e974f6ca7e..321bc6423728 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -85,6 +85,7 @@ wcn3988-pmu {
 		pinctrl-names = "default";
 
 		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 
 		vddio-supply = <&pm8150_s4>;
 		vddxo-supply = <&pm8150_l12>;
-- 
2.43.0

