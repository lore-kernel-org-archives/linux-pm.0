Return-Path: <SRS0=GPgV=46=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EBFC10DCE
	for <linux-pm@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D85A20746
	for <linux-pm@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCMP2F (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:28:05 -0400
Received: from foss.arm.com ([217.140.110.172]:57524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCMP2F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 11:28:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75300FEC;
        Fri, 13 Mar 2020 08:28:04 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81B23F67D;
        Fri, 13 Mar 2020 08:28:02 -0700 (PDT)
Subject: Re: [PATCH 0/3] Thermal extensions for flexibility in cooling device
 bindings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, corbet@lwn.net,
        dietmar.eggemann@arm.com
References: <20191216140622.25467-1-lukasz.luba@arm.com>
 <11b6ccb2-ddd8-39cf-a3c8-4dd53e7e50d8@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6d5842b0-25a5-785d-d8cc-34b9eb9fca50@arm.com>
Date:   Fri, 13 Mar 2020 15:28:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11b6ccb2-ddd8-39cf-a3c8-4dd53e7e50d8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 3/13/20 1:33 PM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 16/12/2019 15:06, lukasz.luba@arm.com wrote:
>> From: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Hi all,
>>
>> This patch set adds extensions to existing thermal zones and cooling devices
>> binding. Currently they are pinned using static definitions e.g. DT cooling
>> maps. These changes enable userspace like trusted middleware to change the
>> layout of cooling maps unbinding and binding the cooling devices.
>> It might be helpful for drivers loaded as a modules. They can be added to
>> existing thermal zones to take part of the power split.
>> It is based on the current work in thermal branch thermal/linux-next
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
> 
> I've been keeping this series out of the previous merge because it did
> not raise any comments and we are touching the sysfs.
> 
> For this release, I still don't know what to do with it.

Thank you for bringing this back.

> 
> Anyone a comment on this series? Rui ?
> 

Regards,
Lukasz
