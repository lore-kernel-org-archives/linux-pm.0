From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 0/2] PM / QoS: Device resume latency framework fix
Date: Tue, 07 Nov 2017 02:17:43 +0100
Message-ID: <2941273.uOhv3ydaDP@aspire.rjw.lan>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2520927.XkLgALY3I0@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Friday, November 3, 2017 12:42:57 PM CET Rafael J. Wysocki wrote:
> On Thursday, November 2, 2017 12:00:27 AM CET Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This series is a replacement for commit 0cc2b4e5a020 (PM / QoS: Fix device
> > resume latency PM QoS) that had to be reverted due to problems introduced by it.
> > 
> > This time the genpd PM QoS governor is first updated to be more consistent
> > and the PM QoS changes are made on top of that which simplifies the second
> > patch quite a bit.
> > 
> > This is based on the linux-next branch from linux-pm.git as of now (should
> > also apply to the current mainline just fine).
> > 
> > Please test if you can or let me know if you have any comments.
> 
> The v2 removes a couple of redundant checks from the first patch (and add
> comments to explain why the checks are not needed) and fixes up the
> "no constraint" value collision with a valid constraint multiplied by
> NSEC_PER_USEC in the second patch.
> 
> Please test if possible and let me know about any issues.

The v3 restores the handling of child devices that don't belong to any
domains handled by genpd as pointed out by Ulf, but it should not affect
test results reported so far, so the tags from Reinette and Geert are
there.

Thanks,
Rafael
