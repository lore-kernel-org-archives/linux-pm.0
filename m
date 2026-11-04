Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772220;
	b=wfqRTi3s8WFRb4pFD7C4C+C6OI37pa0JQSjvhVyA0Zt+P/vPRjT1LmFlqphkXPhcAwQ7
	 UtfY5CzTvfbO4ihzL0amsecvb+cEZz6MuX3A/OV8WPy1IYe2yJkwQmLllZ4sv4nXLAN9L
	 tCoXZ9S/hZmgTSrJbkZztyL2CQYc4UeOefYsudM1+jiq+gud1YeyxSOzDmuBo4HGWgRD6
	 pZ/L3cU2cR+XbKY9k4dqSQT92Q9X1Y7TmQH42PjxHj/dtuIzZuf8w9MFfpcf4AUvu60G6
	 R5o82reypNORJyATwNv0Hdnkv/N/NxJuzYiTM5WVXzLBYSjYtBA9roZmAhOTmzkS8gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772220;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=oJdaoXQy0/EociQacg1JYrKan8zsfdKLE8lvsvzxYko=;
	b=fw024wULoGJ5dvW9gRDEwe/Fs11QStPJctyiiuN75rXUSKMdcq0GZw/oAnmNyCuTbBRY
	 IBEQqohhYmJAy1aJTSUlMMQ/QdpSMeYFm8gjkV8ur2GX6nLbMccZwbDPxdhSW+DAc/R3Q
	 13Ru65B0W3z/38Nz740/n7AYSQELX/0wjbkHqIqwSw6Mwc8brLGlwtB8CcRsElSTdrdp8
	 n1YqmwyZdL6w0+zxQABu2nDODaLPph/Y2mTP9hVseZeqLg9CjJRqCwVKaUWG0n9espZtR
	 vU39lEPXIWOJj/MouwTw+P/bKhNdbIFVyyuavAkHecvLkBoMiESxdwWjR5z43eFp05w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=myaznaBl;
	arc=none smtp.remote-ip=95.215.58.157
Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76C606A329
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 06:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C76C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=myaznaBl
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NGIoOiZhsQ+tUdmKZIOEJBAFqqRsjnM3WeSbYqIv1Wg=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793772217; v=1; x=1794377017;
 b=myaznaBlyYPaCSODhv3ZMdHwgqbS9RFZFOi7bIy7CJU9WjAo7bq07d0i+EhjBrj2jrLqasZ+
 8Mc8e6rk2oC0VPc0Ni2kUKgNNGrjBPBGR2EXHr7Q/vzvUCmrTf0BazHrhXL9WYrLfOBeY3oXaYi
 KVqVoepmhYlygr4rfG+UFG+m1tCfLBCgdzaIGDa19MV2h8L1p8k9H/RmTaCt7V3uHl95q7vGPhb
 yRlrXutjwmzz3PFP1aTMG0Ia41P4MjmYwIzmrYRAQWRd+YbURJyRei5mrIL8D62HM+Io5YiHye2
 lzk20kKIFJIQ5iakuiG7TIMkGtFG4n1NjNOUBbu9d7Sag==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 91f073fbf216ee0e;
	Wed, 04 Nov 2026 06:03:37 +0000
X-Mizu-Trace-ID: 91f073fbf216ee0e
X-Migadu-Flow: FLOW_OUT
Date: Wed, 4 Nov 2026 14:03:33 +0800
From: Weijie Yuan <kernel@wyuan.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ABI: power: supply: Mark load-switch paths as literals
Message-ID: <0c95ea265109a1af250f4156c92ea5ae313cced6.1793771310.git.wy@wyuan.org>
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

The load_switch paths in the RT9467 and RT9471 ABI descriptions
contain wildcard asterisks that docutils interprets as unclosed
emphasis when generating the ABI documentation.

Wrap the paths in inline literals while preserving the What entries.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---

* Sphinx complains:
Documentation/ABI/testing/sysfs-class-power-rt9467:1: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/ABI/testing/sysfs-class-power-rt9471:1: WARNING: Inline emphasis start-string without end-string. [docutils]

 Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 +-
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index bfbfd78ec1c1..1c0f1d532edd 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -13,7 +13,7 @@ Description:
 		'Disable' also can help to leave it, but it's more like to
 		abort the action before the device really enter shipping mode.
 
-		Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
+		Note: use ``/sys/class/power_supply/rt9467-*/load_switch`` instead.
 
 		Access: Read, Write
 		Valid values:
diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 90cf94c1cbf6..5745303fcc57 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -11,7 +11,7 @@ Description:
 		mode. 'Disable' also can help to leave it, but it's more like to abort
 		the action before the device really enter shipping mode.
 
-		Note: use /sys/class/power_supply/rt9471-*/load_switch instead.
+		Note: use ``/sys/class/power_supply/rt9471-*/load_switch`` instead.
 
 		Access: Read, Write
 		Valid values:
-- 
2.56.0.438.g30c3f27cb8

