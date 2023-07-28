Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF152C001DF
	for <linux-pm@archiver.kernel.org>; Fri, 28 Jul 2023 15:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjG1PBO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjG1PBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2023 11:01:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95261FFF;
        Fri, 28 Jul 2023 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gRhD2DL6Ofjvx8HyJGzSmAjib8RktDFYPANPb4xvXOo=; b=mCkhvZeGlFt1058W/ij5hj0eV+
        M9v9w7L774A6WoeeEWBGOXJwQqrSueynX/n1HidtSv7gWRvfkI/Kpf+GXmezXtMDbmth9XWL2SfuW
        bS3z0zgKDvV7ZoKuECyshz4tz5Wymm5FR8N9VNr9X8uXqogWa9muXJnyVjP3pTyOHfVhdo4MVExRf
        PinHa2JNB5LMpgHL66saoJJJ+T8mGpdL2BSFT3URra9FUP5SFVSxC269MYwutCX39pZoWemUPgnQC
        qaDvaxY4a/+iYyLGC81J3JzipnyqE0EI/UrEohzXmO5HZkT4kCGgLUSgWWYJrv0LgVymR8gf8BCcE
        +fOunw9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPOxY-008ar2-Pr; Fri, 28 Jul 2023 15:00:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60DAE308CCC;
        Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2788E2C8FCA98; Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Message-ID: <20230728145808.970594909@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jul 2023 16:55:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: [RFC][PATCH 3/3] cpuidle,teo: Improve state selection
References: <20230728145515.990749537@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When selecting a state, stop when history tells us 66% of recent idles
were at or below our current state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/governors/teo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -363,6 +363,7 @@ static int teo_select(struct cpuidle_dri
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
 	unsigned int tick_sum = 0;
+	unsigned int thresh_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
@@ -397,6 +398,8 @@ static int teo_select(struct cpuidle_dri
 		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 
+	thresh_sum = 2 * cpu_data->total / 3; /* 66% */
+
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -427,6 +430,9 @@ static int teo_select(struct cpuidle_dri
 		if (s->target_residency_ns > duration_ns)
 			break;
 
+		if (intercept_sum + hit_sum > thresh_sum)
+			break;
+
 		idx = i;
 
 		if (s->exit_latency_ns <= latency_req)


