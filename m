From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu, 1 Sep 2016 11:45:16 +0800
Message-ID: <57C7A44C.3000502@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
 <20160831131829.GB19101@kroah.com> <57C7A2FC.2030604@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34512 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbcIADpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 23:45:21 -0400
Received: by mail-pf0-f172.google.com with SMTP id p64so26353316pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 31 Aug 2016 20:45:20 -0700 (PDT)
In-Reply-To: <57C7A2FC.2030604@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>



On 09/01/2016 11:39 AM, Alex Shi wrote:
> User can set values on each of cpu, like limit 100ms on cpu0, that means
> the cpu0 response time should be in 100ms in possible idle. It similar
> with DMA_LATENCY, but that request is for all cpu. This is just for
> particular cpu, like a interrupt pined CPU.

Sorry for typo!
s/100ms/100us/

> 
> echo 100 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us
>> > 
