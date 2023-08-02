Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909EC04E69
	for <linux-pm@archiver.kernel.org>; Wed,  2 Aug 2023 13:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjHBNbe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjHBNbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 09:31:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367A2698;
        Wed,  2 Aug 2023 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4ekzffwWOrCQRRoneCHj9V2gYOG1Rq+IXsS8zLIVtUs=; b=BWc65wUx7yvN1dx0XTneR950/m
        vugxcciydA/+PN3ekG2kWF2cT1IxPzAm0ilW3E0H9UN9ZaE0Hw9tdeack1bERP3lC7Xh5QFdXZ7Rq
        BW4g5Qcf/IZ1ksHFKnG2YXklUh0pCllcWv7rWdpLRFOdeOav2cbj09ew0B1/bkpkIe0l7Ko4KGBNY
        yb/i1iodBRBc+gHXCqtjSN3zfoyQnovgwBoDhnG26dabdguvVb+AY5ICu2/JQHouhXb+CGQsTeGyI
        gE3aOlCi5imC8yE/7ImLdiyZPuJ7BZTl/3YmCQYhXiWUitOA4D/fTSgvDfhwQYZtjLH+upjNPIFPh
        v7WUo5mQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRBwZ-00FxfB-1x;
        Wed, 02 Aug 2023 13:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D56530007E;
        Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E88022107D7E4; Wed,  2 Aug 2023 15:31:14 +0200 (CEST)
Message-ID: <20230802132431.254614419@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 15:24:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kajetan.puchalski@arm.com
Subject: [RFC][PATCH v2 0/5] cpuidle,teo: Improve TEO vs NOHZ
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Patches attempting to solve the TEO tick/nohz vs timer-pull issue.

Very lightly tested..

Since last time:

 - 'split' tick_nohz_get_sleep_length()
 - replaced the tick heuristic
 

