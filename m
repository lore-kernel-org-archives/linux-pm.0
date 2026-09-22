Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63237FF6D
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042799; cv=none; b=PLTjqfGbkypzwQ3Q4eyvHvfpV3yHdhLIrvdEHNBlVC3Xw2yGNwsLApzcVWo7yiXADkHZFUzz95WwdEkVGyXy8Pp3YycRcvFnCLctOs8EDekCvRO4QOSQh8ZH/JMA3kKlYBM/P3Kf9+CnyRMlZ7sXXn2kiiwm/3/5Jl55KfanNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042799; c=relaxed/simple;
	bh=sYbc3ej1uxvGbp7fQ3xwsiXSUYm/TS3BPEK3mBAv/HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzKoESlT2uqa33EFGV6cUS3lmUjSCt/XNGSi3lwohbUWE/dqczRav4PPSjjwhkj1YGJZsf2WlFsEG+K8QP5t+fNQ3w+aZChgEtYBl40NteUMwqVx9a7Zm21Ehicj3qWRy6aNV4ozADGiAhlclSut+74l119Z4w3h2+HcGGN3X+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNzxKV1l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=StMSNi+F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNzxKV1l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="StMSNi+F"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00ApH1978678
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MNfAeP8Wdcs1DlxdNoGI0v1RKws/Tqf1mS/
	DQs9SHeo=; b=GNzxKV1lFBz0drrzvIqC8/hVgrRLn/eG2/8JGhIwn7lYwPRWr27
	3BvaM2fCTX9D1xWE63FyCRXt7aZ+kfhwRDW5nlo6oeDXm1MIz3xTdZiFVB8Gc5U6
	aTo728lYhFDAFCB6287SpNSo6izqZKGnfnHsDOJMe4QGfMN7mo72Z/DjIRGtjF6f
	DWJ9KKE4pI/NPoKATtAEdSPT49KzrJDYhAym15ECIOR4wMnoK3elaC5ywfpbd14u
	oklfaGuQZqVGsSbv7UIeRkR5AmtvwYM5LLOQ7a8PjhzS3FNSWTsODpYt48Im+amw
	ANOZ2pV5Aj8YwfLjZXyX3guv6NyPezO53aQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0gh66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:06:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so2912362a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790042793; x=1790647593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNfAeP8Wdcs1DlxdNoGI0v1RKws/Tqf1mS/DQs9SHeo=;
        b=StMSNi+FpopRSY0z9fdleXuXoGZdCWsjyzesTa5ofwGbElJPa6wgd3mc91b+uQbgRX
         k2WaX65Zjfer6HCy2J+coUSMy7y+7Z0qOGhGwloktZsuiWdhpyJI+/2BqMHJFBe7uN1s
         PDVichCP9Q+xZnPdV72QUByjM+KSXP5RE84YFpfkVlqP1LawJygIg4pfVh8kQhFenZbY
         lT03IkkQTFsEB6w1Dsm12H9po3UdXQdZpcMRSCQvn4Hw+X/RBJAVKlQ0SjP/U1gEd9uf
         4UPdp0YRCIeHA2ADMtYgpfkU2/bugteWj55jZyI3unIw68D4HOnj3UH6TlKQwu9m2JY+
         3Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790042793; x=1790647593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNfAeP8Wdcs1DlxdNoGI0v1RKws/Tqf1mS/DQs9SHeo=;
        b=MZtqy0cOIoGUSD5RbvDDip9YrTKt5jE9z9rBUtSRpO3mR5PHRh2LhgVdl7MTEkyXKB
         NUQA6kjSxm5c+RcXOf8AIPVYp7/2npn+Wgpo5iGCQbR4P4fzUFBxo8jI4c7kv4zSH5um
         koPInzNp0OqWtw6QYr+b0yeqRPN4KXE52gqeD2xlQUoNGZPkJFnDmUtVEEw5a82kRkZQ
         oK+4zPqCbCb9xDoU16zB9lC53mwy/oeB4e4tDFErxvuX2q+EGDekaXNIK1G9Tr8fAFnF
         zx/EsDSHO7/Mg09/0gU5fSjG+YuIgMrmkymqudN1UdBa7PKl336sUgV1RqfKn6lAhlD1
         zHkg==
X-Forwarded-Encrypted: i=1; AKwUvBy4NNXIH7ynUGRXD/oTGQEEWwOc2javuI2g4ZbEpgOvbtLVHDusxB1Zsljugkajh2IHOzms7Fg8nA==@vger.kernel.org
X-Gm-Message-State: AFuF++mClruLO84yA7b6VmNou7P2+tF9lIFEJKRIK0KyCxayLgjsqqQb
	QWTkQgHnToQ4bkX6KHRbUrwjFZEUNMZp3JskRSZDbzkYwGSTZ6ONIxJJHoeYijapRsc3LMTOEgZ
	cf4eJL4QYel+aNwJVSpzOoGwIqy1eB2L00FxtttSfJSEG/RQt2lCq+WA681kusYt2kSOv1SwE
