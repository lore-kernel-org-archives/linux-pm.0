Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4173EC10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 10:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5DC20883
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 10:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfDOK1h (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:27:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60164 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOK1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Apr 2019 06:27:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A7E80D;
        Mon, 15 Apr 2019 03:27:36 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7F783F557;
        Mon, 15 Apr 2019 03:27:35 -0700 (PDT)
Subject: Re: [RFC 5/6] Improvise cgroup interface for classifying jitter from
 WOF tasks
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-6-parth015@linux.vnet.ibm.com>
 <8de36526-806a-810f-9f5e-393dddb523be@arm.com>
 <9aeb5767-82b3-77c1-5334-193236e8a786@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <35addb7c-1ed9-3115-4e44-bfb3b55c7575@arm.com>
Date:   Mon, 15 Apr 2019 12:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9aeb5767-82b3-77c1-5334-193236e8a786@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/12/19 5:48 PM, Parth Shah wrote:
> 
> 
> On 4/12/19 6:38 PM, Dietmar Eggemann wrote:
>> On 3/22/19 7:06 AM, Parth Shah wrote:

[...]

> Maybe the comment is not self-explainable. Please follow a below one,
> 
> Here we have two cpumask to iterate through
> 1. wof_tasks_cpu_mask which contains CPU occupied by user classified task and is hence easier to track
> 2. highutil_task_cpu_mask which contains CPU which are non-idle (not core_underutilized)
> 
> So, the selection of "cpus" can be either from the above two masks.
> Selecting "wof_tasks_cpu_mask" leads to quicker and better selection of non idle CPU,
> whereas "highutil_task_cpu_mask" will contain more CPUs (inclusive of wof_tasks_cpu_mask) and hence finding perfect CPU may require more iterations.
> 
> Hence, selecting "highutil_task_cpu_mask" is relatively exhaustive (which I termed "longer code path") in general cases.
> 
> Hope this helps.

Ah, OK, that helped to understand it.

[...]
