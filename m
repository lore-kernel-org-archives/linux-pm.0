Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3ADC433FC
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D842076D
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgGPM4U (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgGPM4C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPq12B4z9sVB; Thu, 16 Jul 2020 22:55:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     rjw@rjwysocki.net, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
        daniel.lezcano@linaro.org
In-Reply-To: <20200706053258.121475-1-huntbag@linux.vnet.ibm.com>
References: <20200706053258.121475-1-huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : Remove dead code block
Message-Id: <159490400609.3805857.11882065929256574276.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:58 +1000 (AEST)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 6 Jul 2020 00:32:58 -0500, Abhishek Goel wrote:
> Commit 1961acad2f88559c2cdd2ef67c58c3627f1f6e54 removes usage of
> function "validate_dt_prop_sizes". This patch removes this unused
> function.

Applied to powerpc/next.

[1/1] cpuidle/powernv : Remove dead code block
      https://git.kernel.org/powerpc/c/c339f9be304c21da1c42899a824f84a2cc9ced30

cheers
