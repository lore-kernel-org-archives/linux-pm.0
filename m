Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772208;
	b=sOJnedOUdVi8DgNLwyyxWFUq8a3wsu3W4Em53UhxWK5a7SsEmCaMLeEFv6GqNxJl+bcT
	 psIMNrAhCNy2QNd7+NxhsfqAiD6lijfurmi0c5/svC5zgnYN58R9IicM2CzEGwYvbIDsk
	 eZ9KhhhVZBv0SLa0amP1limGJ+XiSK9ILCx51aoI/bXUP+8dVIE2tj+BBqYPPaKVAjgEw
	 PmxqpbEvvUrRhv8+IDlLeb5W1oYF7j/MYl1XrzR73vAumNbSDcYCSg5CESLh9nMk0Ent7
	 DwA/SH/zc8t2g2kBZ1jxeXlWJD5IzEqwT7FIRh79qcB5rCwwEXxnMqhkSoZOdqwHd+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772208;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=9C1bXdGOKR+PmH+Cqcvj7KCFB3lYGXuYazohqnS6jcc=;
	b=unpP9vobhX2D3uRkmqqdQM1oDzrsvHrtsURLiJ+rAn7MMr7mGvpdxr+j2VcZEazqh9v0
	 ndJDhL8ekSukqJdD2tSkFvIQ69CDEvF6pfLb1ZtK4eKuE4zr0W+poxrXuj2q2zu43vGtC
	 pxk82mkfzfPDKw/7uYwS7es+r7hqt3ngeAwW1YWgR4LGjoiqhMHdimKlqkTNmi/4wG2KR
	 NGO91++vinZqqHTuVPszBuBpXY2JsKDecQXuGId0udBNLWASeocbb+heNky9Nl4q8WoTe
	 peleqP+f2yCkdVVzoae0SDKYi0Gkd6aOj37y9R8wwvE/wvoTcD4jdQDZq5Q0o862fkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	arc=none smtp.remote-ip=91.218.175.27
Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237E606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 06:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A237E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PFeFBO1qDD0bnuEjVR1ASo6qD+B8oZtcUsLJ4dMST/A=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793772201; v=1; x=1794377001;
 b=YO+o9sIy6QpPQk+cmKYsjU8zI+HHhFSf2a3CLbwU6FvSbMiip8Ou/uFHkCaZpMeCF2nx/Pw4
 y7HUJQD9AJo84TkGJQBGRU38YbTz01HBRp7D+Gw68WEko0QLYyAm7H0xtJv2SqQGdoM9I72HI3n
 LFA3nUYW48r+7LGevIlmOSwppCt5W6xztBXs6isPMVf5nA3LybNtKfY3CTG9h6OyGrv0v1DlUXQ
 YJr7XN4MceeDQNklX1KkA44XmX41o6cyI2+xjQ/O+GDvd6FheUcKfcQ2kOE2coAcJ53rVUX5qVa
 accwdmdWfyd1bCZR8qiaatmoRtnWMNbpFfirEz5KxPX5g==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ae5187589c06f8b5;
	Wed, 04 Nov 2026 06:03:21 +0000
X-Mizu-Trace-ID: ae5187589c06f8b5
X-Migadu-Flow: FLOW_OUT
Date: Wed, 4 Nov 2026 14:03:16 +0800
From: Weijie Yuan <kernel@wyuan.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: power: supply: Mark property suffix patterns as
 literals
Message-ID: <cf09a44bf6a9b0926084568b69f35a7b03a3c334.1793771310.git.wy@wyuan.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Weijie Yuan <wy@wyuan.org>

The *_NOW and *_AVG patterns start unclosed emphasis in the power
supply class documentation, producing two docutils warnings.

Render both patterns as inline literals so their wildcard asterisks
are displayed correctly.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---

* Sphinx complains:
Documentation/power/power_supply_class.rst:211: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/power/power_supply_class.rst:211: WARNING: Inline emphasis start-string without end-string. [docutils]

 Documentation/power/power_supply_class.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/power_supply_class.rst b/Documentation/power/power_supply_class.rst
index 0072b41d4d45..f7555239e642 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -209,8 +209,8 @@ TEMP_MAX
 
 TIME_TO_EMPTY_NOW, TIME_TO_EMPTY_AVG
   seconds left for battery to be considered empty
-  (i.e., while battery powers a load). *_NOW is a
-  momentary reading; *_AVG is averaged over a fixed period.
+  (i.e., while battery powers a load). ``*_NOW`` is a
+  momentary reading; ``*_AVG`` is averaged over a fixed period.
 TIME_TO_FULL_NOW, TIME_TO_FULL_AVG
   seconds left for battery to be considered full
   (i.e., while battery is charging). Same now/avg distinction.
-- 
2.56.0.438.g30c3f27cb8

