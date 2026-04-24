Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEC364954;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045656; cv=none; b=V4E7uTgfShy028LRxkzOYbNKLNnfKcPsJDXEHqsXdjKV4gSlQlxRN4lCr964MayE2r1Q7ineL/i1bdMZIgYtjBMxGCbtJW+OAxgSzMo2ZvrHTz3H1o6Y6ieCdfC9dBZY8VKv22lEHKKPtd1QmI7iH4ZkBHkQ7fLNkmaH2wniyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045656; c=relaxed/simple;
	bh=elZM1nnUL8tGPNLZHklCcbm+/PN5OiNdRt/TWuoll84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEeVpLXhqPLE6e0kSbfMVpJ7tf5/K84SdoXaQZ76HQDNv9+bule8yXHX5BbS5LouAFYDPi05VzsB7GSvBZzPCzWyn0PcfIvxbMDuF670v77yQrJQVCSZhhwT297L7VDty71QVW+sG2JGgoDhM3CLtywUtCImHVI4EB8SWg9PfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGcu+pf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGcu+pf/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2538CC2BCB7;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045656;
	bh=elZM1nnUL8tGPNLZHklCcbm+/PN5OiNdRt/TWuoll84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rGcu+pf/PBo8iw45HPRBBM2kdNMRjzLBgsEsWKWQaY/8EOpZghSKD7JDXzslsfcvq
	 EEeE6J4LgMYu9g630TceePMEGtd1L5PKmcVE+JiPF2/K6sZnIgfoInJhtBgnjbdQO7
	 eEAMesjfEcxYyB+NuyDUErB8MhgdVPvpfBvcS26Q4Kd2IG1z25ZQXcb6c7wG+SSl+M
	 N5MpvnNUJ609oW5o6sdwYI5TydgZz8YKxL1TH86vZNS+kzFgXKVMOH4LO47h5lpUqq
	 u7EDeSkgrqJr+Zj71MvW7HTUo9sYpbnx8GQ90txQlfk7zfLNPPUfdOmgUf9ft8HnPj
	 ELglw3Do02xgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D106FED3EF;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 17:45:13 +0200
Subject: [PATCH v5 5/8] arm64: dts: amlogic: t7: Add cooling cells to all
 CPUs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-add-thermal-t7-vim4-v5-5-9040ca36afe2@aliel.fr>
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
In-Reply-To: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=XrCMAL0ahuPAin/Bi3StAQs4xZcZCs3qAU91y4l1Ouo=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brCf2ff0zY+PFZt2VQqo0w+9I8jojUB/Lynx3vlDsyf
 Fqbnq/dUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAExEJJmR4XpcoiXL1oUxNqyZ
 8n92z+s+fftZ1xwDjjM3L9nOz1h4fj0jw4Pzhqs8bmx5/4oxsdFzxW3vrbpZlwU3r/azeVJ664r
 TA0YA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add #cooling-cells = <2> to all CPU nodes (both little and big cluster)
to allow them to be used as cooling devices in thermal zone mappings.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 560c9dce35266..7aec65f036a9c 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -63,6 +63,7 @@ cpu100: cpu@100 {
 			i-cache-size = <0x8000>;
 			i-cache-sets = <32>;
 			next-level-cache = <&l2_cache_l>;
+			#cooling-cells = <2>;
 		};
 
 		cpu101: cpu@101 {
@@ -77,6 +78,7 @@ cpu101: cpu@101 {
 			i-cache-size = <0x8000>;
 			i-cache-sets = <32>;
 			next-level-cache = <&l2_cache_l>;
+			#cooling-cells = <2>;
 		};
 
 		cpu102: cpu@102 {
@@ -91,6 +93,7 @@ cpu102: cpu@102 {
 			i-cache-size = <0x8000>;
 			i-cache-sets = <32>;
 			next-level-cache = <&l2_cache_l>;
+			#cooling-cells = <2>;
 		};
 
 		cpu103: cpu@103 {
@@ -105,6 +108,7 @@ cpu103: cpu@103 {
 			i-cache-size = <0x8000>;
 			i-cache-sets = <32>;
 			next-level-cache = <&l2_cache_l>;
+			#cooling-cells = <2>;
 		};
 
 		cpu0: cpu@0 {
@@ -119,6 +123,7 @@ cpu0: cpu@0 {
 			i-cache-size = <0x10000>;
 			i-cache-sets = <64>;
 			next-level-cache = <&l2_cache_b>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -133,6 +138,7 @@ cpu1: cpu@1 {
 			i-cache-size = <0x10000>;
 			i-cache-sets = <64>;
 			next-level-cache = <&l2_cache_b>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -147,6 +153,7 @@ cpu2: cpu@2 {
 			i-cache-size = <0x10000>;
 			i-cache-sets = <64>;
 			next-level-cache = <&l2_cache_b>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -161,6 +168,7 @@ cpu3: cpu@3 {
 			i-cache-size = <0x10000>;
 			i-cache-sets = <64>;
 			next-level-cache = <&l2_cache_b>;
+			#cooling-cells = <2>;
 		};
 
 		l2_cache_l: l2-cache-cluster0 {

-- 
2.49.0


