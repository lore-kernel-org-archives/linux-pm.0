Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCAC433EF
	for <linux-pm@archiver.kernel.org>; Wed,  8 Sep 2021 06:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E750D60295
	for <linux-pm@archiver.kernel.org>; Wed,  8 Sep 2021 06:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhIHGhT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:37:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhIHGhT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 02:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909756D;
        Tue,  7 Sep 2021 23:36:11 -0700 (PDT)
Received: from [10.57.21.172] (unknown [10.57.21.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B65A3F73D;
        Tue,  7 Sep 2021 23:36:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] PM: EM: fix kernel-doc comments
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
References: <20210906084453.3068-1-lukasz.luba@arm.com>
 <CAJZ5v0hSzzkVzO0CuP0sf16p70kppfr6oHU1VDjfuBqt_HVfSw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d68d7050-4226-24d3-22d2-8968e81e6388@arm.com>
Date:   Wed, 8 Sep 2021 07:36:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hSzzkVzO0CuP0sf16p70kppfr6oHU1VDjfuBqt_HVfSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/7/21 8:22 PM, Rafael J. Wysocki wrote:
> On Mon, Sep 6, 2021 at 10:46 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>

> 
> Applied as 5.15-rc material along with the [2/2], thanks!
> 

Thank you Rafael!

Regards,
Lukasz
