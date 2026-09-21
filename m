Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAB49B473
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983347; cv=none; b=ZdWUAaH6R2MgQWZo5gFEEOhdwfSTY4aI2HtCkqOAo5vfB+twlhytUrSy+ukYR9vZj0goQ9il0jkJ494JWCrdfJOLhesbMsXDzNUuMwuXnkIxIcUlTzQj8ESUWg2sDzhteyrRmlPF5BtAJ47rSsvmrbEgbmG8Zn/o+I4E1eek65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983347; c=relaxed/simple;
	bh=ViUeWJk96PNqJrIhaEIWN5xsXuhaArFaHhFVC6OOLhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUUdIhFU6D0hD6wCQX9y/l8HMwhdIxjVTSAmw0qfZiJ+8WrRdUj3PLaAW0Fts3lbAWepmBUrkeW0G3zYaNVB/RxT3IfPc0J1tOiBPDLSD8uZfUUUBT7R5wAPxcy47fcj4zBbdOaunQhH2PxmUxMLSRNqf7D3qg2dHz9Yk8yectk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFvsOztY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a7lsuEWN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFvsOztY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7lsuEWN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L8abtQ4146823
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 09:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mJTrOvpF8hQYLxtXvCLsRNpc5rO6U96I10x
	yU4upylA=; b=KFvsOztYpIvT7BiVlSUrkjRCgWpqbz7bevnuNrjNQe16G2UiTgH
	PZo7psoXfBCpj9WB7kWN+OgdDB7C1DeBKSUyMz5EdFCftCas1aY8ZJ3OkduKiiEo
	HnZ6nYO6PPfhc4aUa1HfFMLR+BWmQ6kYDh3YTw2dYQeGg0j0u7fab/0Sg8HxQ3aa
	WymnoUzuIjScFHkCUlrwBawf56lPMwT9VsHyxZrTHUYAkdCsXNb2udEszd3bdS6e
	FeuQkF2qZq9+DJoGGPPi+FTSorhIxHo6DbYjKO3Q77744xcxKcWOYUi6kGqLMai9
	ek7RbkSKjsdQVqA9anN5Ksicq+QM8sVsGkQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gr8sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 09:35:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f925ba4eso389648385a.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789983343; x=1790588143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJTrOvpF8hQYLxtXvCLsRNpc5rO6U96I10xyU4upylA=;
        b=a7lsuEWNLlqeiim+gwnOQy5YGR1YMWLGacklyczwPXV7xJ1GYX8wUitc9BEOjEkHs2
         0C2gCnMlNJkhjSG2BZYXxpmUAXKF3unGz/wmrNbJQd0pWLiNflYxXgsyEsE/2ftRzMjy
         rf+ltCrP4DtQ43BL518FPjybeO7i7Bjzf8CyPtDygKPeDYqn4Giz+ytYUYYJ1+DtYwMI
         ovcnS85Yq5I2L0UreDkTPN/Rgwmd8mEro8SSWab6EiTLHAOXJ1zHsEi5p8mSpUe0Hl7D
         c3iP/pmZSxTzHuwiAH6HA9RvsQq00QftACuFcdScyKoiLK9PLB/fpRxk/xNNp61ubNqQ
         5UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983343; x=1790588143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJTrOvpF8hQYLxtXvCLsRNpc5rO6U96I10xyU4upylA=;
        b=dW/kFGtRLtZV914KINr523k2QlK397n7ntx9W5mOquh+KThmD+NRDAoCu/Pvz/AG+i
         5wLNksp+xKgBXomtg1UlaepM93Uabuovtv/+djizELlc0CkpcFWjVjUm0KrAU9Vju57f
         JD43U1+Db6T/V5k3oAnYyTKlSoN5Raijg9knNpP1Laz6QPjeOweyUpZLuHBNVn0bZwo1
         PYHpOzUwX/CLWeHgqfzD672aj9YerA5XLlDYLAGPz2dBLY8WpPv/AL9dZeduSx/OWmUN
         unFzKsqD8oSsWF4RMyV860LJkH6duuo3dg1GGY0UlPd5p8p1XvRFDpVmAmBFslUbDCB0
         0Seg==
X-Forwarded-Encrypted: i=1; AKwUvBy464BTKyYp/NVmodfQQnVsmRMivnVutWjVZ5fdLybhffM645TQwVPQdK/Po/5EJtXPxVt09yjD7A==@vger.kernel.org
X-Gm-Message-State: AFuF++lMs0d9FMKig7KjCB8FENvDSoVt4oVTv4l2qCWseUmFkeBTCpd6
	bnuSPvok93vbCJg8yd2oRI4ePaiJHb3WLXsPfxYCwvN7ot5bboWSY7F90dffl0xzoIX7AhfFIg2
	obgTwjB2a2EYxNRfcIB/ZWJVkWDmhbK01CotPSiZ7tfT2+1QG6ySY+KQXk/vgxg==
