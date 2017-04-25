From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume
 when RT suspended
Date: Tue, 25 Apr 2017 14:36:04 +0300
Message-ID: <1493120164.24567.194.camel@linux.intel.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
         <CAPDyKFqfDYg1ZzcJ2Z7md5CD6tYWRMwi4N8M82DesG_ybVKHMw@mail.gmail.com>
         <da36d4c0-7bcb-be18-6c8c-9fd714e2f1e0@linux.intel.com>
         <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946957AbdDYLgJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Apr 2017 07:36:09 -0400
In-Reply-To: <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, 2017-04-25 at 13:12 +0200, Ulf Hansson wrote:
> On 25 April 2017 at 13:08, Jarkko Nikula <jarkko.nikula@linux.intel.co
> m> wrote:
> > On 04/25/2017 12:24 PM, Ulf Hansson wrote:

> > > To me, the proper solution is to use the
> > > pm_runtime_force_suspend|resume() helpers to deal with system
> > > suspend/resume. However I understand that the behavior of the ACPI
> > > PM
> > > domain currently prevents us from doing this. That said, perhaps
> > > we
> > > should instead try to make the ACPI PM domain to better
> > > collaborate
> > > with drivers using pm_runtime_force_suspend|resume()? I have been
> > > investigating that and started to cook some patches, although I
> > > have
> > > not yet been able to post something. If you think it could make
> > > sense,
> > > I can pick it up.
> > > 
> > 
> > That's a good idea. I didn't think about it at all.
> 
> Okay, thanks! I will continue to look into this and try to submit
> something within a reasonable time frame, keep you posted.

But please keep in mind that ACPI PM domain for BayTrail / CherryTrail
is used by several IPs including most nasty GPDMA case. If something
breaks that it would be show stopper.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
