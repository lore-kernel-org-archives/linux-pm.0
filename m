Return-Path: <SRS0=4Hy5=XM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F003C4CEC9
	for <linux-pm@archiver.kernel.org>; Tue, 17 Sep 2019 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A8C21852
	for <linux-pm@archiver.kernel.org>; Tue, 17 Sep 2019 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfIQO56 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:57:58 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:60273 "EHLO
        19.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfIQO56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 10:57:58 -0400
Received: from player772.ha.ovh.net (unknown [10.108.57.14])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id A9CCC133215
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2019 16:40:01 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id 6B8229E4787E;
        Tue, 17 Sep 2019 14:39:42 +0000 (UTC)
Date:   Tue, 17 Sep 2019 16:39:37 +0200
From:   Quentin Perret <qperret@qperret.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, matt@codeblueprint.co.uk,
        viresh.kumar@linaro.org, juri.lelli@redhat.com, pjt@google.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20190917143937.GA334@qperret.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <20190914105708.GA12877@qperret.net>
 <1568730466.3329.4.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568730466.3329.4.camel@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Ovh-Tracer-Id: 17312118445391502229
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 17 Sep 2019 at 16:27:46 (+0200), Giovanni Gherdovich wrote:
> I'll check what's the cost of static_cpu_has() and if it's non-negligible I'll
> do what you suggest (x86-specific version of arch_scale_freq_invariant().

In case this is indeed expensive to check, you could always add a static
key, set at boot time, to optimize things a bit ... That might be worth
it since this is called in latency-sensitive paths of the scheduler.

Thanks,
Quentin
