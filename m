From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 S3
Date: Wed, 13 Jun 2018 15:58:27 +0300
Message-ID: <20180613125827.GZ2384@lahna.fi.intel.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan>
 <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
 <1568228.RgPNub1osy@aspire.rjw.lan>
 <6a387b8b67497fa4a656c252a010d6d4e72e7774.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a387b8b67497fa4a656c252a010d6d4e72e7774.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kai Heng Feng <kai.heng.feng@canonical.com>, Ulf Hansson <ulf.hansson@linaro.org>, P HeLiOn <perryhelionsemail@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2018 at 03:53:07PM +0300, Andy Shevchenko wrote:
> On Wed, 2018-06-13 at 13:17 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> > runtime PM and system sleep handling) introduced a system suspend
> > regression on some machines, but the only functional change made by
> > it was to cause the PM quirks in the LPSS to also be used during
> > system suspend and resume.  While that should always work for
> > suspend-to-idle, it turns out to be problematic for S3
> > (suspend-to-RAM).
> > 
> > To address that issue restore the previous S3 suspend and resume
> > behavior of the LPSS to avoid applying PM quirks then.
> > 
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Also,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
