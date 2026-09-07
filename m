Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89D46C4DD
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779834; cv=none; b=YbZpOMt9w+QtoLaYkJg8bK603vbo/sPGPrrHCnMmmWwDtzL+yjlqtw1yv1NljlrRUiWn6C74OUQKsJ9MLKBXKYxV14NF/UrMOoHGKQl+X1HpMyi9ZRkEjM3K1pXUiTbTjEAH5JbvR4QYg1/gH4F7GHvboTGtICj08v3Gf+Brq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779834; c=relaxed/simple;
	bh=ragRTD/eSWRr0i7oNZ/f6cbKX7zyeU+DSK6IwJzjDEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6YJL1mUSvtL437zV4SUkVsYepkGa1kw776OHAtoGwC8TXflbFVlFMZazxEe2FVezzKbXXtPv0th4fQ3x60fRdWNQI7Ncev3Cbbx/QLK/LvBR4RNWXwdmLNwLJR8pu4AUMemzb5zUav5uKaiVIcYpzsNoQa9wMzO7thNHMiY0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y5AytUk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Up4NGJrm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y5AytUk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Up4NGJrm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnRDH217680
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 11:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hx30CqPRS946wiUAi8sDP3gBPvcgRjJiueb
	cFUrh2Xk=; b=Y5AytUk0zlXvDOnmVDBUjWK0AJOcnJN+7rP8AAkv7byebXjamK7
	E0vQJX0sBX3iZ7uzYlBxHBhG4nUv/TUDG9x3ae6lYJZF5Jvcd2xHcoIhEPUdfZzi
	xUXOr2oc2PP+hdvWMijmpfZenKRDSMd5xATKeqXWNNlA4sPv+T3PFGWV2/V271Km
	je0Q9S7hABWgd28A+9pY0PT95fBQ3ML3+2H3s/dWlouI95zS4NiP9t+g2eeFOz8e
	oZLjgshPA4TeEqXdo7aXlKLK5PxiIlco3oico71PbFtJrdeduMHjbyhAw0v6o+bl
	JJqTKgZ2Gb9RNxCkgNreeU21ml7p26qtc/g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqgheq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 11:17:11 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97caca2faacso287771241.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788779830; x=1789384630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hx30CqPRS946wiUAi8sDP3gBPvcgRjJiuebcFUrh2Xk=;
        b=Up4NGJrmgWfCbQG2oQHufeRTBqbNBzY3R5oq5Ll3ipCFk66wf8WNZdSun5W3Qg67G6
         Nq2ZOMpcsM83lqi519LbDDm9Nvf9Z7leiP9TQDjgqr3rt0VoYR+cttIaWKCNN7Uzt8IL
         DIGhWX1rUAwg0kvIPPhR0Qnoav2+QLtX8cz5284CTktAt+u+xVJ08PVhDEaA6JVxrapq
         huqs/MsWd7ritbWOeYuO2YvDW6o7w/62Bua0XUWw+nVaTGxr2pK3LFsHBBzuaq47I99x
         BavVTbhmieQBlNvokZU87g9FAM9n/e02TD4DtO+HNeLa7HyI86byFRT0wSCrq8CwRwnl
         2Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779830; x=1789384630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hx30CqPRS946wiUAi8sDP3gBPvcgRjJiuebcFUrh2Xk=;
        b=d1yhipdW/CPKTI56l4uU0+b9dz/dGRSIwu0bEfAkL+UcGdXKAHOfQ1dHtvDUA5+lRf
         VHF0kzKArH53gVpU0c8Laa1FLmwdWTgcQaJdAn8KsB8dQW0pRfa1ujQfE+mY65esRNIH
         HiHpIizfdbkc1dDhAeTPIPb42R7IE7x63I/3IVoX8LORS1ht4InEWbVn8qBq8m/dWuJw
         RuDgKcYnAJnz1/rcXJ4gEmM2ZYp1kchP9M27pKZjE580bC04bqW7ZCO7mh+Ysj5eGOgH
         SarInrII9ZuOeCMJ3r20TVFGYGRxMojb1g3YYaAxYWTAN5ctu0V8HroTXwn/3JVvI0Vf
         RzSA==
X-Forwarded-Encrypted: i=1; AKwUvByYGaXtA4WoNmrW++feryeL5bAKN2dPY78ik7FilRgGAr9bD5STm0AJOzjrC55diquYdkTMAnMQeA==@vger.kernel.org
X-Gm-Message-State: AFuF++mix1kNGbsmC1X4TWhCd4qVd3YfvVrjT+6I9viC8SUwXRU9mBvx
	GpXIz5Irkeez8Jv42P8nms9UYzrmOPOnvCm4Dz9H1tmSJx5OrJozlaiAHoo7qdP5usqd6Hv8N/A
	bDy+e4kpRq3lORLnLfm9XcmFqRuamJvQ6vGr29gCN8QUkJCIndAEm4+5IuXyuzA==