X-Gm-Gg: AYBFou0QuuszM9QolnVLxNQ5JarNLp6uzrbhHt8tD7gByGp00DM3PwTK6Yeu3VwTeOY
	RkP4jFOtU6pu1hXfX5pxay0sfEYR1GjdBjwjK6IpZVckQ0yB0/MaRdGAQgUkMAh3KWUVfW/aYVo
	haXdnyf8kn62quMg9W6x0KfQDPTYN3suMbAeLCYgaF+AG1shRjMRlVx4kr16k33MP2UnLagf5Ev
	Yg/E1l33NLMCajGfn6UD7cb0huQtKAGMLu44nyqc/dhwDHwNbSD9AovhFNTdwvu9QJXOhLmZqJF
	GCm6J3LV7Z0KsoU+csyu/j3m0vF8gSpGo0dybtxA0nOL+ScdNRau85orcBY/8SLjg9Hg9bGNNm/
	vyQdT6rig0XOypklLGxoSVD14TZ4JkUXiY2TdU0f7qDz9yVkRN5LqIqiM58w=
X-Received: by 2002:a17:90b:4f81:b0:39e:4c7f:8b1a with SMTP id 98e67ed59e1d1-3a06af1034fmr788209a91.31.1790042792618;
        Mon, 21 Sep 2026 19:06:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4f81:b0:39e:4c7f:8b1a with SMTP id 98e67ed59e1d1-3a06af1034fmr788170a91.31.1790042792021;
        Mon, 21 Sep 2026 19:06:32 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129ad40sm1044028eec.12.2026.09.21.19.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:06:31 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] interconnect: qcom: Skip get_bw on QoS programming providers
Date: Tue, 22 Sep 2026 10:06:23 +0800
Message-ID: <20260922020623.398913-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BwP2Dh53T2Vu030k5ntTfxOTMoFfcZT2
X-Proofpoint-GUID: BwP2Dh53T2Vu030k5ntTfxOTMoFfcZT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAyNyBTYWx0ZWRfX5Au4Zz5wjMkZ
 KhXTwVWugbGUcyS5Of817MhKFpwUI3feIJGIqKvbiReClXIG7LQfaBmWv0kn9UPrHcP6WBYnetV
 ATVBzDZQhie/SINyMjvuiJ/7VGu9DenpRo3oFtUofyPA16p3Rg8rML5JmwRao9gK6sB6KRvemPx
 krix7+BB8Ajupv3OkwjHJwjCHksfKwQMhK3cSJca2B0QxkrK3nTpRWQWcbSso1OKrpLGAle7+0G
 f4XCEIub2JgEy5u6yLpTCNwhcaYjODygtESTkXjnJYT/TareXRhRRzD0Mhn6WGfzesfJrQLctso
 3cyp3tVPb76DExNWU3/NKEAQXdh+jjWH09KCl8A9eCZOd5Z5eZwx2WvdEWIyx19huAIfIH/p+fQ
 93n5x1SDB53LW8OmT5ISYqxp05PW3r/2I7P2uT+aCc2dNMkjYlT6rKs+3xSoeSFXSoeFOF04QRx
 yVfe3/s3fnUKBc5bMCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAyNyBTYWx0ZWRfXztL6QS3GBj3D
 z9R2yr5nENWcDzTD1ketZGqHonYezxuRQeFba5Ygyzc6RP2r9/UPS8dOvhlU5s+z8zk/YIAJeaR
 ZW/gcMYZZ/0Dw7hAgCabsdw+9cK/Ws4=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab1e2a9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PElIDr7-s1pVZMEy5acA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220027

Programming the static QoS configuration in qcom_icc_rpmh_probe()
touches NoC registers directly, and nothing in that path clocks or
powers the NoC first.  It has been working only because the
interconnect core used to vote every node to INT_MAX while adding it,
and that vote stays in hardware until sync_state.

Reading the boot-time AMC votes back from RPMh removed that implicit
guarantee: a NoC whose BCMs come out of the bootloader unvoted is now
left unclocked, and the first QoS register access aborts.  On Qualcomm
Nord SoC, the MMSS NoC dies while programming qnm_camnoc_hf, taking the
board down before rootfs:

  Internal error: synchronous external abort: 0000000096001610
    regmap_mmio_read32le+0xc/0xa4
    regmap_update_bits_base+0x64/0x98
    qcom_icc_rpmh_probe+0x44c/0x540

Only install the get_bw() callback for providers that do not program
QoS, i.e. those without a regmap config.  Providers that do program
QoS keep the previous INT_MAX initial votes, so their register
accesses stay safe, and the rest keep the benefit of honouring the
boot-time votes.

Reported-by: Bartosz Golaszewski <brgl@kernel.org>
Fixes: 11a44c6087c6 ("interconnect: qcom: implement get_bw with rpmh_read")
Assisted-by: LLM
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 7f2b5673629b..38c8c3cb9a38 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -310,7 +310,13 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
-	provider->get_bw = qcom_icc_get_bw;
+	/*
+	 * Programming the QoS registers below requires the NoC to be clocked,
+	 * which during probe is only guaranteed by the INT_MAX initial votes
+	 * the interconnect core applies when get_bw() is absent.
+	 */
+	if (!desc->config)
+		provider->get_bw = qcom_icc_get_bw;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
 	provider->xlate_extended = qcom_icc_xlate_extended;
-- 
2.43.0

