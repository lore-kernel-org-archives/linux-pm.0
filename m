From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Thu, 23 Jun 2016 19:55:57 +1000
Message-ID: <CAKTCnznr-cmrAciekQxSC-=b7O01=YQu4EF5B6Z=ShVqcPbRzQ@mail.gmail.com>
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com> <576BAEE2.4060202@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35743 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcFWJz7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 05:55:59 -0400
Received: by mail-yw0-f180.google.com with SMTP id l125so66066633ywb.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 02:55:58 -0700 (PDT)
In-Reply-To: <576BAEE2.4060202@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org

>> This is still a rounding error but at a different site. I see we saved
>> a division by doing a >> 10, but we added it right back by doing a /20
>> later in the platform code.
>
> While a >> 10 is done at every idle exit, div by 20 is done once during
> boot, so this doesn't negate the previous optimization.
>

Yes, fair point

>> Shouldn't the rounding affect other
>> platforms as well? Can't we fix it in cpuidle_enter_state().
>
> This does affect all platforms, but I'm guessing no other place relied
> on the precision of last_residency calculations.
> Daniel can perhaps comment on this.
>
