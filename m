Return-Path: <SRS0=4Unk=4M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A7C38BE0
	for <linux-pm@archiver.kernel.org>; Mon, 24 Feb 2020 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307C521744
	for <linux-pm@archiver.kernel.org>; Mon, 24 Feb 2020 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBXSkQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:40:16 -0500
Received: from foss.arm.com ([217.140.110.172]:41732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBXSkQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 13:40:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D4EA1FB;
        Mon, 24 Feb 2020 10:40:16 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB0F3F703;
        Mon, 24 Feb 2020 10:40:13 -0800 (PST)
References: <20200224141142.25445-1-ionela.voinescu@arm.com> <20200224141142.25445-2-ionela.voinescu@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/7] arm64: add support for the AMU extension v1
Message-ID: <jhjpne3ygmm.fsf@arm.com>
In-reply-to: <20200224141142.25445-2-ionela.voinescu@arm.com>
Date:   Mon, 24 Feb 2020 18:39:37 +0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ionela Voinescu writes:

> The activity monitors extension is an optional extension introduced
> by the ARMv8.4 CPU architecture. This implements basic support for
> version 1 of the activity monitors architecture, AMUv1.
>
> This support includes:
> - Extension detection on each CPU (boot, secondary, hotplugged)
> - Register interface for AMU aarch64 registers
> - amu=[0/1/on/off/y/n] kernel parameter to disable detection and
>   counter access at runtime
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
