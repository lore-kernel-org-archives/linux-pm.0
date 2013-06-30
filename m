From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Mon, 01 Jul 2013 00:22:47 +0530
Message-ID: <51D07E7F.2030709@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:42394 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab3F3S4S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2013 14:56:18 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 1 Jul 2013 04:44:33 +1000
In-Reply-To: <51D06556.7080204@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 06/30/2013 10:35 PM, Toralf F=C3=B6rster wrote:
> On 06/30/2013 06:33 PM, Srivatsa S. Bhat wrote:
>> Toralf, can you please
>> try out the below patch and see if it improves anything? (Don't reve=
rt anything,
>> just apply the below diff on a problematic kernel and see if it solv=
es your
>> issue).
>=20
> applied on top of a66b2e5 - issue went away (either fixed or hidden n=
ow)
>=20

Cool! So here is the proper patch, with changelog added.

Regards,
Srivatsa S. Bhat


-----------------------------------------------------------------------=
------

=46rom: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume

Toralf F=C3=B6rster reported that the cpufreq ondemand governor behaves=
 erratically
(doesn't scale well) after a suspend/resume cycle. The problem was that=
 the
cpufreq subsystem's idea of the cpu frequencies differed from the actua=
l
frequencies set in the hardware after a suspend/resume cycle. Toralf bi=
sected
the problem to commit a66b2e5 (cpufreq: Preserve sysfs files across
suspend/resume).

Among other (harmless) things, that commit skipped the call to
cpufreq_update_policy() in the resume path. But cpufreq_update_policy()=
 plays
an important role during resume, because it is responsible for checking=
 if
the BIOS changed the cpu frequencies behind our back and resynchronize =
the
cpufreq subsystem's knowledge of the cpu frequencies, and update them
accordingly.

So, restore the call to cpufreq_update_policy() in the resume path to f=
ix
the cpufreq regression.

Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Tested-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/cpufreq_stats.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_=
stats.c
index fb65dec..591b6fb 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -349,6 +349,7 @@ static int __cpuinit cpufreq_stat_cpu_callback(stru=
ct notifier_block *nfb,
=20
 	switch (action) {
 	case CPU_ONLINE:
+	case CPU_ONLINE_FROZEN:
 		cpufreq_update_policy(cpu);
 		break;
 	case CPU_DOWN_PREPARE:


