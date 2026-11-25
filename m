Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578267;
	b=IES5m7OFSIf0J5bMS7B+vfR2vzTjktc7VsNlVJK8A605f27qD6tKzYb7Hg/jcMPyn+jm
	 8GWhR+fTDxej8LLSh9H+0Waw1GLa48xtIGhNb9jioX20+D4an6AgE2z1ir3E9suFUrhcn
	 oVc3AFLwskSu4C8YWu74EfsqGmAV9ISibi8Bwspwuk6ooKBX9EbTHmocjmdhbi/W4OfKd
	 lNGEgMC52JW4rn7kwom7AV7l+G/gzKurvrR+ZBgdoQCPzJaJlloXuLrIIy+QGPyagx80Y
	 x9+PapShSllHTIw/OjjqEnhA18tW7ibTztqITcTXtlfu6TOC6HCyjbW8KgtNc3Onadg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
	b=XKW2G94viwoqbgSQoqIcEMGqQJilfly57/eQ2ntBI3zGyEyey17WYhbyAv2C7DajuHdZ
	 pLfwBa3CYfxWVaZKy2m84e1DJY846pDft/9e3dj3sY6DKxXxKgoY0b6FuvX7atcH/1PYy
	 x1gu98LTZMofv/5Uh2cK7CYEGdJ1q0ZW+zRy0Tjamgd5xZ8n4Wcg2SiOUkEgqeKstKhHj
	 zLiiyTP8mCGqFJsX7L82Kc7PLhNym8ih35wERuZoY2tXDoqglLy20Pm0rrXzc0KdRYyd4
	 YsT4CoeQgpIKTPA/Vyu4S6UD9XNMP0Lsp+2fCHPYp//9jI5uyiOB+luWyvpCb4WFJAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SufE44Nf;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF0606A329
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECF0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SufE44Nf
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so1694995e9.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578265; x=1796183065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
        b=SufE44Nf0iNE9uoja8l5aVwkLELQGBnnQSJnkwjjhyh+2xNjpXzsAoozPYmtygloR8
         XCTUXFjT3+t29S/3sDK7LcWZlA16n33y9wijZwHX6Ju80HJAddDGn4X7BJuoxGfZyLYj
         hkVfLXm4ntm+nwjdWfyzsw22laugJbD+VlTiUS51WFqjYW+ZG6kVM4gFIN/QsaW+Y1fC
         aAU1Ie+c77crPXv7rlxquXOEpdq5iUcbk9Bw/fQXVPCbH8V6mcT5VSFCrAHpkFwLMwqW
         r+ANRdiqb4fabO9ULg0rSB9NuToAJUGV4l4allUCaSpFyElERTRBJNdlXqDf8UMAlmtw
         OvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578265; x=1796183065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
        b=Ba3BTuep52ap9ZbdpeggBECsLIbNOm94C9eRrEHtEZMu8fuJmRQDjGlx1aaOLuwq9V
         UArDFD4MJK1ofgjC7IodQbge1tXtjYiJ90FETHNPdtEJdicyAz7ClaI8wIjC9iNJ6g93
         W7ekYKinNS+fZ1/4XhGRFXy8eNCEI1Ncb4GO0LP9I21gKQyt8M/FLyNhGKht/nc91pFc
         NBt4ykxdfz4IJ9GMiaoXjmGWYMgoHjGIHLSux5wSzKF6lHAHYlx75w+9JukmedqxKujW
         w49OHaHcc7IuSaix9pfebTOIvGxr+oCc0tAJ41fkpeEf+JhOQMuF4coiWzbObvhUteMV
         xWgw==
X-Forwarded-Encrypted: i=1; AL+hErEUbsEFVxmOZEQ2TgrHwtev6OiUfBIMn522PxTER8aRxuGZCBRQRT60s4axjkuovz+FNBaM+cbqXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z80xuJ6G3ATADbrnUcTCxZdgwhxuJDBIoeAI2CB8Wq91fbDmfE0
	8vupwulftd2oVSRzvCJy6ZOTsPZ0T4oL8zyjKnP3NEZmpSd5CNslVrv5
X-Gm-Gg: AZFdTZfcXQhf5WuqGn4l+qltjZAL+uBsCUjigsuz9Db2+TFL1ihuDY5TidL6qS6jXWW
	MArGGIPn6A6rtQ9JY9RWmVRqjx1xEZan1ulayoB3F5Y2akij5Gp1MXH7qJqVG+/7BdB9IijdcvU
	nFySROLp1Yw4dTeIJKo/k4PxnbPdEFhm34uS26J4MG6Rvv46L73IJXoqGnielr/d4lcsQFldRFM
	/vPUFp0U80KeuzAFnmo0xdmgPKJbK68TkyDnMjMlXaacu5TBOIIhRTXxadgDqiwLhTGkkgZeKAK
	Vt4nl4qlwrcOJeZVuRhKOTCTxUPBUn6HqUmq+RMpFlMY/JOSXCF7DMCVrGq6WprnlqnjY1y+0yL
	hhLENP1nXEcaHZZM+2nv+HkveM/uwvuxsSWV1ulWGd5LC8r7pmzcrQCRUm/OhsR3v2k0Sg/0QM6
	usI6kTkeUcv5J69Gz5FwPbnXXXB+UkQ7bkjk4KmgrKsof9ikeeiL02dViWDvVMm8lYCtMnEbkc+
	+Jfg6ZD50Xc2VN7/m80lEOgbHgerMM6nHF9gI34ZGW/8KLlMsxS9GEjpaj0ja6S20GZNBig9Ui6
	2SAa/ap96g/8M4WVLu8Q14TdKQqHwU4rIv+KiuQ=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr314413945e9.12.1795578265228;
        Tue, 24 Nov 2026 19:44:25 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:24 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:06 +0000
Subject: [PATCH v3 10/14] dt-bindings: firmware: qcom,scm: Document
 Halliday SCM
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-halliday-dts-v3-10-5c8311c0b70b@gmail.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1106;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=OQO+LwEeY64jVYcmV4r5bBUUpcSQt6/n4JPVT4Z/sxw=;
 b=ASSSZ1iPRbCJcDXI+svsrzgQJoNbt/i5IYWaxMLqGZRF5nHWw5kJhARXjldkVDjeYGCb2JyQL
 2OZ0LHRj/DeD6xQR3UFBtL7exxUKJQpjnA5HrXZmN3rAlw9HlvDVkc9
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SCM on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 40a267c54b00..fb3da66443ed 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,scm-apq8084
           - qcom,scm-eliza
           - qcom,scm-glymur
+          - qcom,scm-halliday
           - qcom,scm-hawi
           - qcom,scm-ipq4019
           - qcom,scm-ipq5018
@@ -225,6 +226,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-eliza
+                - qcom,scm-halliday
                 - qcom,scm-hawi
                 - qcom,scm-kaanapali
                 - qcom,scm-maili

-- 
2.55.0

