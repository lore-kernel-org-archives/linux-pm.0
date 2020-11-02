Return-Path: <SRS0=ViTu=EI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89079C00A89
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CD4223B0
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgKBJAK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:00:10 -0500
Received: from foss.arm.com ([217.140.110.172]:56148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgKBJAK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 04:00:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A33AF101E;
        Mon,  2 Nov 2020 01:00:09 -0800 (PST)
Received: from [10.57.13.99] (unknown [10.57.13.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3192F3F718;
        Mon,  2 Nov 2020 01:00:08 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Add upper and lower limits in IPA power budget
 calculation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, Dietmar.Eggemann@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
References: <20201015112441.4056-1-lukasz.luba@arm.com>
 <c9471380-1614-209e-e75b-276edfb52ef4@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <facb8fe7-bd3b-b4b1-ee1b-859b4319d56d@arm.com>
Date:   Mon, 2 Nov 2020 09:00:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c9471380-1614-209e-e75b-276edfb52ef4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/26/20 8:42 PM, Daniel Lezcano wrote:
> 
> Applied, thanks
> 

Thank you Daniel!
