Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2953FFADB
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768884; cv=none; b=lhijikIxn+ygaMfkPw0PcAEUG9ObIQCbV5gRkLkLgExkcoTZpmmBeBwC3yB8E2XNO7qslcPxQs2Lt1zIlkS0lW6ItaRdUw/MZtpdRqBGCVASnRY2ZuHC5eklHkQDKf6cUkh9bC34cw3kG15y+HO3f8LzsGkxESDslIYexsWf5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768884; c=relaxed/simple;
	bh=jyTFGQNuJYDeqEOF9acNm3SghnFKZKEJruoHnHRlxUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxlR9XYsaD4bGKflbR1kxBzwkgg5aqVMhhCns9+yk5cxzB2MSgRwziXWPKBckCOc4tsTGsi/DH0/DR9Mi4P5AnifJJEWa7Ok1DhPnM/xe4Ogie0CD+hHuT7mlkxdssWeOtXtSzVz/zsxTvuxd4NxWWkwLcaJiS/YK/BjRUCp2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PPeFw+1i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDnypQ8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPeFw+1i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDnypQ8o"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeUZ13048536
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZTI9rMPHkHzypbPrqZDsxdlgYSjaGzo8RGPBYAYLgmI=; b=PPeFw+1iqoK7i4yD
	fpYlsdG3ljxy+3sh4dPRJHCnF1kZZGq0pbTpOg6NpRdQnSQnalBmZl2m4VZwwo1W
	MfzxtHAegc/+9SunKU+Yza9G09LpF1+4WTvkFp276pddt5T/Ffest7Agvw+WrGVK
	Qz/pH7Opwlpwx6PHf7TVBEmoBJiyXGRD+YRmn0crjUbP+XnTIxB3lpheVxqZM7oE
	eBntI/3hF1xM5qoKqAznBEJJKBoHgbh1TQNYfKaO/a9SXzL86zUNhyALPAU6FvYI
	P0CUSed9YbKmaj4JA5KN/+HqBZgNFHcZlK6KOCQg0nu3UFAGQ5BmyxunGVcpTB7T
	9JV9Sg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5492thdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so5910420a91.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778768880; x=1779373680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTI9rMPHkHzypbPrqZDsxdlgYSjaGzo8RGPBYAYLgmI=;
        b=TDnypQ8obk5EeBGwP7HCeAc49QoTJIEMYjJspS4+Bpf11VvWhnmIfQ8Yf1Gvlb7llf
         uVakMgSyUeVE/C0HvWlLSn/ccexQbcRVvkr/rwhCBYA8kM9BOfXKWA6TJ7cVzE1HT2rJ
         s/B/1CdAIbvrSWrBsWm1pHQzsf9UkNiUe60rsql6Ki+FWYINK/9j//tbFDZs7GvhpwwI
         aad3NHogekUZaoWqUV7dcd/iXsmXElxMoQcMhzRKPaQPfemHl1KeubwHfowe5I6mkGYL
         dDo3aulxXdrQ0iM8yNjQU+CqVExsfclXBhhAYu122jUoj1ZFqOH7CwiO1sWOOAJj9zqL
         xXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768880; x=1779373680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTI9rMPHkHzypbPrqZDsxdlgYSjaGzo8RGPBYAYLgmI=;
        b=kGTjY2ZpeP8WNXgk/5vfk7FHvvxI8ZF04Dz4rD5T4fLqr1s6IujfwKNTk7mgz1XI7E
         0Y7aH1zhpKee2a5pYBI/UjG6p5a6n1p15x3qHAKkLMPNag7ALsaqu+nFPvtsg7MSbrGo
         OB+Hm8AQL+0IiFQKe6UUVcBZI2MDB2ZMXvBGfKRIAcTU4vjE64pbYwuoD+zdUxuE39gA
         mA7p6d4/46uC+Nc3BVHLh24+CwoA8/hFrxYA5iH9F6u0O4OE1U0T5YkSSANoL0orXjn3
         0CjEtxwzqDaBAdBPPDIjqU5t9dOSehL9mvWpjyxbcxWnGeGBUWFz3EfAkE3T4a4RN7Tc
         6NDA==
X-Gm-Message-State: AOJu0YxtmIRRbETfthXBfO50zx4K8y/FsBYfRaC8Dk7kvZfqqhf0omMi
	yALHno3WUxWb0FVRrlaGFq+jYHx9CydXfcatw2xcyqnL4SE2B62NNY+GCuv96Fj0e1E/mlVwyyl
	jf/B+ZFJvRvIBLLctqKkePgpneO2KR4Phq5+ZKBn9FY8/7EytDjZvVbD+j1ahZ+9TrWon9g==
