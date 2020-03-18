Return-Path: <SRS0=gBUe=5D=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E596C10DCE
	for <linux-pm@archiver.kernel.org>; Wed, 18 Mar 2020 08:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F84E2076D
	for <linux-pm@archiver.kernel.org>; Wed, 18 Mar 2020 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCRIH4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:07:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCRIH4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 04:07:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15B8831B;
        Wed, 18 Mar 2020 01:07:56 -0700 (PDT)
Received: from [10.37.12.57] (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBFB3F52E;
        Wed, 18 Mar 2020 01:07:53 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v3] thermal: devfreq_cooling: Use PM QoS to set frequency
 limits
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org
References: <20200312113416.v3.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <20200313165535.GI144492@google.com>
Message-ID: <ec77fb67-d715-b4db-3559-5ae6a93946b4@arm.com>
Date:   Wed, 18 Mar 2020 08:07:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200313165535.GI144492@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel, Rui,

On 3/13/20 4:55 PM, Matthias Kaehlcke wrote:
> On Thu, Mar 12, 2020 at 11:34:20AM -0700, Matthias Kaehlcke wrote:
>> Now that devfreq supports limiting the frequency range of a device
>> through PM QoS make use of it instead of disabling OPPs that should
>> not be used.
>>
>> The switch from disabling OPPs to PM QoS introduces a subtle behavioral
>> change in case of conflicting requests (min > max): PM QoS gives
>> precedence to the MIN_FREQUENCY request, while higher OPPs disabled
>> with dev_pm_opp_disable() would override MIN_FREQUENCY.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> I just noticed that I forgot to add Chanwoo's 'Reviewed-by' tag from v2.
> Dunno if patchwork will allow this, but I can try:
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Could you apply this patch, please? I would like to send the new Energy
Model and the devfreq cooling changes would be based on this.

Regards,
Lukasz
