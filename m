Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800535;
	b=1Ahi22O50dn77TXW/Az/dE2BPpOGGWDx1JWeaSKF1BpcdWH6dNT655dsvT7v2oubjsnL
	 z2H/S8mxEOtqQpBEfcjacuHxeYZKXQLYL5WdfGd5ymlHx9ld9Qke+6RNG4h0kUywJ3erf
	 TwtdCM3YnmmxxNP31lAiX3Um1lk3optupYQNy0gZWAUvRibspk02R09fZEYiS3vapxRo1
	 7kreVEhoHgoVNa29EC0mnr53Ab6KvEX0uZgFfXKXoHOFwizftN+SPxzpaCqzRWNJsKfOy
	 XCzLi08a9Q2cFraHgbmxSrdRVkvVTsLn+hJmbOChRREgqI7lOmUVCGwUSbCTZMFlp1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Jj5Bemd5nS+pl7FU753V5iOjaC1WwI2pF9DcPHXNXDs=;
	b=RH7lvziovML8YvDE4nUCJMfK1wbIwLG8drrF6fFcXfNjI0JSS0abn9bNa/R9QjL2vCDs
	 hW23q81/UsUR7X2dsftu/lohcKdd37CrMUEXIQiJffwG+jpa5Q4BMza7o4N0gkdyxpIiE
	 B3QK2c7zX97ghOVJLpTIG9Mdsxal6E3Q1o6n/KFSWJXx7/8pr6DlLs1iUYBP55anJkU7r
	 72xIL6HVjfTNjx+/+n5p4hs90GaihtTelLJ6QUDH+NLHsfy09lTzw18EBz5adMCOK9gpG
	 7xuW+YG/gwJPG73qgg8VC/xOCv8iR/k9a7JtiGJqnJBJ/k/LfssM47TpZMIK/rWRZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQW4uMB6;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E45606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 03:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E45606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQW4uMB6
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2980715eec.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794800534; x=1795405334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jj5Bemd5nS+pl7FU753V5iOjaC1WwI2pF9DcPHXNXDs=;
        b=UQW4uMB6qvufg7BPcodu3pj335IRsGbJSy4mpLLulh0AZAGSHjaos1vhQMkhPEjIyg
         2AwQGofhs29PZNeFNl9ApMhtqqyP0Xl3mO89mmUuU/8GInPDU3RWkiQw6NQN0JE4a7Bf
         eMTVp5PsY2sr6GaYPdB94H5HbUHHrrCvRX3iiZ3v3s0SccmHe/aifMGEktIkhE0ulfbf
         ejGKMoEvt8oI/zJvtx3nLBCKAX+qMySvAQIKUqsBXsZO4eceA4o8fb1bJUkD9gSUMqFc
         BHP6GJ/tkMtxxxHkFVDq4hhGBP0wYMeN28ObGZiDK8PJOoJeuMOG1s1vSnnmbgaaFXzb
         24UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794800534; x=1795405334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jj5Bemd5nS+pl7FU753V5iOjaC1WwI2pF9DcPHXNXDs=;
        b=OARUUBwueikzhh6lrxCM+Gf8DiefRlxh/+W3KepGRJQUeNlFQwuFrYJ0Wx66vwpMmh
         TP4XIJehEg0qEPQj0JvlQpucZv7VPC2t4eWSIXuOny9u9zzAmsixNl+jKQTfI+g+nVUj
         IwdL0WQxWFq/v/b/ze/zpUvf0mZGIJCbI/cDhfhQ7arBXKPU22M7IQyopNouzVvyGSC2
         rsACoQdGxSWEM8YXtVa78XwMRTzBtR21T6zJz/Yz+RFoweHzCalZxDu8CFRamKRzCkxw
         XrVLExu79z6wCkpNsKE3qhqc33o4MTy2g9C14VhjDmmJYrI1UgwNdxDt4ESd4K+pfeup
         x9OQ==
X-Forwarded-Encrypted: i=1; AL+hErHj/Mh4CX/OAa3DR6bTQzuKYA0t9K9EDiAfODjly5jyhMeMx0wyuN0cOLnvvxg99O2if/KPxRaSQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OrdPcZHEBXA/DFv/BFhRsmC5L5dbEPi4EqQolNxVINZ9bicZd
	dKhjB66kbcpFypDsjVhNPe8TNQXI7MjNnq7XUo2gQYESbrYc6RH4df5y
