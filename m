From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/4] Avoid duplicate registering of ACPI and native
 power-supplies
Date: Mon, 20 Mar 2017 15:18:24 +0200
Message-ID: <1490015904.19767.111.camel@linux.intel.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
         <20170320013305.v4mof5qoie3w7xdb@earth>
         <5bdbcb12-57c1-13cf-a591-22c9334d85b6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753140AbdCTNna (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 09:43:30 -0400
In-Reply-To: <5bdbcb12-57c1-13cf-a591-22c9334d85b6@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 2017-03-20 at 14:11 +0100, Hans de Goede wrote:
> On 20-03-17 02:33, Sebastian Reichel wrote:
> > On Thu, Mar 16, 2017 at 05:15:57PM +0100, Hans de Goede wrote:

> we've some extra magic in the fuel-gauge's probe method to see
> if it really is the one we want like this:
> 
>          status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP",
> NULL, &ptyp);

Just a side note. Looks like abusing (?) ACPI is not limited to GPIO
resources and stuff. I think we will see more stuff due to Windows
driver developers don't give a sh*t to follow standards, consistency,
and in some cases even common sense. For above case they might have used
_UID or _CID (compatible ID) + _HID (exact ID of the type of device) or
something else which is standard / more common.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
