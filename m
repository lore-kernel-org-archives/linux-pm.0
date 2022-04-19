Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A97DC46467
	for <linux-pm@archiver.kernel.org>; Tue, 19 Apr 2022 16:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiDSQq4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbiDSQot (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 12:44:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7863388C;
        Tue, 19 Apr 2022 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gmwp6hCpDpkNeao1lmSCrEoofE1rLIQS3F3WG/Ay4d0=; b=W5IKh7p5XPGVml/PRLwu/wftZa
        bQxNObOao0RyxRjUMJWj4TdES7GvlOXKERMZUsJdQAxSqB3glodi02FdkLrowD13CzSh8wtgp+cGe
        tb1cH97dlQ36uYREZHwE2GuJGsppO0tjARYSR24bT4ZcGnHgrrIZzXrtXZdhVOLmvYcmdWmOn3MGD
        vDsQNB+fg5YYkJDyLHZv4JM3164RkpvwiLIAUjM33gjmIcr2+TC5BaUL76kJ7x9nKJcn8izBrLpo6
        BvUFxjVQfh6mSTAWHEIipjPYfJEoacEWZ/l/UfeIo1OBKJLveLn3eNbtBSFGrSxFu+KXH3XrLTj1g
        TCNk8ktA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngqvP-003Gz9-Lt; Tue, 19 Apr 2022 16:41:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E760986195; Tue, 19 Apr 2022 18:41:57 +0200 (CEST)
Date:   Tue, 19 Apr 2022 18:41:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
Message-ID: <20220419164157.GW2731@worktop.programming.kicks-ass.net>
References: <20220415133356.179706384@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415133356.179706384@linutronix.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 15, 2022 at 09:19:48PM +0200, Thomas Gleixner wrote:
> ---
>  arch/x86/include/asm/cpu.h       |    2 
>  arch/x86/include/asm/topology.h  |   17 -
>  arch/x86/kernel/acpi/cppc.c      |   28 --
>  arch/x86/kernel/cpu/aperfmperf.c |  474 +++++++++++++++++++++++++++++++--------
>  arch/x86/kernel/cpu/proc.c       |    2 
>  arch/x86/kernel/smpboot.c        |  358 -----------------------------
>  fs/proc/cpuinfo.c                |    6 
>  include/linux/cpufreq.h          |    1 
>  8 files changed, 405 insertions(+), 483 deletions(-)


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
