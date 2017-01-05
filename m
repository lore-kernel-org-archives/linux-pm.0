From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 0/2] cpufreq: intel_pstate: Make it possible to change operation mode on the fly
Date: Thu, 05 Jan 2017 02:50:12 +0100
Message-ID: <21825845.nN3skUNMsO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This two-patch series adds a sysfs attribute to intel_pstate to allow user space
to change the way the driver works or disable it altogether.

Refer to the changelog of patch [2/2] for details.

The patches are on top of the linux-next branch of the linux-pm.git tree.

Thanks,
Rafael
