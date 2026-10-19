Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91D5166D5
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419185; cv=none; b=BqjgBeRJSO4IVoFeJ2xlqXY4W0FOFEi4dgmz2egWE2rOM7YyoP2/lEs1Dviy28UiTjblKOI6AXAa+dCIoatlpSpiItgKNVVJvUAiYCPI03h+HYd0ncbQFWikKu9VDSIzh+QuvIYdreOOLuUh/oTAMbxYV4aTru5U73328Nul5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419185; c=relaxed/simple;
	bh=idgzPl5wpzUwvBNLavY2SQPwQH+NOq9RmLETDxd7+U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=groh2DL5LA4k8iCoY6l0ySmlNcRJysIUP/q4e5/bDUcX0pJFNzA4NlCtp1+f2BphA9OOHTVBYI0ezOeNjARWhMKmoWbBdt+qftDLbxkXGEuo2QRU2neev7xIwx72WbvAcXQ+UkDqTiwrQQjjzNwz7RjXCFtYoYz23khXyztYqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxfSPaft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KCks0ge5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxfSPaft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KCks0ge5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE06so3485302
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zbq8Yt2YxI31tHZSOwBFkW6HvTaHTI4mj1MProlJx80=; b=cxfSPaftt8SgLe9S
	bay6Yn4wW1iPbjHAt0ID4NRSkJu9lzyANTcFwb1Khapqkzhg6P0GJgT1n8KOhVaM
	GRS2+cRl/u4W6W6xG1vw9ok9bzhh+uCltcIabyRzi9UUPfS/l2dHgZKwYLFT6OHl
	u+pBJj1qSAQJXoB9iGiPo+B2pce/h8zpMRWi9IoNW2x23v3EmrzKF2Ndcft1DWCA
	9vqlZZv4Hkgx8nnHoYRsHY24F/dzx6Zzaa0gNaRd3YAz/DlCc+8WjKcah5+b/KNt
	andGAveDjg0xZM8C/7sQO2xqVBhJ45Q5ZKOaoUbbRrUcLjEk5TImxoNh4cfAkcMa
	pZkIRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48hhrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so229705485a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792419182; x=1793023982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zbq8Yt2YxI31tHZSOwBFkW6HvTaHTI4mj1MProlJx80=;
        b=KCks0ge5wHk4MAO72uZ1pkGRTPADjUZZ0Fp8i57K/GFBkXv/04fYuMO+cFoVoLrmG7
         esnl3w1vxj34cH0gfUm8Ah8gV0gM2IK7bo61kldb+RaU5OqRyx6shq6d/Rb0oPoiUqHd
         wq65oBJ+t0C/RWIapqOJOI1ZOw2uEtQK6eZIfd7Vt4IQFoQZwxKZ1o0T8KqXPefJ8S6/
         BwyS7nttQB2dQ/vwQjSDE8CBwGTqfBoqQzKeuGt2CuIfIa9GQohRpPqdSYVrogTu3S0t
         LTcdF4dwGlHTAXVKv8H8p1EhJbvAUWqu2uYqrpia41gw/F2HMxyoUYnzfZ01StmXyctb
         Onlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419182; x=1793023982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zbq8Yt2YxI31tHZSOwBFkW6HvTaHTI4mj1MProlJx80=;
        b=W3Je0SqTAHJ1aU/h05bmEzPx8gFPtbCQU+oW0z0084qtBIwAIijLZnRklzAmyCdsfC
         zUk2mxqCbLnXIrbpq06xsWlUA8SOaqQbxBv+jONmkmodahlbdxtSgupW76llBq7gWI7X
         oFLtd+rXMS8dRe5qMBI7UUWtetGWmFmr4kRckSYWGw0VIsjtwtN1AW5MQ57DhVTWBg8I
         4WaiBoQiOh9QgPdWz02Yr7I98sZQA+QiK6Nht7Qq1eJCwgPJfzDVxxb75WZwCwyXGhq6
         xI4H+gyI0SxGpZsF7WTpQWHxembC4h33ZO+bQsOLV1uxpz0wCsyE5nlzsJrXfycTfm8e
         23JQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmlxsTjUA9O1XlEqf6pv/uH64a5A1+qUFmPYuT4nKe7kY+ZMjYp+WsAKvQ4xqjQMXVUCC6A6A6oQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIje7D7dXWl4seg5FcUqQG+eAtAjF01R8SuT/hlJP7ECfTrUFm1
	HW48aX2nGmGXVZe7pdF8S8ACm9wHJlTiGg+E+HWZrWZFnQrBNu2EcNfimk9l7FKVhUw6NJI58mI
	IJhg3JRI/InHMgZM1fblnpUQYBTVRjJzPQqF0eRxZPznjiiSqmVFzfXA+HTbiYw==
X-Gm-Gg: AYBFou3P1rEdU87nmka3/92HeRlWOOLEbL9E8KhQOKuYzYOumHSwnhCRESMBldNxvKM
	hFOPKXB49QA5/fioVEcg9jB+HnZw9GSGRNz8+LhwimbF2Zclk0hyg8wlmR5Ot1rD1bp4ZqilDn8
	KkKnYI1hVtiVT7/Co4wlACxY5UwMBAchFdCsUr+eWcY2fTjUUuOh7Q7Z3dwgCaK0a+5AprG3anH
	X7L6868ypG+t5LyDM0cSU2S2j6K9aYwDXci4c3lhBYi8ED3cFTGZiEmQP+lm9ASZJ8Vp1XX96iR
	mk0wPyBR3pN3vC3W3iZy8NvRsj4BJdYvqJ+iZvTiUs0Ol/C2QbV6UK9SUSDlqDN0prn+Rvh9NdF
	bY2j4Ge9yi9cl6zKzmuq4VMRfGM5dzwEC25CeLbaOL+Bm5tVeyDl4298Fe6U2BUudMgjY3CU51e
	hLkY+n0OX87wym
