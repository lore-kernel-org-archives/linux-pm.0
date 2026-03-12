Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31B3FE66A
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338051; cv=none; b=FFNjSX0H3hio152jH5ZqUzvKo6aHLiCsOwp/BnlMcO+PzGZK1rWZUWWUi5+xbPCvI3qeAYQWCfQp5ELenT/0n/F8ggzNXe7I0ZH+zslk9TBk8LKO1IxVWOO6HzlpgZpB8kDP+VUrQ1Z7hiqxqVfEKRjjBe68RSHToDK0esHHTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338051; c=relaxed/simple;
	bh=JCTBH7GXPbxvcv4uKgjSOwbR68uwRtHYauKTbfhWfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXmK9zbB/eqgQtVSMT1fpMI/xsad3zCZyG+sgjlRCWHkZh0BCFlGXMYZ4WMphGAakQFd0v5eXDSEAobubR1VIR9siFJL3barKlbq+qm5lsxy0e3cjVK0PTNkJRKjA1NwdnHH9Q2Q9Jnx2AubgaDtWzwg43DeX0YiU8cILvV533s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsczDYEn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsczDYEn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae41544dcfso15473025ad.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338049; x=1773942849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUkJl4DF7APJYPjD474UUxiLiC7WbxzdLnKNmRAWUWg=;
        b=QsczDYEnpqjOeM9qM7T4bSWbvkCrmkOGQMkWci28R5R3WswZiQSf3YDXOxeu9fvZjp
         juyksWSwnKJC9yutWn2HT0oVGj0be2MUBrKjwJbNShZgq8g8jjB1dNvT8FmlzeIGuoI1
         gt5J+YoRpcE/BI9jcF2HejhKGZl0NQxlG40g8+Ru6C3UsHn9rU0hM/wp+WxWB4NcoCTJ
         m2awI8W9mX2SMUOwsTmT7ce46SE9alITjX0kogwYkPGnLemYLehUHAKsKt4bM679dWVt
         9IzwOXJmH0/VpJ1xVVWKCviafDGj8/PNQSmtg2PllqVwsKG19MmhSZwsq4z7LyYFFKTs
         KEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338049; x=1773942849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uUkJl4DF7APJYPjD474UUxiLiC7WbxzdLnKNmRAWUWg=;
        b=xTICudn03lkn0ivQIy1NB/iLRe6ylqu7ahPVS31SpD/BAO0X52GkgeejcxRPh64m8X
         SN+r1hvABj5d6+7iCmiEibtHu5elzyMZtUmNSMkteiiaI7miJa7COKYzucdpRQ7qo3Wr
         sK1ofxNWiQCAyoe/mzCE0SlryEZ1r1d9FsbNO8kQxn9dOhkTvw8w9iv5k25WlQFf52ew
         a7KDTKCJkCKXY9EU9Kq3qYPOlPe5dk63AEbEB2zrZNmiZSa2l/QzDUJwiN6WH5trqj3e
         RCb7FylIFhjDv+VeRyx6rvYSHAaoWAjRzZZjTmEtdqNti4hNM7XOsWKxoxdmTUgdlLUa
         TZhg==
X-Forwarded-Encrypted: i=1; AJvYcCXRsiJva6IW1g80rbn4xZ1lJuj6+80ghwXoLc8aaeb3ubVEfuCgU58OXchSsIvz60mnTDaMfS+grg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMtcldgXRwClyh1+W9qKLesw6V4aBbmKE+6ff8unrQouvy/b6
	n/vvT92B9+45yiE6awYK8L+AgqYG4BB4Ba4vkt2N62iDV6ljZDeSpoTe
X-Gm-Gg: ATEYQzw89CDfW9rBat2P/VdUW1onxiLKwWPDkFd5SuAgF01PZ1dGhseqCDjreifm43/
	d5e5dFrqU1AjwL52Bh5CGIyoTwQBlffcaFIIoFqEC2k5uEoXwh5ovYYGl93Y4pEqAPr8jUrRbcz
	6N0t0pWkKRLGNjZ+2mG7kNORjYMk1YNRWdvYK285U4ELs5yfeMqeaGpxvbUl1EpWIxpP9oglq4e
	7WKziSI16OzfOEY+0Oh/llMQ8y4QgR6Lw/WEwE78UxQ/YWPh/T5915PY0of1fREnTOgCQGaj8Se
	+3oIEEFooEjaGilQLj2ygOzzj+Krs26OlRmC+7Z11av7zySlWJIg7MXzyZY08vHY+4+e5VDUGCa
	j9Hhr5q0nOBsDFKSTaueU7L8vmZQT9jMaUUIDGyD6UxVBKq5CHwb+3KPap39y0FogLsYKK108R7
	tgcnSbQ3voIb4chS8MDI2iy0a8ihsfxfAfnYEA2c6ENGqJg+taYmUcHl6ospUhr5uU1aWD0TF9a
	o0PyXL47G0a4V+I+ohXteme/H+R17HiuQIwjIedzYTen5Y=
X-Received: by 2002:a17:903:17c3:b0:2ad:d5d7:bad2 with SMTP id d9443c01a7336-2aecac36dfdmr3146585ad.48.1773338049641;
        Thu, 12 Mar 2026 10:54:09 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378ca7sm60453345ad.91.2026.03.12.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:54:08 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	jserv@ccns.ncku.edu.tw,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] docs: interconnect: Document consumer APIs and drop outdated text
Date: Thu, 12 Mar 2026 17:53:41 +0000
Message-ID: <20260312175341.2944154-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260312175341.2944154-1-visitorckw@gmail.com>
References: <20260312175341.2944154-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation currently states that consumer interfaces are not
documented, which is no longer true.

Remove the outdated claim and include the existing kernel-doc from
drivers/interconnect/core.c (filtered for consumer APIs) and
drivers/interconnect/bulk.c.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 Documentation/driver-api/interconnect.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index cf7a83f8c953..cebb77b49d8d 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -95,8 +95,14 @@ Interconnect consumers
 
 Interconnect consumers are the clients which use the interconnect APIs to
 get paths between endpoints and set their bandwidth/latency/QoS requirements
-for these interconnect paths.  These interfaces are not currently
-documented.
+for these interconnect paths.
+
+.. kernel-doc:: drivers/interconnect/core.c
+   :functions: devm_of_icc_get of_icc_get_by_index of_icc_get icc_get
+               icc_put icc_enable icc_disable icc_set_bw icc_set_tag
+               icc_get_name
+
+.. kernel-doc:: drivers/interconnect/bulk.c
 
 Interconnect debugfs interfaces
 -------------------------------
-- 
2.53.0.851.ga537e3e6e9-goog

