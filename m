From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: drivers/power: add entry for SmartReflex AVS drivers
Date: Tue, 06 Aug 2013 16:58:05 -0700
Message-ID: <87haf2fk36.fsf@linaro.org>
References: <1375720159-13684-1-git-send-email-khilman@linaro.org>
	<2468244.h36esXYJ6h@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:47627 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab3HFX6I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 19:58:08 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so1134820pbc.25
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2013 16:58:08 -0700 (PDT)
In-Reply-To: <2468244.h36esXYJ6h@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Wed, 07 Aug 2013 00:54:43 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Anton Vorontsov <anton@enomsg.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Nishanth Menon <nm@ti.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Monday, August 05, 2013 09:29:19 AM Kevin Hilman wrote:
>> The SmartReflex AVS driver evolved out of the OMAP kernel and now
>> lives under drivers/power/avs.
>> 
>> I've historically been maintainer of this but Nishanth Menon is doing
>> most of the heavy lifting now.  Add us both as co-maintainers.
>> 
>> Cc: Anton Vorontsov <anton@enomsg.org>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Cc: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> Who's supposed to take this patch?

I assumed Anton, but I wasn't sure since I've been merging
drivers/power/avs patches through you.

Kevin