X-Gm-Gg: AYBFou0fFS/NGHSD1iGEsv+DK1LFiNBL5N58cINLh3a7CZ22KfaIMlWSeTQImYvZZEo
	/XgeMbjX6zmlFyr/u3mAGhOMsMiV1+T6nv1arGapFYheaC0TzYHPuNLVlp4pmYNP2QvSO7oqIVu
	xaAc0zVTmA4I/KmAb4H8U/eDLcv2e5A0Ry8hmAHqNQZktUjnT5hy09C/FQ2+kHXUEtpU0tUKYdP
	C3tab7PqJC50rV8T0MDGDtaxilGlc62VkbAo+xoz5xb55jUrXWlsEb4+drxJwzny3zbY6l6EDT/
	av0dXvCS3brebxbUED8+wYyvQytsF7ePgtmL7z55EpjpqpguNnKOKVnVM0ytOFNt8PXcRAB8ka3
	5OTazfp2NE+DMhCYFI9Qn/Ok5Zg==
X-Received: by 2002:a05:620a:1a14:b0:93b:d7a1:ba10 with SMTP id af79cd13be357-93bf576ab1amr994782285a.59.1789983342857;
        Mon, 21 Sep 2026 02:35:42 -0700 (PDT)
X-Received: by 2002:a05:620a:1a14:b0:93b:d7a1:ba10 with SMTP id af79cd13be357-93bf576ab1amr994778685a.59.1789983342499;
        Mon, 21 Sep 2026 02:35:42 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456301dsm21897253f8f.18.2026.09.21.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:35:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        KrzysztofKozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing dependencies for v7.4-rc1
Date: Mon, 21 Sep 2026 11:35:29 +0200
Message-ID: <20260921093529.45596-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: on0vtNKY0UswzJ01r6-MuIAooMNXvr5_
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab0fa6f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=Dtz6quo8gWpENlhL4bYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX1wxlFojEIU3c
 gGlNslsh9BSjgB5tcDZIvtslnAnegA0Vt/pcGd9NZEUGAQ0csV4csBr7MID6WQ7HSCrkkJ7gwRo
 Z6CDbndBgYgAEq8Zeaj4ZzKXkppUYUMa68elxp4EDc3ElYILoUw1TMu+9TFr5u8zQL+4hyy/Zce
 6ir/xKKvJltI0COYYOh5PY20rwg1SqxWGcrsBeNrFP4kwJISSKhI7R1r6OHtlRlwFn8eZVU2YCo
 Glivg9UoxYmpXbE4NlgB8eG+PsnDHw/Rwxg/rttd+e1Q6mtLJasl5pEk0kEJG4kdvN2pdQPnCUb
 TbtO+r3sYdttMF35HzNo6aomegYEnxiW9xk6pWzgYYUOCU7h7xoqF+oNanElM0Dfj9U72AGgu2O
 8PzkLrkjfW24E3NxVahB//bN0XFQ8+EM6UilEyQ9tTWMy6pWTBE35sHUIQnufsbj+CHwJFOKNrG
 XELVEO0ywKlcK5B4cgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX553kzMbU1qg2
 YfIBuqeP9rhd+iJVEEU5lxAgQu/U9FhmL/gZ6C9lelcrDWC2Eu4BnfLyHU9viA7c9rP8I1wVN2M
 MgTXqNis07gZaLFN0FQ2LOcR0PDwkYY=
X-Proofpoint-ORIG-GUID: on0vtNKY0UswzJ01r6-MuIAooMNXvr5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210136

Hi!

Please pull the following set of power sequencing updates into the Bluetooth
tree to satisfy the dependencies for supporting BT on Monza.

Thanks,
Bartosz

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-is-controllable-for-v7.4

for you to fetch changes up to 295eeaf2c6543f746c1c7d9871f6d2f71a7ed4cc:

  power: sequencing: qcom-wcn: Report power controllability (2026-09-21 11:28:12 +0200)

----------------------------------------------------------------
power: sequencing: provide and use pwrseq_is_controllable()

Add a new core power sequencing consumer functions:
pwrseq_is_controllable(). This allows users to check whether the
sequencer's target is actually host-controllable.

----------------------------------------------------------------
Loic Poulain (3):
      power: sequencing: Add pwrseq_is_controllable() API
      power: sequencing: pcie-m2: Report power controllability
      power: sequencing: qcom-wcn: Report power controllability

 drivers/power/sequencing/core.c            | 49 ++++++++++++++++++++++++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c  | 26 ++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++
 include/linux/pwrseq/consumer.h            |  7 +++++
 include/linux/pwrseq/provider.h            |  8 +++++
 5 files changed, 120 insertions(+)
