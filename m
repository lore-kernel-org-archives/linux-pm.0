From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH 0/2] thermal: of: Fix for cooling devices
Date: Tue, 13 Jan 2015 17:51:20 +0000
Message-ID: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48198 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbbAMRv2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 12:51:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@arm.com, punit.agrawal@arm.com

This set of patches aims at solving the problem=20
due to which the thermal_zone_params are not populated in=20
of-thermal. This results in the weight parameter not being=20
propagated to the governor correctly.

We solve this problem by introducing a match function to=20
replace the ops->bind and also by correctly populating the
thermal_bind_params and thermal_zone_params which involves
parsing the __thermal_bind_params and creating a parsed version
as an internal data structure) which optimizes the match callback.

Kapileshwar Singh (2):
  thermal: of: Match function to pass bindparam index
  thermal: of: Match function for of-thermal

 drivers/thermal/of-thermal.c   |  340 ++++++++++++++++++++++++++++++++----=
----
 drivers/thermal/thermal_core.c |    4 +-
 include/linux/thermal.h        |    2 +-
 3 files changed, 281 insertions(+), 65 deletions(-)

--=20
1.7.9.5


