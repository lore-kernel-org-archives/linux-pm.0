Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D230E858;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131246; cv=none; b=TjiWMEvCjM+gi7DhKxcJuIDF/tgN0Vl/LrVRL0NaC64MZLQybGD0oFw4ZP1jv5KZjdtFPuB4b4ryIYFb6pUO1NCHj9oLIpSh8OL/vM2Ay+AuVjO7W+EaBR7hsc5+cRVJYZhIv1zUsDbinr/8zExJQoHhvuCTSa8PmrfJrAsZX/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131246; c=relaxed/simple;
	bh=VnYTl2xNGucZu5hKQXUdNiMFI1wrLrLpS4z/tvCgmnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okyy4cC+QQxz9C6U5JrxtyHDnqriv+ByShq5mpsr2JBbL6bbVtiL6IccAYZcKkFBYICua+3eSZhWyY0fKs+Q53m1jwHTdNDD4im2pTbA7vnbYPbcOl8vEPy1FsvrTrWzUp52lbGY6WC9HscJnwDhse4iOy1X0iXQClkg97rqPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TURKp01b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TURKp01b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FE4CC2BCF4;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792131246;
	bh=VnYTl2xNGucZu5hKQXUdNiMFI1wrLrLpS4z/tvCgmnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TURKp01b4QvcZPvXmIvDq+2aEO4ny+ond5Fuh+rw9Xg1xBXrssDj0bMo0tQ3IcC3Z
	 Xle3SddaYuA4A54RaJT6UbkWVg3wZA3zu5oFz2OuVy90YF2KTcvek+A73cahNRpXOd
	 lUXi+yQuCZKy/SX0MDxIqKHkcsA6NRHnHfZUG8jksDZ/X7Ogj8/PdhjxxKkUpu4QAT
	 NQGTqtQv+R1TwFSgn5Ak+rRdVOtf2cEIeXEYvHZ/Jr821Qaqi6OHCyiUlh6eC7kqTv
	 PAC8AHG+0QST1dAyLsadpzJppvOdS1j8kbOmW20Z5qFx1UYBlnCa+3ZpawYDDifpMT
	 16q3z0EaWwW6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F436CCA462;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Fri, 16 Oct 2026 06:13:51 +0000
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM8350 CPU and LLCC BWMON
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-sm8350-bwmon-v1-1-562fe403bf6b@fromdisposition.org>
References: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
In-Reply-To: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Demeter Barna <me@fromdisposition.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792131248; l=1323;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=2V9EmHIfTwVMPMJXFXv6gNZE4v3VuLK8DjgkO4BKOLI=;
 b=y5pCykklfm0EnCq78CpVFzzoDYExiFxx49wopRYhtgNnoIRsTygTc0FlWYHV5GNPxaPA8exiY
 C+gsLVMGlDsBY9Twsx5Tj68GXlnGl4o96BGcYdH8oF2Gmuilb964UAl
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Reply-To: me@fromdisposition.org

From: Demeter Barna <me@fromdisposition.org>

Document the SM8350 CPU BWMON, compatible with the SDM845 one (v4),
and the LLCC BWMON, compatible with the SC7280 one (v5).

Assisted-by: LLM
Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index f6969910bded..af4a81ca080c 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -41,6 +41,7 @@ properties:
               - qcom,sm6115-cpu-bwmon
               - qcom,sm6350-llcc-bwmon
               - qcom,sm8250-cpu-bwmon
+              - qcom,sm8350-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
               - qcom,sm8650-cpu-bwmon
               - qcom,sm8750-cpu-bwmon
@@ -59,6 +60,7 @@ properties:
               - qcom,shikra-cpu-bwmon
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
+              - qcom,sm8350-llcc-bwmon
               - qcom,sm8550-llcc-bwmon
               - qcom,sm8650-llcc-bwmon
               - qcom,x1e80100-llcc-bwmon

-- 
2.53.0


