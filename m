From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] power: supply: act8945a_charger: fix of_irq_get() error
 check
Date: Mon, 17 Jul 2017 15:00:26 +0300
Message-ID: <9f7d4b95-dcea-d8bf-8bf4-6551d4ab7b58@cogentembedded.com>
References: <20170716175244.300670810@cogentembedded.com>
 <c0a5fce5-4185-249b-e206-4964d41ab05a@cogentembedded.com>
 <20170717105003.riv7fe44jzmkffg3@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33726 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQMAa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 08:00:30 -0400
Received: by mail-lf0-f42.google.com with SMTP id z78so84199294lff.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 05:00:29 -0700 (PDT)
In-Reply-To: <20170717105003.riv7fe44jzmkffg3@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

Hello!

On 07/17/2017 01:50 PM, Sebastian Reichel wrote:

>> Forgot to mention that this patch is against Linus' repo as Sebastian's repo
>> lags behind at 4.10-rc1...
>
> You are supposed to use my for-next branch [0] and not master :) That
> one was 4.12-rc1 + power supply patches until a few hours ago and
> now is 4.13-rc1. So if you based on current master from Linus it
> should be ok. I will start reviewing patches for the v4.14 cycle
> shortly.

    I first tried to use 'fixes' but that one was at 4.8-rc1, then switched to 
back to 'master'.
Since this patch is a bug fix, I didn't consider for-next.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
>
> -- Sebastian

MBR, Sergei
