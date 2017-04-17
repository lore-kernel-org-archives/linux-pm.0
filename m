From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] thermal: bcm2835: move to the broadcom subdirectory
Date: Mon, 17 Apr 2017 14:21:27 -0700
Message-ID: <e511c01b-0871-c8a9-2c09-4da002c5a28f@broadcom.com>
References: <20170417210416.16426-1-zajec5@gmail.com>
 <4d01beef-41a4-1a21-5aea-af4c9b698269@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36300 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbdDQVVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 17:21:30 -0400
Received: by mail-oi0-f42.google.com with SMTP id r203so155948120oib.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 14:21:30 -0700 (PDT)
In-Reply-To: <4d01beef-41a4-1a21-5aea-af4c9b698269@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Jon Mason <jonmason@broadcom.com>, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>

On 04/17/2017 02:19 PM, Florian Fainelli wrote:
> On 04/17/2017 02:04 PM, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> We already have 2 Broadcom drivers and at least 1 more is coming. This
>> made us create broadcom subdirectory where bcm2835 should be moves now.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> I'm resending this patch including linux-pm mailing list. Sorry for
>> missing it previously.
>> ---
> 
> What tree is this against?

Found it here:

https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=next

with that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
