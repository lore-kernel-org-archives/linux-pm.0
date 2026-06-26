Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16EA3FD134
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491609; cv=none; b=JHmNtJQm8gdlCnoZWvHqYoTtySUjt8+gfX2Tbs5mI6eEqE5o8kmzG7T2m9hlslZBgugK1QOrDrrm8gs7wP4XF7Qa2qL3mO/ml8BdUy3uGTXxLXWD4JFneTtyoTGV/zOH+Ge3wC/1QG24eBDMZRDQXiU1jQ7xVWjULhQPCChGwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491609; c=relaxed/simple;
	bh=Web8zHdcbJNnjkhQ3uoss4lsJHrT9sJ1VoYl5dI7U3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsRKAIZ5O0+WyHABoC0k0LaqIxwo9M3T8MfenJDncrQGM618Pcsskl+OiaJJgEe+1vYKGKpPT+fNE4QVri34PbDnhK3o7r9USzh6Ah/kmVFBXOHVtGFAN8mCcdxEUiuobKBAelx9ahVag2WOPAIi10VNwVYvPhWSVnL6k7h4JV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0i0Do7Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ljIEOLIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0i0Do7Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ljIEOLIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782491607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6ZmeaLy1Q8HlDQIKJFG0Hw1Bpilw3Yl9TkyPcS5OMs=;
	b=g0i0Do7YUQ3k8dCcvkEsCVw4kLFdMjTrktTO1QBYxRcKFWBu9gLYi9kjLo0Z9yV/bNnmdy
	+rafsnLFP9cO3q37OoLuKv+d1kYWvWPAzqmTVEwJtKJfl0AWPWE/mZvLJ18NJ1D2WY5cHB
	FXCEy9PeCFY/oDh6C4g2S9+4JIJEjNQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-5zLzfivBMmuqmLK5FmQKkA-1; Fri, 26 Jun 2026 12:33:25 -0400
X-MC-Unique: 5zLzfivBMmuqmLK5FmQKkA-1
X-Mimecast-MFC-AGG-ID: 5zLzfivBMmuqmLK5FmQKkA_1782491605
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8dae6572676so15061906d6.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782491605; x=1783096405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6ZmeaLy1Q8HlDQIKJFG0Hw1Bpilw3Yl9TkyPcS5OMs=;
        b=ljIEOLIZ5FqXrkJkdPeQowFUoaAJ0IL+rYHpm0B7CYxZbXUhUMYl3pSn+vM75rBlfQ
         R5UBHJyjdNQUVRS7+1TamCklJN5p2zBDYAQ1Ni0C9DnqhEUYXZ2JaUhzBvp50/GYVw0Q
         A7i4SJUhIH3JG3YzMa0gP5hCA7RQoD9RE0yeMIPq7CKMKlecZQPUwwr4XBD4a5Nswx2T
         jVCMDsq26r4NrKjthFiDi50OBRukSQ11BG8s5uPjQxVIi25EfjfqYBGz4YFV3lemvK3+
         oFtcSfaDlmtdmcnaDbrT60/Sg+LEizhbVYG9dhPz0YeMdBSNBrYfx95eZ8WDBsOqwNAH
         eu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491605; x=1783096405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6ZmeaLy1Q8HlDQIKJFG0Hw1Bpilw3Yl9TkyPcS5OMs=;
        b=iXZab7lgE64xdnTYqc0sfu7smNNyJcSR+pBizjzSwPpiij+ryxA9G0g0ytGPCoPeMx
         vxMOKqNB8xEWuafVW2ztIm5I14JDuCIBIB4vQ3e0S1rfBFu2zy5mQfX/uZ/g8gqB0xnU
         TjLz8EUoqpRfJtbZHu4g0FFdHImdw0+m6gkHrROEJm3i0zkelNsWJrf6298VN4WG8q+3
         X6GBCS2qjyLIHTnAQOV7VPXYnquljkBzSwkhLQxVbIN9hqoATaRVbcyCu4mY8Tsfldpn
         T6WCWp+R6lq0hrgJk2eyGyTdegDDzEZh6fu3GKL+H5XXYGRO+Vi3h65X+k0dzk2f8plX
         GCpw==
