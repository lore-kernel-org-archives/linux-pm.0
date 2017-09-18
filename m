From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by
 the firmware"
Date: Mon, 18 Sep 2017 11:00:29 +0300
Message-ID: <1505721629.25945.273.camel@linux.intel.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
         <CAL9uMOGf6vsMfsp4wFX+LNxR_UTiYyWpFWPW7L8nGivLi-0uQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:34643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbdIRIAc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Sep 2017 04:00:32 -0400
In-Reply-To: <CAL9uMOGf6vsMfsp4wFX+LNxR_UTiYyWpFWPW7L8nGivLi-0uQg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>, Johannes Stezenbach <js@sig21.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

On Wed, 2017-09-06 at 23:14 +0200, Carlo Caione wrote:
> On Wed, Sep 6, 2017 at 10:42 PM, Johannes Stezenbach <js@sig21.net>
> wrote:

> Also I will probably send an email tomorrow about this but today
> (coincidentally) I discovered that this fix is not working anymore on
> my platform. This is due to commit a49d25364df ("staging/atomisp: Add
> support for the Intel IPU v2"). I haven't had a chance yet to
> investigated why though.

When you are going to do, check as well my clean up series to atomisp.
I noticed the driver messes up the things it shouldn't touch at all.
I removed Intel MID related parts from it, so, I hope it will help you.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
