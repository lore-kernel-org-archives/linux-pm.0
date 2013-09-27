From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: highbank: cpuidle: convert to platform driver
Date: Fri, 27 Sep 2013 07:29:27 -0500
Message-ID: <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:36864 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3I0M32 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 08:29:28 -0400
Received: by mail-qc0-f171.google.com with SMTP id x19so1639554qcw.16
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 05:29:27 -0700 (PDT)
In-Reply-To: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> As the ux500 and the kirkwood driver, make the calxeda driver a platform driver
>
> [Compiled only]
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-highbank/highbank.c |    8 ++++++++
>  drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)

Looks fine to me, but this will conflict with my series. Perhaps I can
pick this up as part of that.

Rob
