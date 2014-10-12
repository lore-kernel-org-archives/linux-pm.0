From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v1 2/4] ARM: keystone: pm: switch to use generic pm domains
Date: Sun, 12 Oct 2014 05:57:05 -0700
Message-ID: <CAMAWPa96Kqg8r3GqJQoiSTspFnHo3gnWxzBtCpei7-nCXN+Dzw@mail.gmail.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
	<1412001499-19369-3-git-send-email-grygorii.strashko@ti.com>
	<542DA4D4.4070202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52760 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbaJLM5J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 12 Oct 2014 08:57:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C663620204
	for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2014 12:57:08 +0000 (UTC)
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com [209.85.217.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1BDF3201C0
	for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2014 12:57:06 +0000 (UTC)
Received: by mail-lb0-f181.google.com with SMTP id l4so5129190lbv.40
        for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2014 05:57:05 -0700 (PDT)
In-Reply-To: <542DA4D4.4070202@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, ulf.hansson@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

On 10/2/14 12:17 PM, Santosh Shilimkar wrote:
> On Monday 29 September 2014 10:38 AM, Grygorii Strashko wrote:
>> This patch switches Keystone 2 PM code to use Generic PM domains
>> instead of PM clock domains because of the lack of DT support
>> for the last.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---

[...]

>> Other than that patch looks fine to me. If Kevin is happy
>> with overall approach then we can proceed with this.

Looks good to me:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
