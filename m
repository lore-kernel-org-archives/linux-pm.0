Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0421771B
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853706; cv=none; b=G4w+g4yjOt5zfwBZ58XIy2rPT/i/lg/0+xdbl4+q5qWJk7g0xIFArrdyeUJiANQuEKq3xUM2ZmgOs49NSHWk2jz8Ill3liUtIC1zxgcpUVI+L/ooBMSRDee9S45zv0OE/y7B1lJlidQ7TDW9XeGSsGZ5le4oI4F4ky4dliBRiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853706; c=relaxed/simple;
	bh=YttGrXU9SU/ehJvcfCqasAD7EOs++FbsxXO5MQSKTeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIiWjjShOJ6/tNdMbGm/f0t7upbtP+h0kwvV4EpFuCxRLwRzZ7J7p3NuRW0LLyrhFAEBPudj+LIdLqEldL43vRX0OExOsbuN3Oo8q9DGl/NAuCuDFoY3l6m0fg4coI9k35fOh+iAb/f+Fn/WTdNDJcayE0c285iy1CXjyzmsYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=kNUbS5fV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="kNUbS5fV"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so73888506d6.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853701; x=1779458501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqJRjXl1qsZ28kF7Puh/2rFrGn87SoP9RmWZpVmxPQc=;
        b=kNUbS5fVNw15WpxgqOGmGfVjkuFaCfgr8SSPb7sqlogQSWgXokhLISNK/HorfA3peS
         J5VIZFOsCfaHTzzhryKM3FDVU3C+s0xVjUlbHWRyb16YjZdeNlw5St6wWBnNiQdXugfd
         3RI+qj/WcmoxwKAIJC6UsJvh1Z6L6+on5GYRf9oywH/gjeilmqBwPp0KPnUsSv7uFgFt
         VAdhB67U7ypbHHsiZ+UzI7LM68DrnBOKsoMqXuJKdfaB2ZPnOYhKioRSe07ls9g8RRqd
         9bgPz0HMLANSmQMbkfkkYMH+GCAk6u4cwtLYuPVNbXSsZurnH2r+tfmstxpNzvEWWvAw
         7pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853701; x=1779458501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqJRjXl1qsZ28kF7Puh/2rFrGn87SoP9RmWZpVmxPQc=;
        b=E/TimaNvHsN6XlA+TQ734t+8Pg5eqRTTKfMfY27neXDzkrils1PyB77mmM2oA+APF3
         Vd3iz1pR+Wh3slmazPMPJmY6uksRVSxf6gVjlhffXdXKb7nx6T5JNE7vqh7/sf2YCkDa
         3zR6aaev+LuqFJDt5lvWWSS2mUxDVxX6tvYu6QG3PFrpvNvgFM5gy9A9WhnQzGa8d7mo
         +N6DEsV5wkx0C7L8PuXp6njGtK5dt1zWBau9V6jqxI8r+ZENivgw6sbdE5yl2n4AqH8u
         xsejtj4BTAEM4SfZZyQj+3qGe1qC2M5M+g4WkEFrDm5VePgypGoTbDyrh+o5B7KVndB+
         hA1A==
X-Gm-Message-State: AOJu0YyxVaA8ye1r9iHRnyiBdY8rIs2jZa9TQhzbHcibiN5VzXoHh5LY
	LVIqRGtKIFcczm1KngGb2W47ynLflCHZy5cMrUQ49tfNPKV6efsZeECGVFm+O7sMPB0=
X-Gm-Gg: Acq92OFXkkycTNWHKOLhedD/bBLuZUMG0hasrPlDCQlPlMQyKDz0GzcZNEAb57Xe3Vv
	N0IAASaUYEa6qQ4kg5vQOxwk0qnWH6eiCltdTGBWITTfZ5Ngb6swjXhKCe0y44q7rg/VP8D4p51
	zN7Ur01jba6cpM//IcLw2cs6SiyNRY0H9/FnaUet+qIpaXUryb3LMgyKBWO0TSAPtJEzZVP7RqM
	S16abpVj8koAbAjUPDoiJVdMghIaihy+oK6sXXbxY6ihuG3ajbOAv8qWa3sb1YYAV9bDR9TjFV7
	x9k8umOwgZ7cjZYtYukST29Tjo2bj0llpG06AfAYXoMFphmYcfE9aGvx7dQkg7W1HIJ/cFdwCmp
	xpUq4wrsPudDGr9PqM47QQXAFTFbCfKaNCyrQIj9NMKN59FaL/hJDnsPy37JK1qg4xKGk5S9Ywx
	dTRUlFhJAtKZKABK37xMRnlhQEWVA1Rfq/glBRxU4CAXyDaUyVlg==
X-Received: by 2002:a05:6214:2f8a:b0:8ca:1dc6:9e23 with SMTP id 6a1803df08f44-8ca1dc6a5femr15157736d6.30.1778853692519;
        Fri, 15 May 2026 07:01:32 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e11929sm52331746d6.14.2026.05.15.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:01:32 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] cpufreq: amd-pstate: Use trace_call__##name() at guarded tracepoint call site
Date: Fri, 15 May 2026 10:01:21 -0400
Message-ID: <20260515140121.2239414-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67327..4722de25149b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -368,7 +368,8 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 
 out_trace:
 	if (trace_amd_pstate_cppc_req2_enabled())
-		trace_amd_pstate_cppc_req2(cpudata->cpu, perf, changed, ret);
+		trace_call__amd_pstate_cppc_req2(cpudata->cpu, perf, changed,
+						 ret);
 	return ret;
 }
 
-- 
2.54.0

