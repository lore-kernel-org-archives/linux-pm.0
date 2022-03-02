Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D0C433FE
	for <linux-pm@archiver.kernel.org>; Wed,  2 Mar 2022 17:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbiCBRrd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiCBRrc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 12:47:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEAF3D19B1;
        Wed,  2 Mar 2022 09:46:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73AEC139F;
        Wed,  2 Mar 2022 09:46:48 -0800 (PST)
Received: from [10.57.21.27] (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687AE3F73D;
        Wed,  2 Mar 2022 09:46:46 -0800 (PST)
Message-ID: <b040ea6c-5fdf-b68a-a580-d2d0095a33de@arm.com>
Date:   Wed, 2 Mar 2022 17:46:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/5] dt-bindings: opp: Add "opp-microwatt" entry in the
 OPP
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220302112917.27270-1-lukasz.luba@arm.com>
 <20220302112917.27270-2-lukasz.luba@arm.com>
 <Yh+tKe7oWCpmj5MC@robh.at.kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Yh+tKe7oWCpmj5MC@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/2/22 17:45, Rob Herring wrote:
> On Wed, Mar 02, 2022 at 11:29:13AM +0000, Lukasz Luba wrote:
>> Add new entry for the OPP which provides information about power
>> expressed in micro-Watts. It is useful for the Energy Model framework.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../devicetree/bindings/opp/opp-v2-base.yaml  | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob for the review!

Regards,
Lukasz
