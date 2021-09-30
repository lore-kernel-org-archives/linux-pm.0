Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49059C433F5
	for <linux-pm@archiver.kernel.org>; Thu, 30 Sep 2021 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B8A619F9
	for <linux-pm@archiver.kernel.org>; Thu, 30 Sep 2021 10:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349800AbhI3KLq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:11:46 -0400
Received: from foss.arm.com ([217.140.110.172]:51728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349795AbhI3KLp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Sep 2021 06:11:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E65F106F;
        Thu, 30 Sep 2021 03:10:02 -0700 (PDT)
Received: from [10.57.21.60] (unknown [10.57.21.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720433F793;
        Thu, 30 Sep 2021 03:10:01 -0700 (PDT)
Subject: Re: [RFD] Remove the userspace governor and the cooling device set
 state sysfs entry
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
References: <d46b5007-428b-5f31-52d9-a964cc60ad92@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <39728f24-7781-543c-ad28-fd1c7552d96a@arm.com>
Date:   Thu, 30 Sep 2021 11:10:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d46b5007-428b-5f31-52d9-a964cc60ad92@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 9/22/21 10:59 AM, Daniel Lezcano wrote:
> 
> Hi,
> 
> the userspace governor is sending temperature when polling is active and
> trip point crossed events. Nothing else.
> 
> In the other side, the cooling device have their cooling device
> set_cur_state read-writable all the time.
> 
> The thermal framework is wrongly used by userspace as a power capping
> framework by acting on the cooling device opaque state. This one then
> competes with the in-kernel governor decision.
> 
> As the new netlink thermal notification is able to provide the same
> information than the userspace governor.
> 
> I propose to remove the userspace governor and the cur_state entry in
> the sysfs exported file.
> 
> The DTPM framework is the right framework to do power capping and
> moreover it deals with the aggregation via the dev pm qos.
> 
> Does it make sense ?

It sounds that we should be OK with the information from netlink.
I don't see objections. We can also extend the netlink packet when
needed. I'm fine with removing the user-space governor.

Regards,
Lukasz
