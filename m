From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [RFC PATCH 0/2] PM / OPP: updates to enable sharing OPPs info
Date: Tue, 30 Jul 2013 19:00:15 +0100
Message-ID: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53212 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab3G3SAW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 14:00:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi,

These are couple of updates to existing PM/OPP library to support
sharing of OPPs between different device nodes.

Currently all the cpu nodes are parsed until the OPPs are found. This
is essential to support cpuhotplug without having to replicate OPP
information in all the cpu nodes.

However in systems with multiple cpu power domain, its better to have
OPP entry for each cpu. To avoid replication, phandle can be specified
to the node which contains the full OPP information.

Previously I had posted these patch[1] but didn't get much review.
Previous approach mixed both OPP values and the phandle in the same propert=
y.
The current approach adds new (optional) property to hold phandle if OPPs a=
re
shared. This makes it simpler and easier to be backward compatible.

Regards,
Sudeep

[1] https://lkml.org/lkml/2013/5/1/84

Sudeep KarkadaNagesha (2):
  PM / OPP: add support to specify phandle of another node for OPP
  PM / OPP: check for existing OPP list when initialising from device
    tree

 Documentation/devicetree/bindings/power/opp.txt | 114 ++++++++++++++++++++=
+---
 drivers/base/power/opp.c                        |  18 +++-
 2 files changed, 118 insertions(+), 14 deletions(-)

--=20
1.8.1.2


