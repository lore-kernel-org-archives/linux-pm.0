From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/3] PM / OPP: updates to enable sharing OPPs info
Date: Wed, 18 Sep 2013 11:58:10 +0100
Message-ID: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>

Hi,

These are few updates to existing device tree binding and the PM/OPP
library to support sharing of OPPs between different device nodes.

Currently all the cpu nodes are parsed until the OPPs are found. This
is essential to support cpuhotplug without having to replicate OPP
information in all the cpu nodes.

However in systems with multiple cpu power domain, its better to have
OPP entry for each cpu. To avoid replication, phandle can be specified
to the node which contains the full OPP information.

An RFC version was posted [1] and based on the discussion it was
preferred to use phandle to a shared OPP table in a separate node
rather than creating indirect linkage to the device with which it share
the clock as it could be problematic. E.g. the bootloaders can remove
cpu nodes if there are not used.

Also I am retaining 'operating-points-phandle' property name, as it makes
more sense now.

The table node containing all the OPPs and device nodes pointing to an
entry into it through phandle might also solve the problem of describing
multiple OPP profiles.

Regards,
Sudeep

[1] http://www.spinics.net/lists/cpufreq/msg06524.html

Sudeep KarkadaNagesha (3):
  PM / OPP: extend DT binding to specify phandle of another node for OPP
  PM / OPP: add support to specify phandle of another node for OPP
  PM / OPP: check for existing OPP list when initialising from device
    tree

 Documentation/devicetree/bindings/power/opp.txt | 152 ++++++++++++++++++++++--
 drivers/base/power/opp.c                        |  18 ++-
 2 files changed, 156 insertions(+), 14 deletions(-)

-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
