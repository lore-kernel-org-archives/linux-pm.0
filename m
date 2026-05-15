Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0400382F28
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853569; cv=none; b=Xm3ypZb9q4qreO6d9NQ1+1wTik8svxxPWWnvudi7YsiA6wtTGw+YWrJe3Y05ch4pXTrV7cQOqblsAhnklMgeLHt1w7y5Td1Uxy0sZeYAWVPGvW2sXoM1Tv6sHom49ycmBLuIPZDisy4YlZhZEiSeBXpnkhqU1LiZS7NZr+wv7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853569; c=relaxed/simple;
	bh=U6edhbWh87RxESbg8eIhij7NfrChti3tTebLnBZL1n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFLZ7mtvKPhyNBC4tSU420Sc9zvkPKwUS0RQkzFBQIxVE2eLqlB4OYWVOYdlZ+bIEeiD+eoCengiFdPg86JdyERy1V6qSGyGCxM//I/Br91UnM8RElic0BsFFWnBC3TVPdl6zP/Ec2vk5PccRaiU0BAYzqAjjjCI3bO0iQbOvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=tVsz3RNu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="tVsz3RNu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-912575fa768so100132485a.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853567; x=1779458367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/RNSJDlIzgHrmpqUt03igCYrU2Quge26dPpYnyZoWQ=;
        b=tVsz3RNuz4mNpHK5dwu05b9eZRuBcBofhS8gDICoN8sUgmsktPRqCiZNMSwS2Yqhd2
         XtJ1I2ZAU491xmDg6g8Zwwtwm4ilUyHiVs8P0E0GzvTW7QpadXJGD2hqV/fXPVk/o86N
         tFNEkZ/xMixCK7O/02hn7UKUGq1f+bMPCHI3nw3GKJasF27PHhtnRrKc7Pc/VnTbWhdo
         L8q+hajR29mlartN17rHfkRDe2Qdhvqk9cOFR0Qfy9qSjzl/Em6XKIQZxl5EBV4lOweH
         7Lx93V8PXPPxy+f3t2yhgGgv4m3A5CzZkyXuEGnFIgBRoeT2BK+iFBTc9wRO3VJmn/HW
         o09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853567; x=1779458367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/RNSJDlIzgHrmpqUt03igCYrU2Quge26dPpYnyZoWQ=;
        b=bbW7dkL0xpuPgdUpD9ClI75cWhuBJKsC/JBPm9MFCP3GkOhwwv+Plz/zd/dP/COdw2
         MCSb9no2A/mlGy9Zw/74bbzHayHsfaa9FttTxPEcxpEaohW92jgZu3oIEDDrSVnhVtV7
         zYeZvtBlvkVYkJ0FS5suO2FiC6CwJ6pT5IdSRTMc6rf3k1fV8XqYCeGWwJEVn4rGRPtJ
         2NBVv4Ysh35encsQPEGpGBTr/YlRKlacYhXlL7X3QvpxKJPyDhM+iv3BnDsicEr3mpCZ
         RljqO0dMHtroeQ2B3SgNF6padTp2QMH6TAPS1svbDLgDBApt3LK0K+qtzrKSnidt2lzS
         ZSCA==
X-Gm-Message-State: AOJu0YxlgBvG8rkE+oFwVff+QOLvSos6DbpU8WjSDThsZut2K9uRryg6
	RyLkS+9Eo8dqycaCWHyMJxRDSp79XQXmgEjsBmZmMPQlLPz71f2z49yncy4iaC0la/Q=
X-Gm-Gg: Acq92OHfIaNXXbB4PiGVQFgAdDMLVfez2yy68KW8MXBPMBXJul9Dv3hC8edIPKj1B4V
	osyGUfv7lVXJ/LORHZEMS1s4/FTIpd2s8AtOqJhE7ld4r+cdMmVQ09rb5T9tQn3SKOJVeM83co9
	AD/g/Os2O5/LH2NEgX7zeH6hdKBnnt49rWgf+e6XKQF0f1XtGPXLh6wb/C3GRsP7CPzjxqRMiuo
	Jfryhle1CUzxKp1wqW62m34FGRLT9gEhpWfginPpDrn3YqUs8gOzeDdYOx9s35c/Z0ZC4qLM8IS
	q6z0prTAtdl9WjPxg4qMA6uOiRLevzU4ujC/oLyCEQ0XfljJxr5GkltRVv8Vty4ZDtskE4IPlui
	a35jtrrrlZxnw4eO9Xc5h1nf0EQ12BvaJgUQ7KnX3zYier5MbXUFKJ2iGBd0QKoZyuYdkbtV2/M
	hKOk8rDAxY1FXq5bir6d+nu8z5WOh1
X-Received: by 2002:a05:620a:45a9:b0:910:87f4:9a26 with SMTP id af79cd13be357-911cde539fbmr690372785a.41.1778853566881;
        Fri, 15 May 2026 06:59:26 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e5e4sm53146416d6.6.2026.05.15.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:26 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 04/11] devfreq: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:20 -0400
Message-ID: <20260515135920.2238808-1-vineeth@bitbyteword.org>
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
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 82dd9a43dc62..9f71d9dc4a70 100644
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
2.54.0