X-Forwarded-Encrypted: i=1; AHgh+Rqv914bCoPlfMZriV7IwCJCFctDmP6UZnZmwQgxgGGszeXis+1lbTpdUysHrsu5i1VWI4IziqNtEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymmhUdNkJCquLwSTs79mOB2FshtVBpztlFyRsXz1WOMG2EiBFa
	tWMxnwRwwIYJtCvLm8Qfwp1d+2FT1m+iuwHMn+zG8ajMSq2pxoeu9zuwdeSxwxENzf2VDhjRIxk
	ZRUWyzsAIK2LPuOqFb4znRM1MglUV4CUnh66aGV5JGpFqZDD8bvbXx0ubkjkr
X-Gm-Gg: AfdE7cmKiW/eFDozHd3TBNDtMscE1l+1YBPvFaXQY0aTr7+UGE5JfX/a+MWUyIQjYDC
	YtyjMl7h0rf09cz9cUm6CmVAY9wFSc9xFzUXIqkB3yVhw9v2zT4pF4kiAQrkWHGjJjNU+AZJ39H
	EvwMMOCHtBui5Q10IMTGf+rY1z7Tw9sDmFfKJByQjmOkhLQoCprNMVWTa5XhAsRfDY7eW0kvIrT
	QyoYFn1XxoNMUtMHZKYcCwBYjfcpGu9mZNLSD+55KGF2O2kJ3g7pEmCmVx86sJmMPcJj0mwMYSw
	lvz928YIoImmegJb82T5i5s8aOMaCaf/zoxQqwlyek0JkGApgUKl6Z8oYFqRe+7VXSfq7gjJ8Sh
	s6gMJI2jIXinkSts02fw8OnocwHLKkQ17c7NMkSA2Rik67uZcsg==
X-Received: by 2002:a05:6214:600a:b0:8e9:78d7:6b98 with SMTP id 6a1803df08f44-8e978d76f48mr22134566d6.6.1782491598180;
        Fri, 26 Jun 2026 09:33:18 -0700 (PDT)
X-Received: by 2002:a05:6214:600a:b0:8e9:78d7:6b98 with SMTP id 6a1803df08f44-8e978d76f48mr22129556d6.6.1782491593301;
        Fri, 26 Jun 2026 09:33:13 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018566sm234540526d6.2.2026.06.26.09.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:33:12 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 26 Jun 2026 12:32:43 -0400
Subject: [PATCH 2/4] pmdomain: core: migrate to dev_add_sync_state()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-clk-sync-state-v1-2-4156d8196dc8@redhat.com>
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
In-Reply-To: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Xuyang Dong <dongxuyang@eswincomputing.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=Web8zHdcbJNnjkhQ3uoss4lsJHrT9sJ1VoYl5dI7U3o=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLsVh7yYNlUc+TIRZ0G1oVmcwt2ZrWt1NHLOxWge5JT1
 qG0wX5TRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABOJ02f4p+C9WPnitnMB29Yo
 i7lum79r8RQDrdfx2yaJpEntXJe5rJyRYcK19uscWg+CuEJXNv13LBWZMbfX9+3CppYlEps+7Qr
 mYwYA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

We have cases where a device node represents a provider for multiple
types of resources, like clocks, power-domains, resets, etc. Having just
a single sync_state on the device is not sufficient since other
frameworks will want to add their own sync_state callback.

Migrate the pmdomain core code from dev_set_drv_sync_state() to
dev_add_sync_state() so that this works nicely with other frameworks
that want to add their own sync_state callback.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 842c4169e290..22791353249c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2697,7 +2697,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
 		device_set_node(&genpd->dev, fwnode);
 	} else {
-		dev_set_drv_sync_state(dev, genpd_sync_state);
+		dev_add_sync_state(dev, genpd_sync_state);
 	}
 
 	put_device(dev);
@@ -2771,7 +2771,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	if (!dev)
 		sync_state = true;
 	else
-		dev_set_drv_sync_state(dev, genpd_sync_state);
+		dev_add_sync_state(dev, genpd_sync_state);
 
 	put_device(dev);
 

-- 
2.54.0

