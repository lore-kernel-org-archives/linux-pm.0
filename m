From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/5] cpufreq: intel_pstate: HW support changes, limits rework and documentation
Date: Wed, 22 Mar 2017 23:50:09 +0100
Message-ID: <2025489.DxMTzKos7o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi All,

This series of patches makes changes to intel_pstate that will modify its
behavior in visible ways and add documentation describing the driver's
interface and behavior after those changes.  It is targeted at 4.12.

The functional patches are based on the current linux-next branch of the
linux-pm tree:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next

and the documentation patch depends on this one:

https://patchwork.kernel.org/patch/9622259/

in the documentation tree now (AFAICS).

Please refer to patch changelogs for more information.

Thanks,
Rafael