X-Received: by 2002:a05:620a:4613:b0:93e:e2ec:3bf with SMTP id af79cd13be357-93f29defe1cmr1269006485a.78.1792419181527;
        Mon, 19 Oct 2026 07:13:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:93e:e2ec:3bf with SMTP id af79cd13be357-93f29defe1cmr1268997485a.78.1792419180910;
        Mon, 19 Oct 2026 07:13:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42ade9sm2015922e87.14.2026.10.19.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:12:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:12:41 +0300
Subject: [PATCH 3/8] interconnect: qcom: icc-rpm: depopulate SMD RPM child
 NoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-msm8998-icc-v1-3-c2da3934b6c8@oss.qualcomm.com>
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
In-Reply-To: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XyLHnw2UNIaQ9sIQUUT8rlJwQ+6O6M0CyqTbcK0TVek=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iVgcZDBtlR5klLPSH5gCveEoco0B6gqZNePP
 pFRKcqC28KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYlYAAKCRCLPIo+Aiko
 1S5jB/41wVjIHEVlUkP6+bYQMrw+IcgvdbmTt23QhLcGxBOdQQ7YDSg4i0UvU1l/wXkn+yGg8nW
 9KD2Eeb3r1vIphr20XJKZPjfkKTbDdet/pwZG3NL8B+Y4wMevQlu2F3MeyIQ1avFVJsXpjCMHoT
 TmtA85jGL1En/Y/DyPI34WIV87BZD9ncPj5qkmZYrAV/0pweUYTCAqmgRiQoSrA6oj5T4pzQr3n
 BLZhv8nDG7SJZtlham2yqJ5+gLJjrR97MV6QzPqn5+OWxiVckR6jNBv4Ti+8O8NYcNFLfPb4m0k
 cWKXl0qvxvy7Tibz5oR8FFlHOKTZH31BZ7ooP78a2jSjPvFY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfX/VsQVCYQYfIj
 l2odHLiSxmiGWyanPtEppznVygOHiEJTNpAC1UPw1ZPEkbbMu2Kq+R+3dIrQbf7Te+fVLXQHbs8
 TTm0cia5C/v9IMOJKzXJ4OdtmWMQwFmfDYeid0WVFTOKozI9gnbc1lE0RgkmFqdJGYFlymb2Z86
 ddOzsYGIQWA/cFEsgHW5lEn34ur+NYGwOS24JeUhE2Phy2SIJu5cF7goj1ecBzaYm7s+tn3eusH
 GYBrYj9LfnLJjub4H4MyQSin+hT37EEgjZw3MDBljc7RP1X/kpyolGZzfRrntr9nkVhJ4dH+xEY
 rGVJqpTUK87+qFzAYaNSGTQ36fHKi0u5VD1mHqeCp6+pzFdA8XG/ptbsXgAdT3Q40vQpIGO+SPc
 Nj51fqUOhZ0ZZUuxN3d67dyWZheENiKxOfw/96Idih++j2h0NmIiM4dAhvnNmeJ2OKZ2atdZjuK
 MNoDFnYRBNG+T7aV/Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfXzYXT4ps4OMJe
 P9E4Rz0UcRA4Lo6I72pZJBLbgLPP/PVVL+MLTaQhZbkLqFVOaOEuyDaHHInEEbhbagsfKt3nayc
 gsCkpOmQ53kKcttm5bYvAzbgXV3wev8=
X-Proofpoint-ORIG-GUID: QTQJ2k60wx8Ztjz8cO3tYuc06G6QJ2B-
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad6256e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2lEEjgNiNA8PrC-_0tcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: QTQJ2k60wx8Ztjz8cO3tYuc06G6QJ2B-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190056

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

qnoc_probe() creates the child NoC devices (the QCM2290 and SM6115
virtual NoCs, the MSM8939 SNoC MM and the MSM8998 MMSS AHB NoC) with
of_platform_populate(), but nothing ever removes them. Unbinding the
parent NoC therefore leaves the children bound, although they live in
the parent's register space and use the parent's regmap, which devres
frees together with the parent. Binding the parent again does not
recreate them either, as their DT nodes are still marked as populated,
so they keep running with the state of the previous parent instance.

Populate the children with devm_of_platform_populate() and depopulate
them at the start of qnoc_remove(), so that they go away before the
provider they depend on. Leaving it to devres alone would only remove
them after qnoc_remove() has already torn the parent provider down.

Fixes: e39bf2972c6e ("interconnect: icc-rpm: Support child NoC device probe")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6f325789a96e..ddc7df31ed33 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -677,7 +677,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	/* Populate child NoC devices if any */
 	if (of_get_child_count(dev->of_node) > 0) {
-		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+		ret = devm_of_platform_populate(dev);
 		if (ret)
 			goto err_deregister_provider;
 	}
@@ -699,6 +699,7 @@ void qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
+	devm_of_platform_depopulate(&pdev->dev);
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
 	clk_disable_unprepare(qp->bus_clk);

-- 
2.47.3

