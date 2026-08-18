Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2F449B21
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046956; cv=none; b=dZpXNrlwWAPlQzrByUqxjjbWjGAJrceLags7ADTnpz2gXjpDar59V3uAE2U8TpDR0ykvDyJooGm0P41HWE8elob6PIfxXsUypN1/lkhvS4adp96bW/xyvAeZ+lfE8k3Sc1u0dCMkc9oJ2+8zh0BVTtu2HhmP6wNZw6WthJ+flBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046956; c=relaxed/simple;
	bh=oqiWITuBEAfzvqX1ztHbFx1o5PIwsJtyuidulrEnBHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TABjiIxFy5DljC5czIYDbRS9GZUYe6frOfxNZvHPzm9WGCI6aSx2gEYX6kvxeqY2x+sKUHwV+mhq7wS626TKhtmemB3zn15XE0b0/NUzZ5imr02PCQN7vwR9PzOXDsNlqRrX8y9ONg57VBmYH99jRLXZeuBOi9mItUqh3UAbKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI1P6MrE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI1P6MrE"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96c92c0980so2590230a12.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787046954; x=1787651754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gQwv0tA6IhRZ/5u1hMobdKE0jzvjZuHw2k8dvpXPjE=;
        b=JI1P6MrE1Q2Q2cANHrzFWj9UauVKhFG+JspKI2KGTI5pUTFeaFdDlRA5iQtPHL2deA
         uhYFJRsf3sRFFn58Qv5ymL7Kzhqc5xB5ToHx/PNoVX1CL2EM7K9To7+dfdgZNcXM7e9J
         REFyE9M2EtiBHDLuINcnBuralKMeiymnRcvPcjjNORqWma+lN652UIwVOLCJOpvgIJf1
         oaxHp0EzLjio9n1gl2+YZV5bfbTahVQfNQwoStfu7bLw5afDrM7MLrAwbNXVaKysxQCZ
         WNRJhc6ZP/GGQM4tYkchaYoSZGJfWhsjFEVdl2UVy/8gLR9mOaL5uAsshhWbxOl4Gm6G
         VK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046954; x=1787651754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gQwv0tA6IhRZ/5u1hMobdKE0jzvjZuHw2k8dvpXPjE=;
        b=IDcOo+yCg3du1SPDp3VmzsEGvE5Plsd6ir72TYys9woOJpMFSm/Ljfk9HGsuLZkrh2
         IbMcO1RJpSUPaRZvbw+U1yo+AjhrxApbLfBhz47grRx+KZUStlsTiBDbEPhzNTNDbpIE
         T3J9c5/ysYuPKqNMcesK79oYHV8DGiRxd2kQFD4F2EehWChvk0+4PDsvscZzD0GQ1AOR
         yWcTzAk7xMNVWINZeVHodNXbiFE7lz8yvHl4HP5Ev24h26BlzDymQsthHRBrMnIblZMD
         K2LLMETcpYUHBBES8AQAn31UXmdN8q+ETzciwiagzYnZaQcVsJvfGydNXrExbvycAqSg
         C+lg==
X-Gm-Message-State: AOJu0YwxJBTAOFnj8y+U2lJAlnO7WbdiZF9qDfdrq4i4APRxc8nJ0wwp
	d4907+c2F70OG2eOLkzsZXVykG6x7vSCATmkGFYafAfXrxFLCo87foG32xreFXD0
X-Gm-Gg: AR+sD13joDyFISb+XTY9Cxw73dCJDmDTjUmQ5ANKbp2oxXmpIK7fyPAjafXTlss9+QA
	QLtcjqtWF/1R3pduwJrXUxkzEDGZgFbqoyohwMbEO0Tr/whSA/IonzqCNXQVwtdCby6PC+aC5ff
	ckx4xV2RjdGKcLru4IywecwAodFRgS7Bmv53AcKx3aeGxJOL/upXkI+Jw6FgvGt34cjSgz0saLm
	QaSavSmf8gHKmmQgc7eMVTI1483wSf7Alg0uEfvf7mbw3gJVN++pEy2qeVTfsbubB6FFMubq2Hd
	v2dbzHGVBMRYI6zBNWN78JfVpU2tq6Gu+4exyaREiP8Ryy85k25shMvJuNHJjQdwqXG88A/A3nA
	1B5HK+LdVgu15P9Da8cAdXCYW+vJ2wugzc12KYoTc8/PQD49oZpqW3/b7LX9xYtg3f8ZdC68G0N
	eAuUjZOhpmjBX2A2PnnCzLaknuOO9Od0WytAFuuSAFMm4lCHA9v+GNJ1C+ThRpslpke8DJBOtkP
	2rmfqNe9os=
