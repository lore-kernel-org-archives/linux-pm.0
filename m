From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/5] PM / OPP: updates to enable sharing OPPs info
Date: Tue,  1 Oct 2013 14:32:57 +0100
Message-ID: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

The table node containing all the OPPs and device nodes pointing to an
entry into it through phandle might also solve the problem of describing
multiple OPP profiles.

Regards,
Sudeep

Changes v1->v2:
	- Updated binding document as per Mark's suggestions
	- Added of_node_put for phandle as of_parse_phandle increments
	  the refcount
	- Updated user of OPP library(cpufreq/arm_big_little_dt) affected
	  by binding changes

Sudeep KarkadaNagesha (5):
  PM / OPP: extend DT binding to specify phandle of another node for OPP
  PM / OPP: add support to specify phandle of another node for OPP
  PM / OPP: check for existing OPP list when initialising from device
    tree
  cpufreq: arm_big_little_dt: enhance OPP error checking
  cpufreq: arm_big_little_dt: return success if OPP list already exists

 Documentation/devicetree/bindings/power/opp.txt | 161 ++++++++++++++++++++++--
 drivers/base/power/opp.c                        |  21 +++-
 drivers/cpufreq/arm_big_little_dt.c             |   5 +-
 3 files changed, 172 insertions(+), 15 deletions(-)

-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
