From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] PM: Avoid false-positive warnings in
 dev_pm_domain_set()
Date: Mon, 01 Feb 2016 16:17:17 +0200
Message-ID: <1454336237.32507.17.camel@linux.intel.com>
References: <1454335978-21467-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454335978-21467-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-02-01 at 16:12 +0200, Andy Shevchenko wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> There is a WARN_ON() in dev_pm_domain_set() that triggers on attempts
> to set the pm_domain pointer for devices with a driver bound.
>=20
> However, that WARN_ON() triggers on attempts to clear the pointer
> too and the test it uses is based on checking the device's
> p->knode_driver pointer which still is set when the device bus
> type's/driver's ->remove callback has been executed.=C2=A0=C2=A0This
> leads to false-positive warnings when bus type code calls
> dev_pm_domain_set() to clear the pm_domain pointer after
> invoking the driver's ->remove() callback.
>=20
> To avoid those false-positives, make dev_pm_domain_set() check
> if the pointer passed to it is NULL and skip the warning in
> that case.
>=20
> Fixes: 989561de9b51 (PM / Domains: add setter for dev.pm_domain)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oops, it is a wrong one, should be previous.

Btw, this one has been tested and went fine!

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