X-Gm-Gg: Acq92OFIg/Ew/bKDgLsBRDjenkhSdpfIvp+VNvI2cKIyOpaEBXXPwpHkPQJju2uQBwo
	M6VJv1sxp4/PTjuOYdscYbB+ViI5KKTuBzhnS3klA7pCnXViWFRSF9ZfAD2rIcRis9je+lJbdKV
	8IL/bTjNDmEaoFdRCOsw+pdlIqInXam2mbKzQAutvePiQXRmCg7jF9qssoexZFgUOIPBiJo+97H
	slHoM9eWSXosE+Bk2++hDrqDF/3XxYVWxW0EXPvWW4ZSgFncxUNW+AzI6/l7J1tyTO04kiuKHxP
	YRGObpZWNVgeBtyCRH3qw7TEw6xCRP6LWkXm7Nbvpqau7FoLKwCziE/W4I/uUfR8CEV0/rWttjI
	CWWYeS5aO4Y4CCvE/fw+iQiRZP5ErUQP7ncjvNyqtwuAK5orCI/ubrgrimA==
X-Received: by 2002:a17:903:2b0e:b0:2b4:689a:e411 with SMTP id d9443c01a7336-2bd275c658bmr90014255ad.22.1778768879588;
        Thu, 14 May 2026 07:27:59 -0700 (PDT)
X-Received: by 2002:a17:903:2b0e:b0:2b4:689a:e411 with SMTP id d9443c01a7336-2bd275c658bmr90013575ad.22.1778768878890;
        Thu, 14 May 2026 07:27:58 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm28566485ad.27.2026.05.14.07.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:27:58 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 14 May 2026 19:55:47 +0530
Subject: [PATCH v22 06/13] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-arm-psci-system_reset2-vendor-reboots-v22-6-28a5bde07483@oss.qualcomm.com>
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
In-Reply-To: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778768806; l=2550;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jyTFGQNuJYDeqEOF9acNm3SghnFKZKEJruoHnHRlxUU=;
 b=nou4cMkQGTWvLWiMi0xLAiR5Ug05Cqvd2yNDa5Czcy0sg0oQS4mbWoXgsTyUQkZGu/yUH68ck
 NEZsvAztiXxCcsCVfzuUP+ujvrxuvi6T/yc1+H1QmvujhSyFKS83E8u
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: HRdLoDHLH5wkEs1e9GyFDCIHEvyj6f1Y
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a05dbf1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Z1E3qa2j_4PWJv3PNLYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HRdLoDHLH5wkEs1e9GyFDCIHEvyj6f1Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0NiBTYWx0ZWRfX7HzmZuaE3sFx
 dnBcktiHqvcqrkBBOHAGoqjdkO/EmX3hJvTT62DVM2Z4w8hF2GSoAsmfo2pe4O92OdfcnLCRFDJ
 D9vRkldU6YIyYoo+paJ28HNErRqiPxw7R3ikH8YiwgNljNoKBrk0gqxRJTPdeJWsSXsbCkomvRO
 fIW4vYyU9K5miAHhtTazgT5al+hQ7oSsZkemh0fBOyiQwOHynQ5+N6b1CAhei7NsYq9SCvRAwmv
 DFuc6ZbLu3G1pz0H7D6B0x3XgeHE55GfA7CslOKN+OzC3vG0TroOnjv7qgAqT9ve+kl2TTm9zQk
 LG1k3TWwoU6nGT6MCGGxPNRIplvC5ibG6Jf8+K9LL2qoTN7Czrh8f8ehnJU1T5DdEwfvgMogeOf
 lJ6YzDDWMxqiO5FYOFt/ifSQJ9u8otSO1INyrb6X0jry1WR74DWAkk4DoCSiX520/y1M1EYtOe3
 YVbVhYb+SUcfRR0UpGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140146

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 6e2e0c551841111fbb0aa8c0951dca411b94035c..5fdcbf331ea5620363638feb6f8105427a87c00f 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,26 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 1
+        maxItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx is the
+          name of the magic reboot mode, type corresponds to the reset_type
+          and the values should be provided as per the PSCI SYSTEM_RESET2
+          specs. The cookie value is optional and defaulted to zero.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +157,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -260,4 +289,17 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reboot-mode {
+        mode-edl = <0x80000000 1>;
+        mode-bootloader = <0x80010001 2>;
+      };
+    };
 ...

-- 
2.34.1

