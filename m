Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47160C433E0
	for <linux-pm@archiver.kernel.org>; Tue,  2 Feb 2021 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D6D64F54
	for <linux-pm@archiver.kernel.org>; Tue,  2 Feb 2021 09:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBBJ5y (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:57:54 -0500
Received: from foss.arm.com ([217.140.110.172]:46938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhBBJ5q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Feb 2021 04:57:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D87014F6;
        Tue,  2 Feb 2021 01:57:00 -0800 (PST)
Received: from [10.57.14.222] (unknown [10.57.14.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFD0E3F7D7;
        Tue,  2 Feb 2021 01:56:57 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, vireshk@kernel.org, rafael@kernel.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <CGME20210201112455epcas1p3abb4475b1690d1b6b9260a78a373e04c@epcas1p3.samsung.com>
 <5751adfa-6e25-3f3c-4a60-9b3c739fec1f@arm.com>
 <d05b247e-2294-e5f0-15bb-1a7a09a8e40e@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2db96384-e413-d151-0d21-8f71060e3438@arm.com>
Date:   Tue, 2 Feb 2021 09:56:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d05b247e-2294-e5f0-15bb-1a7a09a8e40e@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/2/21 9:31 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I'll review this patchset until tomorrow.

Thank you Chanwoo, I will wait then.

Lukasz

> 
> Thanks.
> Chanwoo Choi
> 

