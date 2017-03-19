From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Sun, 19 Mar 2017 16:54:37 +0200
Message-ID: <1489935277.19767.89.camel@linux.intel.com>
References: <20170318071019.4561-1-liam@networkimprov.net>
         <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
         <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
         <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
         <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:24985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbdCSPAs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Mar 2017 11:00:48 -0400
In-Reply-To: <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>, Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Sat, 2017-03-18 at 17:57 -0700, Liam Breck wrote:

>> Assuming the platform_data has sane values like uA that means
> > re-implementing most of the bq24190 driver in the code filling
> > the platform data (to go from register values to uA) that does
> > not seem like a sane approach when a simple do not reset
> > flag suffices. Note also see below for another way to deal
> > with this.
> 
> I am suggesting you treat platform_data like a DT node: fill it with
> board-specific params. Don't compute the params, read them manually
> via /sys/class/...-charger/f_* and hard-code them for this board. That
> gives you control over the charger config. You've already found that
> you need that given the high voltage setting.

Guys, did you see my mail regarding all these?

Repeating myself here:

"I would not extend platform data at all.
For GPIO we may use GPIO lookup tables, for the rest -- unified (built-
in) device properties API.

Consider to get rid of 
 include/linux/power/bq24190_charger.h
completely."

Do you consider that approach? If no, why not?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
