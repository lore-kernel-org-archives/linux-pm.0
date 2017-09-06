From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFT][PATCH v3 0/3] i2c: designware: Runtime PM aware system
 sleep handling
Date: Wed, 6 Sep 2017 16:46:09 +0300
Message-ID: <b85782da-47c1-1378-903e-9b4382700ed8@linux.intel.com>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <20170906110641.GT2477@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54222 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754725AbdIFNzT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Sep 2017 09:55:19 -0400
In-Reply-To: <20170906110641.GT2477@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>

On 09/06/2017 02:06 PM, Mika Westerberg wrote:
> On Wed, Sep 06, 2017 at 01:41:37AM +0200, Rafael J. Wysocki wrote:
>>> Please test if you can and let me know if anything breaks.
>>
>> That still applies. :-)
> 
> Tested on Dell XPS 9550 which is using intel-lpss and everything still
> works fine :)
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
Tested on platforms using ACPI LPSS PM domain and intel-lpss MFD driver.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
