From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: [RFT][PATCH v2 1/2] PM / domains: Rework governor code to be
 more consistent
Date: Sun, 5 Nov 2017 23:47:50 -0800
Message-ID: <20171106074748.GA8303@intel.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan>
 <2520927.XkLgALY3I0@aspire.rjw.lan>
 <1780873.Ca3tjQj9XB@aspire.rjw.lan>
 <20171104023401.GB29203@intel.com>
 <CAJZ5v0jXz7FCgmivjwLL-yfK2hHbW2bGAQGjb4YS4cY0JxDQ8w@mail.gmail.com>
Reply-To: ramesh.thomas@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdKFHyf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Nov 2017 02:54:35 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jXz7FCgmivjwLL-yfK2hHbW2bGAQGjb4YS4cY0JxDQ8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Alex Shi <alex.shi@linaro.org>

On 2017-11-04 at 12:24:15 +0100, Rafael J. Wysocki wrote:
> On Sat, Nov 4, 2017 at 3:34 AM, Ramesh Thomas <ramesh.thomas@intel.com> wrote:
> > On 2017-11-03 at 12:47:20 +0100, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The genpd governor currently uses negative PM QoS values to indicate
> >> the "no suspend" condition and 0 as "no restriction", but it doesn't
> >> use them consistently.  Moreover, it tries to refresh QoS values for
> >> already suspended devices in a quite questionable way.
> >>
> >> For the above reasons, rework it to be a bit more consistent.
> >>
> >> First off, note that dev_pm_qos_read_value() in
> >> dev_update_qos_constraint() and __default_power_down_ok() is
> >> evaluated for devices in suspend.  Moreover, that only happens if the
> >> effective_constraint_ns value for them is negative (meaning "no
> >> suspend").  It is not evaluated in any other cases, so effectively
> >> the QoS values are only updated for devices in suspend that should
> >> not have been suspended in the first place.  In all of the other
> >> cases, the QoS values taken into account are the effective ones from
> >> the time before the device has been suspended, so generally devices
> >> need to be resumed and suspended again for new QoS values to take
> >> effect anyway.  Thus evaluating dev_update_qos_constraint() in
> >> those two places doesn't make sense at all, so drop it.
> >>
> >> Second, initialize effective_constraint_ns to 0 ("no constraint")
> >> rather than to (-1) ("no suspend"), which makes more sense in
> >> general and in case effective_constraint_ns is never updated
> >> (the device is in suspend all the time or it is never suspended)
> >> it doesn't affect the device's parent and so on.
> >>
> >> Finally, rework default_suspend_ok() to explicitly handle the
> >> "no restriction" special case.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> 
> [cut]
> 
> > Looks good to me.
> >
> > Acked-by: Ramesh Thomas <ramesh.thomas@intel.com>
> 
> Thanks!
> 
> Do you actually mean Reviewed-by?

Yes, it should be Reveiewed-by for both patches!

Thanks,
Ramesh
