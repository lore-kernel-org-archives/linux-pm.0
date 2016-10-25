From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
Date: Tue, 25 Oct 2016 10:24:40 -0600
Message-ID: <20161025162440.GA48977@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
 <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
 <383a62dd-b4d7-f764-baf1-ff73691b3cbc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33943 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbcJYQYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 12:24:44 -0400
Received: by mail-pf0-f179.google.com with SMTP id n85so5477143pfi.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 09:24:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <383a62dd-b4d7-f764-baf1-ff73691b3cbc@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>

On Tue, Oct 25 2016 at 09:59 -0600, Sudeep Holla wrote:
>
>
>On 25/10/16 16:26, Lina Iyer wrote:
>>Update domain-idle-state binding to use "domain-idle-state" compatible
>>from Documentation/devicetree/bindings/arm/idle-states.txt.
>>
>>Cc: <devicetree@vger.kernel.org>
>>Cc: Rob Herring <robh@kernel.org>
>>Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>---
>> Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>
>>diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>>index e165036..6fb53a3 100644
>>--- a/Documentation/devicetree/bindings/power/power_domain.txt
>>+++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>@@ -30,8 +30,9 @@ Optional properties:
>>    available in the next section.
>>
>> - domain-idle-states : A phandle of an idle-state that shall be soaked into a
>>-                generic domain power state. The idle state definitions are
>>-                compatible with arm,idle-state specified in [1].
>>+                generic domain power state. The idle state definitions must be
>>+                compatible with "domain-idle-state"
>
>I would reword the below a bit different so that it's flexible to be
>reused without "arm,idle-state".
>
>>as well as
>>+                "arm,idle-state" as defined in [1].
>
>'Idle states that are "arm,idle-state" compatible are generally
>"domain-idle-state" compatible as well if it's a PM domain.'
>
I believe we should have both compatible strings. Per [1], any CPU that
follows the idle state compatible *must* have "arm,idle-state" as a
compatible. Since we are re-using the same compatible, its only correct
that we retain what is already spec'd up in [1] and in addition provide
this new compatible.

Thanks,
Lina

>or something like that in line with what's in patch 2/4.
>
>That would give us the scope of reuse of "domain-idle-state" in device
>for future. Also it aligns with your patch 4/4.
>
>Otherwise, it looks good.
>
>-- 
>Regards,
>Sudeep
