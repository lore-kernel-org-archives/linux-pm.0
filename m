Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DCE3BAD8B
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281679; cv=none; b=pGN5lBAyVLO3OJRXfvEcNT22N1TrtYD9Zade4JPTt5xG34wdMw/C1x4kuV/g17euycUYowaI5uu5dv8BMlmvPqwgymvo/nCTf4vZTiPdseTRsDgk9zDAXepu1Eid9EmG1ExOsA/Y104ZlAybEjS7dGmRG8hjvkRs+xT7ZMXehVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281679; c=relaxed/simple;
	bh=55sJcEAeOqP1wUV2kAWxr6Nm9zg3ay3zznJQoatj8TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RypSos7TvhJ9kPq3cIdrWHvIjcMui3ZoxipHzjgCDjNZsGkhxEFwodX5yjvzGbDoiZ7PdM/BxNoGodCNQz0QgJ4uwfZqYSWOq/xqh3gW0Hh5HWuaqITe5suhGuiTFkhm8yBcPWF7YmUfGGKdcVVUYUxpQeKWPb/HXhodP6s483s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=a4ALGmuu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="a4ALGmuu"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67c2045c0f7so2412767eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281677; x=1774886477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gykI5Ys0pP1nvSBMUxU7kJy0pSWFmdTNGK8Js6c+Xs=;
        b=a4ALGmuutkidRTHjTTlgtW94BO3VcLgG9iKFKICeZ1ARAOvZwTWCe2WfVWv/fU/Za2
         6okh+yu9aA4vKT3mU18xe9yaGDGCV+L1mzQSxq95koV6oG6rl8HB4UVWl+GbqAn5fKmY
         7MFIpOs7xYl7Y096u/lsuGr7+OgMODZqWl2QY+O0Wm2MsDBgVNFBnJ/OtYqmER3CzoSl
         5MxDHqknR5Oqyo0Is+InXhRvYvjcrn/YKz4Macs37zlPamwMbz0ytIYxl9Fa9bNQAnks
         hJc4Dq4MEkPJ0ZL5/E6Pm6Pw8V8iTx+ZxF2PK9877Ud+UPk0CD3yGYzh2lFlpqJ1663S
         fv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281677; x=1774886477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gykI5Ys0pP1nvSBMUxU7kJy0pSWFmdTNGK8Js6c+Xs=;
        b=VsU2gKbxnSHoRTPcaEyxEjer+1yvxQHu0eg+PIqLa9dhM/8N9qLIzpyFh0Eh+Z9x3U
         XYUpXYtqC545hCSeQvqli/wwh1fys4Md2RN9m+VaTYBu5l1MGS3FGr0bLhUnSkFFFGHA
         E7hBzrUkmGNHr1/p5/hRTlcWjjAIvUfp/srw3ffzrjxib5j48bHVD4IvHONa6zU+sQuM
         0CMx2y9zoYqlWXlfY04OI+MfbZkNAlEgEFyqJXwEBJ8qrQjKmXiqzMbL5B2KvJZ0RBgQ
         Vdtho6RpisMDbvr5R+C7hQr+AVRH8kVZTgBtrb9aZ7nls2CfJQaKcZ3/FVBFLCxroZMJ
         9uaA==
X-Forwarded-Encrypted: i=1; AJvYcCX6xA0pQ8eqFkt3A7BV68zTcf/0PFoQYOh7icSH+UXgGQk/aAbQhAVg4KV4Fm3nDng9o1tmOUx7lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTocKhWLX0HZ3vJhscPgDT/wsOlSXaCKVw4+zYGjVKX0x5RRhF
	clMM5rA3sRiMfZxILBZ6nZ+j/UFbqMMGTvJkf9i+5gY3JGUWGLHINRvrZc11TiT6CXA=
X-Gm-Gg: ATEYQzzeTZzP1/2PaNUenIGFeMPoBlOXrii24lGGXqEpg5iz2rGG9Ah6P51krZbjn+D
	cNWCZVt+hRR4k9XFP3rhSVzBqqWxFSdA2zR+XRsYYeVGIFSRDjCsGDR6R3VqZFyycADwKL91Eio
	DSZclqxwWCTiwvs+IksUdyy15D1HCdMDWhKVKBUE3icaf3EEdHvHVDfvGieWU5/dQ51OGHbgZD7
	+F5rwJrht5Zv8lGuIrdnfQW6IoSxgjQUKWpXPE0c6JQ5bqWQpF8SNNJnY/XGlmZLgeAX3BbgOv+
	U+UbpRIQAknOF1ftwGWuXIQhYza6/XGvE4kk7u8TG3RMlEO9W0T87Tj/oZy8Pk6zaCpemRE3xx6
	/nKrdsfhzyvnirvkXZtcIMaQCEznC1afl8Prc+WPWe4fmW8MKOG4vlNYRHj89FWJtYiFYG4H354
	H0zJ7RNFr0HNACbegQCQTSTnpdt/UD7TyYfDvZK4Q4zf6FBNwphlDwkGdLdRLdeeZaiw==
X-Received: by 2002:a05:6820:1888:b0:67d:eb9e:26ca with SMTP id 006d021491bc7-67deb9e296fmr4032624eaf.40.1774281676551;
        Mon, 23 Mar 2026 09:01:16 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:16 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 07/19] devfreq: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:26 -0400
Message-ID: <20260323160052.17528-8-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c0a74091b9041..d1b27d9b753df 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * change order of between devfreq device and passive devfreq device.
 	 */
 	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
-		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
+		trace_call__devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-- 
2.53.0

