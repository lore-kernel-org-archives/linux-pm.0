Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C24405C57;
	Thu, 11 Jun 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182970; cv=none; b=hwNd/Xhby3I5jSfiqOfceVVfSEc8otanfUoMRcbBbgXaL7Yn4Uv0oFyOeH3USyn9P5WiqlCyPNxv4xX4a5nc8ntoBF6LgKBITs8S9HRBmV7VLi0RmYDH4vaFfx7c6vWM0o3IdbspIgzJxyf+LsbaJrRVG89NFPOQ47Q+00UJxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182970; c=relaxed/simple;
	bh=qA7UuvWEc9wfI4VDg+VBSs9Ya4JVQdQQYm0544vMyrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPJyAF+7ly5qJEAkNFopZmvQZ0k4Ug5iuqmjTSINeogS17ZYIM5nC0mxHb5gDRGGj5DbXle/OZgu8j9C1qLYjVHY03BRaiR63FqmTVlrAgw6z43HdTRjsIYNjWs4KXratoO7de3bnoDiDnrHaaGPks8SZb1QqJHvySdz/XISY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344631F00893;
	Thu, 11 Jun 2026 13:02:45 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 6/9] dt-bindings: firmware: arm,scmi: Document arm,clock-domain
Date: Thu, 11 Jun 2026 15:02:10 +0200
Message-ID: <bb65a93531125757f3c4beb47cd7891a1a7492d9.1781171706.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781171705.git.geert+renesas@glider.be>
References: <cover.1781171705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Power management of on-SoC modules is typically handled through two
methods: module power control and module clock gating.  The former is
exposed as an SCMI power domain, the latter as an SCMI clock.

Document the new arm,clock-domain property, to link the SCMI power domain
provider to the clock domain provider that is responsible for module
clock gating.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index d06cca9273c483c0..18e4da3884c4c12e 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -174,6 +174,13 @@ properties:
       '#power-domain-cells':
         const: 1
 
+      arm,clock-domain:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          When PM domain consumer devices are also part of a clock domain, this
+          property should be a reference to the SCMI clock protocol node for
+          the power management clocks in the clock domain.
+
     required:
       - '#power-domain-cells'
 
-- 
2.43.0

