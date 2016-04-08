From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Define DT bindings for PM QoS device latencies
Date: Fri, 8 Apr 2016 13:19:36 +0200
Message-ID: <CAPDyKFrdbxuT9kh-j1_RDjCovq80=g_q4USzYxPQgPch1sm08A@mail.gmail.com>
References: <1459432226-22562-1-git-send-email-ulf.hansson@linaro.org>
	<20160401184429.GA18950@rob-hp-laptop>
	<CAPDyKFombK0Kv-r40xbTm=Y3q07bM5woOPB63xzbrck37Vxrqw@mail.gmail.com>
	<20160407175704.GA32257@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37431 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbcDHLTh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 07:19:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id n3so18504852wmn.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 04:19:37 -0700 (PDT)
In-Reply-To: <20160407175704.GA32257@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

[...]

>> >
>> > Shouldn't this be split into latency of the domain (and in the domain's
>> > node) and latency of the device?
>>
>> Yes! $Subject patch only takes device latencies into account.
>>
>> Perhaps what you mean is that we should document device PM QoS
>> latencies in another place than
>> Documentation/devicetree/bindings/power/power_domain.txt as well?
>
> Yes, the location is confusing that this is device latency which has
> nothing to do with power domains other than the fact we've lost all
> state (which a reset could cause too).

Okay, will a new file,
Documentation/devicetree/bindings/power/device_qos.txt make sense for
you?

>
>> Regarding bindings for the domain latencies, I will post that as a
>> separate patch soonish.
>
> It probably makes sense to look at latency bindings as a whole series.

Well, unless you insist, I would rather look at this first.

The domain latencies might be a bit more complex and those shouldn't
affect how we describe device latencies, or you think so?

Kind regards
Uffe
