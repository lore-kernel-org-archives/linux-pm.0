From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 3/4] irq: Allow multiple clients to register for irq
 affinity notification
Date: Mon, 18 Aug 2014 18:17:24 -0600
Message-ID: <20140819001724.GA52513@ilina-mac.local>
References: <1407945689-18494-1-git-send-email-lina.iyer@linaro.org>
 <1407945689-18494-4-git-send-email-lina.iyer@linaro.org>
 <7hzjf1uyyh.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:39002 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaHSAR3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 20:17:29 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so9233572igc.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 17:17:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hzjf1uyyh.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: daniel.lezcano@linaro.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de, rjw@rjwysocki.net

On Mon, Aug 18, 2014 at 05:04:22PM -0700, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> The current implementation allows only a single notification callback
>> whenever the IRQ's SMP affinity is changed. Adding a second notification
>> punts the existing notifier function out of registration.
>>
>> Add a list of notifiers, allowing multiple clients to register for irq
>> affinity notifications.
>
>nit: the changelog describes "what", but doesn't answer "why?"  You
>address it a bit in the cover letter, but it should probably be spelled out
>here since this patch will likely need to be separated from this series
>and taken via the IRQ core maintiners.
Good point. I will amend it.

>
>Kevin
