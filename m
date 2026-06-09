Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57623CA4A3
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996652; cv=none; b=SkxwFCYSThJpMh9DJ4myAeIXKZ0fU4WJA2O1ZR+NxAj+SL/KGkBzGMG56X8S4VNIwXD9EtuDm+aerZwqMawpD+Vkn9l3d4x6ZNaL/UIgRLzJWrA1B2lvoYU2H7/igwVhv0QJPxtmZN353GlpXLdXqv9QoBZqiWMKfNsZ4HIASTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996652; c=relaxed/simple;
	bh=rr2oZ1w/13xkEtFn95jWcYLYLPHANAYJKyS/SfpAHZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoGBd7HT4De//T+wDGbtfBxDtRsuELh96ZmoV9nG+wcxtDN3cd1PxQ1Qa0wl1B5s3JWq2wfZKKCFfARE+GKspMT6DFgVAuf2DhihKw1hcaPXHZ7JgHR4CqFLnkcyxZTWtKqfmkwQTSNZbLwaS9l0pZdeNXaN01I9EX6zDzts+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UWKLGUsj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuVWZXCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UWKLGUsj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuVWZXCX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rfRo1958700
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 09:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZtY4cJodqYk968em9+13qvIqLOM9Dep75Fwn3YXuts=; b=UWKLGUsjzW5iheXR
	9wFmRrblAm7db32gW6l8ex5yShOAc2rQFcAwSARY4fbtSkvSTCMkBQ8GBJmpt/sP
	cvkNG27h5cN85+peOkk9NrnIqq8hNIhk7IQGfhzbZ59pEXHtXGyg1LqEXRh7Peox
	l+eKug4rDC4B7qjlvDfKaBq74quR/Gc8mpr8fqqNDaN8NsMEZxP3bl4h7/fUkJK6
	GNYwlBN763wOoencF7n92D4OiuOlnfhqzInhUk/2WkMNVnQxCvb+kZRP7cQyRB1J
	KKMWaJwpaP7eivtEMlh5lWzQKAKaGNWWD+z1zf08Yvmr2ANgRY2YTJI4pPEAZufA
	4UXltQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds8rk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:17:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso3593722b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780996650; x=1781601450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZtY4cJodqYk968em9+13qvIqLOM9Dep75Fwn3YXuts=;
        b=DuVWZXCXEEEFbMCqdQcdkMDxTg8FZ6ytYq8/U3K6NXM6KV+IKwt/EyPHkmZD599xgO
         TjoDvP94j7rPIOVHEFfYDMKVPPJEO+ywKjJ1yw6dF0ag/7+gj3qXJjDZoSI/qQbJDVAk
         8HgbEV4SPhS2CF0oxtoJnyrc1u6K9Nd8+/hy4Xp+Gl3leIX5+90m56XVqMQhW23TAOQ1
         ZhcL0pf8CExPyqyszSUGXpGcMdTSVjWGZ19hf/OOGD0BfeTiNMFIfkCBFJqUFbR+dXd8
         cHWnJlQ1i5LPkQNApio0z5+Ed16+GFmiFCEVaaO8dbNpIk6U7Z/AjhT3/F97y0KboMnL
         fEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996650; x=1781601450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VZtY4cJodqYk968em9+13qvIqLOM9Dep75Fwn3YXuts=;
        b=hBiCcIXAH2R66tTueV1HJOPNcSklMn4a8NaynZdXpxkciuwQugakAyZPj3ndjUHhXB
         ohUqd0pJvGEOeFRHIidU4tGb1fyMvCSlNosvehY1PUlaXC5kfQTv9szYKwnLNv/ihfl6
         uyfqLsmY/wE+E2fmnJoho3eRef0lBwEwyzIgfgObmlsVSL1IJsDbZJt+Ig5X61wU8lKO
         sRMuoxiPVvWqZZXwCbwBSfsf5rvlX2NmlgCZWLQNH2MwJ4BpcynHViJXhc5NMGF3zyX2
         GlpJfat6T39wX71JUntU5U6jPcYIURGx/hs75L2Ko6AeE+RnFnJa79PulHO5uDl6E3ok
         dtwQ==
X-Forwarded-Encrypted: i=1; AFNElJ95UQygRk8wo88FKEkEE/H6orctkuOemcIB3UlAf3ZPEfisdoAzbDcFctHQ54TkyVPARoEomTVb2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzyPRdY2ivwweYUc5hR6LcR7H8phP6wTRb+91qYEB5wQu/+Mem
	qKflwunNn0gybLMGhNmHnIuCy/iojWiymSNaoIAKVl0aBUnYvJkcx9jrUjM+EAM3fZyhwAPhmes
	IjQU961HHouSHh0PMhi405FrAE94R3n9nvrypvdeySFY/VBV1jvbwZ1XM5tgybg==
