From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] PM / Runtime: Improve prepare handling at system suspend for genpd
Date: Mon, 15 Apr 2013 15:44:51 -0700
Message-ID: <87vc7n8lcs.fsf@linaro.org>
References: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
	<1844674.ZBv3XGts1U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:41487 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3DOWoz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2013 18:44:55 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so2765860pdc.14
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2013 15:44:54 -0700 (PDT)
In-Reply-To: <1844674.ZBv3XGts1U@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Fri, 12 Apr 2013 13:50:36 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, April 12, 2013 11:41:44 AM Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> 
>> When genpd prepares for a system suspend it will fetch a runtime
>> reference for the device. When returning it we now use the
>> asyncronous runtime PM API. Thus we don't have to wait for the
>> device to become idle|suspended before we move on and handle the
>> next device in queue.
>> 
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>
> All three patches applied to linux-pm.git/linux-next.

In case it matters, for all three:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
