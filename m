Received: from outbound.qs.icloud.com (qs-2002h-snip4-8.eps.apple.com [57.103.87.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BD46EF61
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660381; cv=none; b=tem1BByXt2aEpRaHYCS5Y2rxcp3QiR/XuaxLzY32Y1ybwmaokfWODtc50aVYfTSX7BnWmhTDkfI915GK9HWHCNwirC1BvH9Cyz+VGIBUKqNJKu20pXZbuqlnZ10OUO4osYmlFZDn/wwTXa9fEwfJmjM1+omBgAwKisVLnPbvE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660381; c=relaxed/simple;
	bh=TqO+Qg6fzXhTG3QjMKM/vT1RCeMQLmbqcWW1YTZv9Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5jWcnnSEjDUou64gvK3PpKewMzXhfRSiSFOhr+4CdVV0N9z5I6IfroxdM8KVhJUNJnouCZ2b7GN+tX+vqW6fJ0rXP+AAebhqbO6Tr45uFLCPyTxwAwVpax/GSKXO6vWfhJu2ol4Hv0S9H9yYWNYGv2x9CkvtV55Yvbpd25Xm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=YsoktTjH; arc=none smtp.client-ip=57.103.87.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="YsoktTjH"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id 8FD0C18004DA;
	Tue, 21 Jul 2026 18:59:36 +0000 (UTC)
X-ICL-RepId: 019f860c-3bbb-7f77-a49f-59923bb33e52
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwBSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEEIQAZUB18cRAlPBlsaXh8GUBZQCFkfHBNVF0YZXg5AMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784660379; x=1787252379; bh=Ws336SOk57oXBc2JW7cgPs4vQiZSL0GtxyqE7/bvjh8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=YsoktTjHCXGkPgIt2HZCUzYzPD5zpsp6OO33jpfxcNA6Vq/82Twl//L8ogzlJwKurOjCDubUXTcluBlKExsuuAtoXzRzTF8LqMwcnSoAswpF6hydDL9arLK+u1i1tzoAOec4j1x+CaRtKEfDxHVIv+ehK2xLpxiHKIB+JtmNr1AtCcmrL6R0IPUjRKSImf1B/RC02iSzvyjWKrgnH7XjcwfUdRoIU3T7DLFJi3pDGvZdBFcZO1aSQ0Lf2gHw3YyEclgnujrPcRDSqzOBP61xyn6gWko2B7Qpa7woUbyt6alB3lS5esV6TT3TwNbh64WWc/XWrzLrsE3JSR7l9zffbA==
Received: from bigre.localdomain (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id 894A51800140;
	Tue, 21 Jul 2026 18:59:35 +0000 (UTC)
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
Subject: [PATCH v3 4/4] dt-bindings: power: supply: max17042: Allow monitored-battery
Date: Tue, 21 Jul 2026 14:57:36 -0400
Message-ID: <20260721185904.40756-5-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721185904.40756-1-vincent.cloutier@icloud.com>
References: <20260721185904.40756-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2gSQn9XY-NOcZmRlnxZWXXRGdQ0GVD8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5OSBTYWx0ZWRfX3EV8Ro142D7V
 xD6FVKQOuM8BmXL67SnloFdVl0nZ5D7Ofqm/PKZh6pBarepI35eB+3oValfWsAmD5n24CucTxMb
 qQRV2Rb+E5j6DnWxsjNDL+sB3gn2AVGhaUCauhl3/t24mkGC2dLtoeB+r+bZOWAdQQYK4gtrYcu
 29ueoW2whA3vZxZa8cakp1XlunlnMPsqhJUqd1yQr82P/ahOaQ0q1nGICUkZRv3kXEGwBavxO0P
 Kud/0B2zaU/bDP75v+5Nk7WpA6t17Y/husbtiE4ER3YY1goIuH7z17tY/FvR8M+72qaHRoQD12K
 3v7WFMCcG/lyiuZmroH
X-Proofpoint-GUID: 2gSQn9XY-NOcZmRlnxZWXXRGdQ0GVD8l

From: Vincent Cloutier <vincent@cloutier.co>

The MAX17042 family binding references the generic power-supply schema,
but additionalProperties only recognizes properties declared directly by
this schema.

Use unevaluatedProperties so properties inherited from power-supply.yaml,
including monitored-battery, are allowed while unknown properties remain
rejected.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 242b33f2bcba..395253ca7835 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -73,7 +73,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.55.0

