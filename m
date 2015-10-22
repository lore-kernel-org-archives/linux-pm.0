From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Merge measurements for PM QoS device latencies
Date: Thu, 22 Oct 2015 15:52:43 +0200
Message-ID: <CAPDyKFrNb7HQg5jmq2LSQxX880Pq53WwhRxaXZFw-ezMQzNCfA@mail.gmail.com>
References: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org>
	<20151021103311.GA17163@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35587 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbbJVNwp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 09:52:45 -0400
Received: by wicll6 with SMTP id ll6so136496593wic.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 06:52:44 -0700 (PDT)
In-Reply-To: <20151021103311.GA17163@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On 21 October 2015 at 12:33, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2015-10-15 17:02:19, Ulf Hansson wrote:
>> Measure latency does by itself contribute to an increased latency, thus we
>> should avoid it when it isn't needed.
>>
>> By merging the latency measurements for the ->save_state() and the
>> ->stop() callbacks, we get one measurement instead of two and we get one
>> value to store instead of two. Let's also apply the likewise change for
>> the ->start() and ->restore_state() callbacks.
>
> I guess we should simply delete the latency measurement code at this
> point, and let interested parties patch their kernels to do the
> measurements.

No, I don't think we should remove it. The measurements are useful and
valid, but that doesn't mean we can't improve on how/when we measure
and validate latencies.

Kind regards
Uffe
