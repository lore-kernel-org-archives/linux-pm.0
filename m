From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Don't measure ->start|stop() latency in
 system PM callbacks
Date: Wed, 21 Oct 2015 14:47:12 +0200
Message-ID: <CAPDyKFp=qjqOY2w8ftNLWDWEG3V1MC7G9VQDwMcsQ8P-swDdow@mail.gmail.com>
References: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
	<20151021103126.GA16738@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36508 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbJUMrN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 08:47:13 -0400
Received: by wicfx6 with SMTP id fx6so89553392wic.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 05:47:12 -0700 (PDT)
In-Reply-To: <20151021103126.GA16738@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On 21 October 2015 at 12:31, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2015-10-15 17:02:06, Ulf Hansson wrote:
>> Measure latency does by itself contribute to an increased latency, thus we
>> should avoid it when it isn't needed.
>>
>> Genpd measures latencies in the system PM phase for the ->start|stop()
>> callbacks and is thus affecting the system PM suspend/resume time.
>> Moreover these latencies are validated only at runtime PM suspend/resume.
>>
>> To this reasoning, let's decide to leave these measurements out of the
>> system PM phase. There should be plenty of occasions during runtime PM to
>> perform these measurements anyway.
>
> How much latency does the latency measure cause? Something like 0.000
> msec?

Me and Lina did some measurement by hand a couple of weeks ago. If I
remember correctly the results where in the range of a couple of us. I
will check again and update you with some refreshed data.

For system PM the time saved might be negligible, depending on the
number of devices that are attached to a genpd and on what level you
try to optimize things for.

Perhaps this change then becomes more of a policy decision, rather
than an a noticeable improvement. I certainly think dealing with
device PM QoS constraints should belong to runtime PM and I think it's
wrong/useless to do deal with this during system PM.

Kind regards
Uffe
