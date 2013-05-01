From: Sudeep.KarkadaNagesha@arm.com
Subject: [PATCH 0/2] PM / OPP: updates to enable sharing OPPs info
Date: Wed,  1 May 2013 12:11:17 +0100
Message-ID: <1367406679-21603-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48944 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759423Ab3EALLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2013 07:11:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

These are couple of updates to existing PM/OPP library to support
sharing of OPPs between different device nodes.

Currently all the cpu nodes are parsed until the OPPs are found. This
is essential to support cpuhotplug without having to replicate OPP
information in all the cpu nodes.

However in systems with multiple cpu power domain, its better to have
OPP entry for each cpu. To avoid replication, phandle can be specified
to the node which contains the full OPP information.

Sudeep KarkadaNagesha (2):
  PM / OPP: add support to specify phandle of another node for OPP
  PM / OPP: check for existing OPP list when initialising from device
    tree

 Documentation/devicetree/bindings/power/opp.txt |   41 +++++++++++++++++++=
++++
 drivers/base/power/opp.c                        |   35 ++++++++++++++-----
 2 files changed, 68 insertions(+), 8 deletions(-)

--=20
1.7.10.4


