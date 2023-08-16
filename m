Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7660C04E69
	for <linux-pm@archiver.kernel.org>; Wed, 16 Aug 2023 13:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHPNFf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Aug 2023 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbjHPNFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 09:05:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A55B26BA;
        Wed, 16 Aug 2023 06:05:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14FE5D75;
        Wed, 16 Aug 2023 06:05:52 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 148733F6C4;
        Wed, 16 Aug 2023 06:05:07 -0700 (PDT)
Message-ID: <47b0ee2a-c747-4b13-1729-fbbd7c7ef65d@arm.com>
Date:   Wed, 16 Aug 2023 15:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/12] PM: EM: Add update_power() callback for runtime
 modifications
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-8-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-8-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2023 17:50, Lukasz Luba wrote:
> The Energy Model (EM) is going to support runtime modifications. This
> new callback would be used in the upcoming EM changes. The drivers
> or frameworks which want to modify the EM have to implement the
> update_power() callback and provide it via EM API
> em_dev_update_perf_domain(). The callback is then used by the EM

Looks like em_dev_update_perf_domain() hasn't been introduced yet.

[...]