X-Gm-Gg: AYBFou2tDV004TDOtIsFlXJCskLbrOAizRRU4DeF6q5kp3e8m0UJzSPnp5EQHiQ1w84
	t1R6Y4SgyKdixDFvLC+EfZR4ojr7FPUK8zAFjX4YJGiDRZ6YilCKvnPZkFhPMDPHVoxz8UgW3Rv
	01p84PDKI1cW7Hyih31w9tq2qWOZ+7gB0gG5pqfTS/C7oHuE8RqzN0AwBSjHXD0+Pi2hUnoizQW
	lCKRMKhNS4Bqxe1JptazfeKHazJN9MXUc+5sT/CjppfbLWrA00MKWkrmqZ2SZOPr9kN/3U2ZqPE
	I+UKGjJHazcS7//Ajzn4CIl54ESsd6NomVfFfvcuB6YhPBVgpDXGYxmnXkSUR1u/XZOQv8pZ31p
	RAla5q90Arj/N9MJFo3BYMwiFTfJ8a5EoxtiA9L6tpdxwBFIA9ofSBRap/M03pr7t8Jb/frJ6Xs
	fSsXkurQzkwyE7m4aXWXmvwwSyLkejkPX+0GUyW7x40x2OrSZnZlNfBotOW/XqVbUWblmakxmGa
	jO3eO+FSXjIIVXsVyPuKoCRpwwmGSBU1XJO0Idl9hNMcfP8OwCLAu8+eZFjdWZrN/FGXjd/Z5th
	QeXTbZprOez/lLsNx7KRGVWkjGE=
X-Received: by 2002:a05:7300:d08b:b0:376:6530:248f with SMTP id 5a478bee46e88-3796666dbbcmr9985603eec.24.1794800534161;
        Sun, 15 Nov 2026 19:42:14 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm29784201eec.13.2026.11.15.19.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:42:13 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A4C5B423BF1B; Mon, 16 Nov 2026 10:42:09 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] power: supply: rt9467, rt9471: Escape the asterisk in ABI documentation
Date: Mon, 16 Nov 2026 10:42:00 +0700
Message-ID: <20261116034200.14045-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=bagasdotme@gmail.com; h=from:subject; bh=If+AKBjg8ksMGyVQJierx0Q/P3t4WSCG+rp3XaTW7Po=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDFm/quVufl9xvcO30Gf9lF9Lei7FGh0X8rxn5mjJJvxUi PF7deS1jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzE+yfD/8risI8KkepFHp5p El/PZC06rpB5yGD7q/msXySuZEhxlDMybJ3bqy/+JveQyNvT97/Xrtm4elPa/n8xXw8//aEvk6v BwggA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports docutils warnings:

Documentation/ABI/testing/sysfs-class-power-rt9467:1: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/ABI/testing/sysfs-class-power-rt9471:1: WARNING: Inline emphasis start-string without end-string. [docutils]

Fix them by escaping the asterisk in
/sys/class/power_supply/{rt9467,rt9471}/load_switch.

Fixes: 3f21de6784a654 ("power: supply: rt9467: Use POWER_SUPPLY_PROP_LOAD_SWITCH")
Fixes: cb012fe405f0f4 ("power: supply: rt9471: Use POWER_SUPPLY_PROP_LOAD_SWITCH")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 +-
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index bfbfd78ec1c190..b7690dda168499 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -13,7 +13,7 @@ Description:
 		'Disable' also can help to leave it, but it's more like to
 		abort the action before the device really enter shipping mode.
 
-		Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
+		Note: use /sys/class/power_supply/rt9467-\*/load_switch instead.
 
 		Access: Read, Write
 		Valid values:
diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 90cf94c1cbf6b6..851dfc350bb451 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -11,7 +11,7 @@ Description:
 		mode. 'Disable' also can help to leave it, but it's more like to abort
 		the action before the device really enter shipping mode.
 
-		Note: use /sys/class/power_supply/rt9471-*/load_switch instead.
+		Note: use /sys/class/power_supply/rt9471-\*/load_switch instead.
 
 		Access: Read, Write
 		Valid values:

base-commit: 2138148bf44fd84d3e0a863f0e8cb3627cdcc606
-- 
An old man doll... just what I always wanted! - Clara

