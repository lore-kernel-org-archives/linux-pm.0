From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v3 0/3] i2c: designware: Runtime PM aware system
 sleep handling
Date: Wed, 6 Sep 2017 13:14:50 +0200
Message-ID: <CAJZ5v0hWyT==K0PQMBwr7mcW-V_96Ld-WCHA+nhww3Y=yX-vMQ@mail.gmail.com>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan>
 <20170906110641.GT2477@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34784 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbdIFLOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 07:14:51 -0400
In-Reply-To: <20170906110641.GT2477@lahna.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>

On Wed, Sep 6, 2017 at 1:06 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Sep 06, 2017 at 01:41:37AM +0200, Rafael J. Wysocki wrote:
>> > Please test if you can and let me know if anything breaks.
>>
>> That still applies. :-)
>
> Tested on Dell XPS 9550 which is using intel-lpss and everything still
> works fine :)
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

OK, thanks!
