From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: thermal: cpu_cooling: Power calculation when CPUs are hotplugged
Date: Wed, 11 Mar 2015 17:53:35 +0000
Message-ID: <1426096417-27522-1-git-send-email-kapileshwar.singh@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37269 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbbCKRxr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 13:53:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com, kapileshwar.singh@arm.com

The following patch series aims at correcting the requested power
calculation when CPUs are hotplugged out. These patches are based on
the "linus" branch of Eduardo's tree.

There is no need to update the cpu_dev pointer (cached) on the reception of=
 a
policy CPU update notifier from cpufreq. This is not required as OPPs
can be ascertained even if the CPU is offline.

cpufreq_get_requested power ensures that a CPU is online before calculating
the frequency for the CPUs and returns the power as 0 if all the CPUs
are offline in the cooling device.

Regards,
KP


