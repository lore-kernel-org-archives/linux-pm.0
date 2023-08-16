Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5613C001E0
	for <linux-pm@archiver.kernel.org>; Wed, 16 Aug 2023 13:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbjHPNFf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Aug 2023 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbjHPNFb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 09:05:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97FDB1BFB;
        Wed, 16 Aug 2023 06:05:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94017D75;
        Wed, 16 Aug 2023 06:06:11 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F0523F6C4;
        Wed, 16 Aug 2023 06:05:27 -0700 (PDT)
Message-ID: <8fa02b18-7e41-eaea-f054-6842f6e310c6@arm.com>
Date:   Wed, 16 Aug 2023 15:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/12] PM: EM: Introduce runtime modifiable table
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-9-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-9-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2023 17:50, Lukasz Luba wrote:
> This patch introduces the new feature: modifiable EM perf_state table.

nit pick: The first sentence doesn't add any information. I would skip it.

[...]

> The runtime modifiable EM data is used by the Energy Aware Scheduler (EAS)
> for the task placement. The EAS is the only user of the 'runtime
> modifiable EM'. 

The runtime modifiable EM is currently only used ...
The you can skip the next sentence: "The EAS is the only user ..."

All the other users (thermal, etc.) are still using the
> default (basic) EM. This fact drove the design of this feature.

[...]

