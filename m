From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] Avoid duplicate registering of ACPI and native power-supplies
Date: Mon, 20 Mar 2017 22:55:24 +0100
Message-ID: <1562192.FHYN0qn4Dl@aspire.rjw.lan>
References: <20170316161601.32267-1-hdegoede@redhat.com> <20170320013305.v4mof5qoie3w7xdb@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43164 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753601AbdCTWA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 18:00:57 -0400
In-Reply-To: <20170320013305.v4mof5qoie3w7xdb@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, March 20, 2017 02:33:05 AM Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Mar 16, 2017 at 05:15:57PM +0100, Hans de Goede wrote:
> > The last 2 patches of this series depend on the first 2, as such it might
> > be better to merge all 4 through the acpi tree if Sebastius is ok with
> > that.
> > 
> > Otherwise these patches are pretty self-explanatory.
> 
> I'm fine with this going through acpi. I wonder if acpi has a method
> to avoid loading the generic drivers in the first place, though. This
> solution is not very nice.

There might be a list of device IDs forcing the ->match callback to fail, but
I'm not sure that would be a viable approach in this particular case from the
top of my head.

Thanks,
Rafael