X-Gm-Gg: Acq92OEDViwEwHP6fKQBrTRs6RmF37rU5t7+oNGYu4YrmShC6Iz3Xyzf1zSa5/EY11W
	weSfL+vabObaXnM4p531hskVlfO+BntWn30xjmZXrlFi26MQj2WoqEWGWyTZMxWO70igK+t5EYo
	mobGCiOx9isndSFXAOrOGoKCBQ23zo4xzCLAOyDBVNjQuh0TkgyfNKNPcgtR6+I4CQqDICPw7xH
	M+M2q5+C94Ub9oZU24chEBACo+iCZkDHWKLkYFMSXjpHS3Uy4SjRdj6l6xIKsOsjFfZiknqI8Oo
	br2cwrBBNUogBuF0R+3lHUs9Dwpp3AqQrvgWEfmxQWY9rjO/SUFRls/uFaZSEMhGFIL8Zo33zxE
	6+cSgcvacbEmubeJMLqJyFuGBpprLazjkytNvYSbvceuiNEJG3/+8D5063WoidXEUgZAx
X-Received: by 2002:a05:6a00:148d:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-842b0e661femr20374862b3a.17.1780996649543;
        Tue, 09 Jun 2026 02:17:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:148d:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-842b0e661femr20374824b3a.17.1780996649071;
        Tue, 09 Jun 2026 02:17:29 -0700 (PDT)
Received: from hu-drajpura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm20974879b3a.51.2026.06.09.02.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:17:28 -0700 (PDT)
From: DhruvinRajpura <dhruvin.rajpura@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 14:46:42 +0530
Subject: [PATCH 1/2] bindings: power: supply: qcom,pmic-glink: Document
 thermal-mitigation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-cooling_device_reg-v1-1-e15bddcb0086@qti.qualcomm.com>
References: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
In-Reply-To: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dhruvin.rajpura@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
        jishnu.prakash@oss.qualcomm.com,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780996639; l=1589;
 i=drajpura@qti.qualcomm.com; h=from:subject:message-id;
 bh=hFny+s6/z70haS8msqL480UJfkNA2vaD/64j2s8dXUA=;
 b=gGF9GHjt/HgtSqy6gEEeVtu5qdHS6TURABQkWPbNBSobWXGXSnLwB4pImOJaCW5PUQwNIurze
 eE9aVEifRvYDySMM/NHZxifYSBrX1FYE/CCUcuFZ+k8rs6hAur6edfd
X-Developer-Key: i=drajpura@qti.qualcomm.com; a=ed25519;
 pk=955XCRKkDWtR3Z/wycEd5zolAQt3Q1z7vODzFB/Wn1g=
X-Proofpoint-ORIG-GUID: ufTmhWUDr5aJ3fRnfYQbk7nsiouZQ5ch
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a27da2a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0FHclZ_MPv3-cewW5kAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: ufTmhWUDr5aJ3fRnfYQbk7nsiouZQ5ch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NSBTYWx0ZWRfX7uh2bCKJwc9i
 p9B+0HAWBqdEGBvXcJOX6p1LpundKAX3BBKlSUgFL74HIXwCJK2O9KuN0vmIpnkjQD8GUexsyKZ
 ow/XtbO985knivTgIqxW+uJU4uV3MIBWEOhkdUCt0Hrq/K61CbIRA0GqTXwmr9XbP65XVSaqdOY
 5rJFHHKl9NLtBAn9F7TgqqCexlrZN/dBamwjFH4IdbN3zfqtDw++syrlI+dAC6frkY0vnfT2Y67
 PWLOFocAORKJKUJn3N7pwCrd0g+g3v/yrrGg7u6FG/zLvBnIYpfzMBDCyCwKQwVC7XYHHL88B0k
 F5PVDmjcdy57p/x7vobIjssCemfMiu8lsqsopOs/ILS+LFglE1iikX9F+XBm0mKo8jmnUKXxfjh
 xbCiYf2O340sUyCok6YI9EUSFpqr7J3Gy+UsaYtRCYcmc3xEumnK2iHknuHqmVctAjpL/kskynr
 6gGyp95v837C9WY6rOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090085

From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>

The qcom,thermal-mitigation property allows platforms to define
discrete fast charge current limits used by the thermal framework
to throttle battery charging in response to thermal events.

Document the qcom,thermal-mitigation property to describe the array
of fast charge current limits in microamps that map to thermal
cooling states.

Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index ff01d2f3ee5b..fcb69ebaa7cb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -58,6 +58,16 @@ properties:
       The array should contain a gpio entry for each PMIC Glink connector, in reg order.
       It is defined that GPIO active level means "CC2" or Reversed/Flipped orientation.
 
+  qcom,thermal-mitigation:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of fast charge current limit values for different system thermal
+      mitigation levels. This should be a flat array that denotes the maximum
+      charging current (in uA) for each thermal level. Elements should be listed
+      in monotonically decreasing (non-increasing) order.
+    minItems: 1
+    maxItems: 10
+
   nvmem-cells:
     minItems: 3
     maxItems: 3

-- 
2.34.1

