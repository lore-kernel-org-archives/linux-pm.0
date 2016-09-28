From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 2/2] mfd: intel-lpss: Avoid resuming runtime-suspended
 lpss unnecessarily
Date: Wed, 28 Sep 2016 10:19:27 +0200
Message-ID: <1475050767.4635.2.camel@suse.com>
References: <cover.1475032126.git.yu.c.chen@intel.com>
         <6e14fa9659f23da041bc5e65edcd53c3e4845c74.1475032126.git.yu.c.chen@intel.com>
         <1475048574.4635.1.camel@suse.com> <20160928080907.GA4567@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbcI1ITc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Sep 2016 04:19:32 -0400
In-Reply-To: <20160928080907.GA4567@sharon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <len.brown@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 2016-09-28 at 16:09 +0800, Chen Yu wrote:

> Thanks for your reply. Do you mean we should add the logic to pm core?
> There is already one if the driver's
> .prepare() returns a positive number(aka, RPM_SUSPENDED), then pm core will keep

Yes, that makes sense.

	Sorry
		Oliver


