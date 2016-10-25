From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use correct compatibles
Date: Tue, 25 Oct 2016 13:49:34 -0700
Message-ID: <7hh980taqp.fsf@baylibre.com>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
        <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36633 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbcJYUtg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 16:49:36 -0400
Received: by mail-pf0-f170.google.com with SMTP id e6so125111312pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 13:49:36 -0700 (PDT)
In-Reply-To: <1477409199-52182-4-git-send-email-lina.iyer@linaro.org> (Lina
        Iyer's message of "Tue, 25 Oct 2016 08:26:38 -0700")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>

Lina Iyer <lina.iyer@linaro.org> writes:

> Update domain-idle-state binding to use "domain-idle-state" compatible
> from Documentation/devicetree/bindings/arm/idle-states.txt.
>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

With no current users for this, I don't see the point of adding a
compatible now.

IMO, this should wait and be added with the identified user we can
discuss it then.

Kevin
