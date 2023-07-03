Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09716EB64DC
	for <linux-pm@archiver.kernel.org>; Mon,  3 Jul 2023 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGCQAg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 3 Jul 2023 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGCQAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 12:00:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 274D9E44;
        Mon,  3 Jul 2023 09:00:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2E42F4;
        Mon,  3 Jul 2023 09:01:16 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5071E3F663;
        Mon,  3 Jul 2023 09:00:31 -0700 (PDT)
Message-ID: <07e778b5-07bd-94e1-1fc0-876fa21ac7ac@arm.com>
Date:   Mon, 3 Jul 2023 17:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/17] PM: EM: Refactor struct em_perf_domain and add
 default_table
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-14-lukasz.luba@arm.com>
 <6fc603da-b874-0e38-2402-a112e5c3914d@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6fc603da-b874-0e38-2402-a112e5c3914d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/30/23 11:23, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> The Energy Model support runtime modifications. Refactor old
>> implementation which accessed struct em_perf_state and introduce
>> em_perf_domain::default_table to clean up the design. This new field
>> is better aligned with em_perf_domain::runtime_table and helps to
>> distinguish them better.
>>
>> Update all drivers or frameworks which used the old field:
>> em_perf_domain::table and now should use em_perf_domain::default_table.
> 
> I still believe that doing this refactoring before the introducation o
> the new feature `runtime modifiable EM` would do wonders on the
> tangibility of the other patches in this set.
> 
> [...]
> 

Let me move that refactor patch a bit earlier in the series...
