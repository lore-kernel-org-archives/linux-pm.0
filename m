Received: from outbound.ms.icloud.com (ms-2002e-snip4-7.eps.apple.com [57.103.74.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA532BEFF6
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114902; cv=none; b=Vnf0ltEwbYh7qYYYDJpusqIvbP9GcyeNguAgCXYeDWJvcL0MAdXX8LVZDXEgHJNSkuZaMic1GA1peM8OqhaGkNS5nTSHAM4SYl+31g8Ge9Hve7xIRSgK/WhdgoGPuIaL+dV164+3qGOElRkx5ieGG7Obunu4gEeE5JH1z9/WZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114902; c=relaxed/simple;
	bh=usYBqeip2dBJv6lU0uctHLF8zcvXqdaHUpE6zxxT7VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3DAPWVgeST/dVkpoe3MN96i9RMLfHLgnN6oVjYt92Cc3MPnuFLDrnfeH8wg5Mp4XhxMiHR62iaL4zRwu3s3T22yVTmJWa1p0NZkH11taJ4j8/UAyd2wDv3z154iPky9O4AOQ6FTDr0mCAj0jrLB+CUndbaNfQLuDoXjJ0TrmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LYsYs+qO; arc=none smtp.client-ip=57.103.74.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LYsYs+qO"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 97C4B18000E0;
	Mon, 27 Jul 2026 01:14:55 +0000 (UTC)
X-ICL-RepId: 019fa123-a483-7ab7-bd66-c31df4e5e1dd
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgNCFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114899; x=1787706899; bh=BBT7fFRPuQ3q9mMuxefKECo62xh/OLvWDwewqKkovL0=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=LYsYs+qONEm6Anb2dwnDAFj1O+cJFcxeIUwBuim/pxXv0LYSz3LdEZ3FG+6QOfWbFlizdk/2qSsg+DG56eNhbzbb9EZ8LIB/QMbth/PKdUSVzVczCscWmWYopNqLFR5MOciuVuYWMjfVIBHfR6mDTzLhbe+biZU9XIIA8U3x8IbJDKxMwRmJvdUZDursIf9DiAOztX47OxW7h1Dq9wol6lPkMNw5cJsV/yJ6riPCfSfvq6StnIWLnz3BGabJhFS6i8R2uxCi4Q+bfF91zZgstHisGr6/CrN0eDhD+hujt1U/JU7BBE58tE3pPyeltsNZybQ/Dv8e1gkuP944G9Spow==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 6BC2B18000D5;
	Mon, 27 Jul 2026 01:14:52 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v4 11/11] dt-bindings: power: supply: max17042: Allow generic power-supply properties
Date: Sun, 26 Jul 2026 21:13:09 -0400
Message-ID: <20260727011319.621794-12-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX6+hGsenUsrXi
 T2ZCe/RpAEOy99RArE/sRHiVc9+tpClJrjHzQWBNc6fsgbSlyPsZa6SZ4arNbAM7EN0X98oDRtM
 RqNQ8dh9FlIedtjtwA8U/OEk5rFri0iibTl2CgnRvyCS+W3H6TfAwhgHx4gpStqQdDjR7F64VQY
 f9WToT5W/vGDPm/PYbfYg5vFXyNnVvp7UN6eV5O75Do/6036E396Z96GxvPgz4BhA/H6d8u4Sz2
 h0YHDE7qbupj0420p6k0MDrSCZ8xrhLmD43h5OISSXjrP49i5+RlMssCmJjcuV4L9nN0A8Pu+SX
 Y3icWhPFvJydY5qabv31SiV+z5bgjmxRUQsCSW03X3S9u5D5DUuDam5NZsk57k=
X-Authority-Info-Out: v=2.4 cv=G54R0tk5 c=1 sm=1 tr=0 ts=6a66b111
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kTEV35riwKV6YT2q8aQA:9
X-Proofpoint-GUID: JJRJZt4ZRn0m_Mv-bfHBiduB5XgCJYfL
X-Proofpoint-ORIG-GUID: JJRJZt4ZRn0m_Mv-bfHBiduB5XgCJYfL

From: Vincent Cloutier <vincent@cloutier.co>

The MAX17042 family binding references the generic power-supply schema,
but additionalProperties only recognizes properties declared directly by
this schema.

Use unevaluatedProperties so generic properties such as monitored-battery
are accepted while unknown properties remain rejected. Remove the local
power-supplies declaration because it is already inherited from
power-supply.yaml.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 242b33f2bcba..b2e5ddc5c580 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -67,13 +67,11 @@ properties:
       Voltage threshold to report battery as over voltage (in mV).
       Default is not to report over-voltage events.
 
-  power-supplies: true
-
 required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.55.0

