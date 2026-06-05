Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544A377ED4
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685539; cv=none; b=Zn9qKu0DCOCJdDvBpnv4tU4FnrRo/aRx8V04HcQ5sQhDjIY3WSQevpNWkrpYvdOPxPoBSPxPzczk4S7TZ2uhcxNWkCVg5TmlWuP1meGc/e7gqg8fCVJ5BPElT8iMBVHpAmP1mvWGO1pCaxUYBVL8K4AzC+KaeAa5xArmJXmrG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685539; c=relaxed/simple;
	bh=eGLfgooD3RclyjxpuXQAqPJd4HJZjhE/q8GxTYHASdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smMqHGMRom01KAJDeuWBv6GDEfAyJuW7qOPnRbIe1Vac/x7aZSUt9KPlJzJWZRJ1J/uzGUw/fF83A9hKBV+CztwJ+dl8qARiS+Vzng+r6WEbRtifdYIOEsTRdfpoN7Q4fAxN0vdEAzCW3anxzHioB4yzELjGD1mQK5eegTTmnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=LHaCcBZi; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="LHaCcBZi"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158643e538so206782885a.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Jun 2026 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780685536; x=1781290336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xA3NPLxNbbGWMb5I0aDm8qwgxStiKGOjgeHXeyzNN7o=;
        b=LHaCcBZiezh5I+apGY9x380ooaq5qsP7f2XZbLK1A9iou4tcenDrU1OasaVzlSedaC
         +X8dJtLxJORfP4XwRiQwga66Kqeo9PWKxmV8WpvxKR7x3Kp1zi4B+GkbwpEcHJz8rqBO
         eECfRRjWJb8bM4zqV6ZrxSOS3DzVqgHecjFbOOvAijAsm+PoU1zkxdeJNEmNocusXMhn
         2rQ6M8t9vHJjWwjM6+LjXEbK9+q5eqLJtGjotH1naG8EZE6Vf1TqPbQnmty8d3FOY6HO
         WKbOTuqNFN5Mtxi+1d9IJTmpvPCN4txEafa1hDs6xbfNiNtX6QGbNc4vs5GVwBlmx2qW
         pIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685536; x=1781290336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA3NPLxNbbGWMb5I0aDm8qwgxStiKGOjgeHXeyzNN7o=;
        b=R2ZInDharyp+tnHB6ihjwS7BLJUdvB6LFNy0ec0s2I4fyv6bu02nTvxVyGyfCh5f3K
         AaiYlyo5kd9+O7sg96ZpEYU1j0LrMvPcQg19cki/QdyQYWSPpJpK0C1xX/4i3o9BE20d
         CmQdWZgj9P2EZ4zneLa37M45es1YWj71yIpGxVBgnAWXaSu0gsyslOzq9NwsNiYTjSO7
         fD3K0z8A+0qN0x0iEjY5+l4+/iSTx83bwQBagw4rugMKcRCQpS2pbNqWhYYF4yTz4HHd
         ZGkIgC/6nG8uNKlIjSkR8iXUNYterUykhqm/UYqIQR1Xs2vEzBZVBT00QQfzvqRU3IQI
         0acg==
X-Forwarded-Encrypted: i=1; AFNElJ88znR/MHVkR+XRi9qwJUg+w8dpE/HAllTIHNEFZD6xMDhZiicxvS7OPeOdZexyc6Xbp44BASUoDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrUsBXsfUaE2LGQcDfuNOXVLRb1BRwfxMlLCTvWCigyuj+8cV
	n55yWIfzLZ8ROOO2ETQF8HWhhXFyjVwEkXeu111Jfvtf2C+A9xlMKwIknHjxldHZKJA=
X-Gm-Gg: Acq92OF9KsWVsk113isaoe9H8ZF3gAjQJTtVWdJInisSdtShnuuw7rGdubl222br7k7
	6WfMmddRfAwYomiLBEb21KkQ8gyNlWtf7h6QD7NJveUf+CNPmHSsTuNsSjvmfAXymbjULAXeLOV
	GC4Q4XzstYgY65GhmOtjBYMlo8sAw7CKf16UBpFyMNlCJIGNTZqfmccT71CsSp1NU6l1qfd/z8W
	VUf2aQtoDxdp0vqcvJ1SHDdZ9/X2ZvJPMO1mSQhBMOtv1ikulRHQ2foXCsmjctSXEcJvEXhANhf
	bhZBF0H94i+9j3q2mHrErTHduDqqYnD9Tb4qEUtz3kuaR8v8lkW8SftlUILfTzXRIlcPi/BgJsh
	iXfE+mPqjG+kALg2qo1JocufEtFSdiadFwbR0AmEKo2rptMcu/B7Sj+GpqE0y/3xAFsiw0I5g8t
	x/LjPZb+ujvW576qhl1HY83XVL8H0ReXmFeeA8xg==
X-Received: by 2002:a05:620a:440d:b0:915:92bf:560f with SMTP id af79cd13be357-915a9d6bc64mr869842585a.36.1780685535919;
        Fri, 05 Jun 2026 11:52:15 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-915a6935cd8sm480356885a.21.2026.06.05.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 11:52:15 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: testing: reject missing command arguments
Date: Fri,  5 Jun 2026 18:52:06 +0000
Message-ID: <20260605185212.2491144-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal testing debugfs command parser splits commands at ':' and
passes the right-hand side to the command implementation. Commands such
as deltz, tzaddtrip, tzreg, and tzunreg require a zone id, but writing
one of those command names without ':' leaves the argument pointer NULL.

The command implementations parse the id with sscanf(arg, "%d", ...), so
the missing-argument form dereferences a NULL pointer from the debugfs
write path.

Reject missing arguments in tt_command_exec() before calling handlers
that require an id.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/thermal/testing/command.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
index 1159ecea57e7..fbf7ab9729b5 100644
--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -116,18 +116,30 @@ static int tt_command_exec(int index, const char *arg)
 		break;
 
 	case TT_CMD_DELTZ:
+		if (!arg || !*arg)
+			return -EINVAL;
+
 		ret = tt_del_tz(arg);
 		break;
 
 	case TT_CMD_TZADDTRIP:
+		if (!arg || !*arg)
+			return -EINVAL;
+
 		ret = tt_zone_add_trip(arg);
 		break;
 
 	case TT_CMD_TZREG:
+		if (!arg || !*arg)
+			return -EINVAL;
+
 		ret = tt_zone_reg(arg);
 		break;
 
 	case TT_CMD_TZUNREG:
+		if (!arg || !*arg)
+			return -EINVAL;
+
 		ret = tt_zone_unreg(arg);
 		break;
 
-- 
2.43.0