X-Gm-Gg: AYBFou3CKtEmiFjg+UZrsaD2PiwPQlwVnIOuLejryzTnC2t/HQ3bgd5LkLslIM3UydS
	aGd2NvlvtO7L77S5XOFqf9LEzARnlsRopumkSUqIetnKP42Wzo/ZO+oclBJOHUkigRbuyE08Bqr
	ENkcsGKk20IjRgMScMKrRf42cG8n4mzvJdo9ePlXZW6Od0szlcxRPdly5xRqZQFAswVCUms1nu2
	85OBFTgibnEKr+awxXLcgvSN05qQ/034cC6FDWToLnoOcVJ+WhQpQPJwxeq0nrVbV+wpbb/t8Cm
	R+rCfwVsaOqP8UZ/S81AZrf2R2EkH0qLt6e4Yo1On1RBfmCF3KlrPl8fMRmUW+LvH4fL/B5dx4G
	FT4LbhksdTfnxx4rWg7QHlS1QVICn1E27dcjnYddNSHT7mZGiGOtDO5wKxg==
X-Received: by 2002:a05:6102:943:b0:77a:d089:3dd8 with SMTP id ada2fe7eead31-78a4aa5a199mr6766464137.12.1788779830456;
        Mon, 07 Sep 2026 04:17:10 -0700 (PDT)
X-Received: by 2002:a05:6102:943:b0:77a:d089:3dd8 with SMTP id ada2fe7eead31-78a4aa5a199mr6766432137.12.1788779829944;
        Mon, 07 Sep 2026 04:17:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cfaa2sm456120066b.59.2026.09.07.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:17:08 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <goledhruva@gmail.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v3 0/5] pmdomain/cpuidle-psci: Fix behaviours for CPU PM domains
Date: Mon,  7 Sep 2026 13:16:50 +0200
Message-ID: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfXzxVrEw3xF+nD
 Iqiv6zRbMTP3SP1giXr3IiCvWYSgTdYKzDJfAAUD15Wtn++a8nF8JEJtAvfiWAxBa7c3IprQ2No
 i5pazfbA3FMXmrKMSAaXhzb/wfT3N8tJ5szLqu3OYHiG2p2YdGYyJ7gLalu7hTtE1ZZBN+9e/S9
 JmIL6jC6Tpv1SzrFg8wVzEzM8gMQxOKzKY93Akb2SJCKr7k1yU7C9jqODrL/4dYO7fqeDRQDCf2
 uzVhfiZMr2lZbj2fZ8FXPn/udVDxjwzSdj8/vxpWq8yv4GnE6U2XsVkWbEtD+RBiCgs0JQW5T4e
 3D+SvwZuIJL9JgPbDcz13eL4hOL35d2lN8u3hFcKnZyU95mym99orQDfh2d3sprfxuzv4A+XWxo
 +cYjZFtk50GvX9EfrT3Y5IFYO3m4u7RVbd9ubmbI0JeoX8Afb2nLAtjRY+mi+BG5FyDkthaHUyc
 ssrSwWFtkNkieRuMNwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX+Dl/O4qRgOEe
 WdW5ZvtjAW6R7TMyv2p5hUu6b1Pd++ep1i/oeGdelxTfD/e4OUlb0KxsQhO1qgof48m+vyzySzR
 6hkNs6ka7+9aI0v/y4jKX3CU6v+ZXDY=
X-Proofpoint-ORIG-GUID: Jq7XyqF-787-zG-mRpajvOsUMl0S-Wtn
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9e9d37 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yh3ps83G6N8KMOvRL6AA:9 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: Jq7XyqF-787-zG-mRpajvOsUMl0S-Wtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070124

From: Ulf Hansson <ulfh@kernel.org>

This series fixes a couple of different, but highly related problems, when
dealing with CPU PM domains. More details are available in the commit messages
for each patch.

Note that, this series is a follow up to fix problems that have been pointed
out in a series [1] from Yuanfang Zhang (Qcom), to add support for new
components for the arm coresight subsystem.

Changes in v3:
	- Minor updates to patch1 and patch2.
	- Added tested/reviewed-by tags.

Changes in v2:
	- Dropped the RFC.
	- See updates in the changelog for each patch.

Kind regards
Uffe

[1]
[PATCH v2 00/12] coresight: Add CPU cluster funnel/replicator/tmc support
https://lore.kernel.org/all/20251218-cpu_cluster_component_pm-v2-0-2335a6ae62a0@oss.qualcomm.com/#r

Ulf Hansson (5):
  pmdomain: core: Rename genpd_status_on()
  pmdomain: core: Allow a non-CPU device in a CPU PM domain to do power
    on
  pmdomain: core: Add a genpd config to support unknown initial status
  cpuidle: psci: Initialize the PM domains in powered off state for OSI
  cpuidle: psci: Move initialization a bit earlier in the boot sequence

 drivers/cpuidle/cpuidle-psci-domain.c |   5 +-
 drivers/cpuidle/cpuidle-psci.c        |   2 +-
 drivers/pmdomain/core.c               | 112 +++++++++++++++++++++-----
 include/linux/pm_domain.h             |   9 +++
 4 files changed, 106 insertions(+), 22 deletions(-)

-- 
2.43.0