X-Received: by 2002:a05:6a20:a106:b0:3c3:a20f:f729 with SMTP id adf61e73a8af0-3cc719fe4b7mr35524420637.7.1787046954258;
        Tue, 18 Aug 2026 02:55:54 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326794c0c94sm29532295eec.9.2026.08.18.02.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:55:53 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH 1/1] cpupower: monitor: Show how a counter value is exported
Date: Tue, 18 Aug 2026 15:25:38 +0530
Message-ID: <20260818095538.1196953-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260818095538.1196953-1-hemanth.selam@gmail.com>
References: <20260818095538.1196953-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"cpupower monitor -l" lists the name, the processor hierarchy level and
a description of every counter, but not how its value is exported. Some
counters are a percentage of the time spent in a state, others are
absolute values with their own unit, for example the Mperf "Freq"
counter reports MHz and the RAPL zones report micro Joule. Both cannot
be told apart from the listing.

Show the value type behind the hierarchy level and document it:

  [%]   The counter is a percentage of the time spent in the state.
  [abs] The counter is an absolute value, its unit depends on the
        counter, MHz for "Freq" or micro Joule for a RAPL zone.

Before:

  $ cpupower monitor -l
  Monitor "Mperf" (3 states) - Might overflow after 922000000 s
  C0	[T] -> Processor Core not idle
  Cx	[T] -> Processor Core in an idle state
  Freq	[T] -> Average Frequency (including boost) in MHz

After:

  $ cpupower monitor -l
  Monitor "Mperf" (3 states) - Might overflow after 922000000 s
  C0	[T] [%] -> Processor Core not idle
  Cx	[T] [%] -> Processor Core in an idle state
  Freq	[T] [abs] -> Average Frequency (including boost) in MHz

The time granularity part of the ToDo needs a new cstate_t member every
monitor has to fill in, keep it noted.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/power/cpupower/man/cpupower-monitor.1   |  8 +++++++
 .../utils/idle_monitor/cpupower-monitor.c     | 22 ++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 89af019f8dc4..c8008919627c 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -51,6 +51,14 @@ coverage in square brackets:
 .IP \(bu
 [M] \-> Machine/Platform wide counter
 .RE
+.IP \(bu
+How the counter is exported, in square brackets behind the hierarchy level:
+.RS 4
+.IP \(bu
+[%] \-> Percentage of the time spent in the state
+.IP \(bu
+[abs] \-> Absolute value, the unit depends on the counter
+.RE
 .RE
 .RE
 .PP
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index e8b3841d5c0f..376a1e30653a 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -269,6 +269,20 @@ static void parse_monitor_param(char *param)
 	avail_monitors = hits;
 }
 
+/*
+ * A monitor exports a counter either as a percentage of the time spent
+ * in the state or as an absolute value. Tell both apart, so that the
+ * numbers a measurement run prints can be interpreted.
+ */
+static const char *value_abbr(const cstate_t *state)
+{
+	if (state->get_count_percent)
+		return "%";
+	if (state->get_count)
+		return "abs";
+	return "?";
+}
+
 void list_monitors(void)
 {
 	unsigned int mon;
@@ -284,10 +298,12 @@ void list_monitors(void)
 		for (state = 0; state < monitors[mon]->hw_states_num; state++) {
 			s = monitors[mon]->hw_states[state];
 			/*
-			 * ToDo show more state capabilities:
-			 * percent, time (granlarity)
+			 * ToDo show the time granularity of a counter, this
+			 * needs a new cstate_t member every monitor has to
+			 * fill in.
 			 */
-			printf("%s\t[%c] -> %s\n", s.name, range_abbr[s.range],
+			printf("%s\t[%c] [%s] -> %s\n", s.name,
+			       range_abbr[s.range], value_abbr(&s),
 			       gettext(s.desc));
 		}
 	}
-- 
2.43.7

