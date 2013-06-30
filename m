From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sun, 30 Jun 2013 22:03:56 +0530
Message-ID: <51D05DF4.50704@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:46529 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab3F3QhT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2013 12:37:19 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sun, 30 Jun 2013 22:01:06 +0530
In-Reply-To: <8029836.CFiJCXmRQ0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 06/30/2013 07:52 PM, Rafael J. Wysocki wrote:
> On Saturday, June 29, 2013 07:50:11 PM Toralf F=C3=B6rster wrote:
>> The latest bisect attempt gave :
>>
>> commit a66b2e503fc79fff6632d02ef5a0ee47c1d2553d
>> Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> Date:   Wed May 15 21:47:17 2013 +0200
>>
>>     cpufreq: Preserve sysfs files across suspend/resume
>>
>>     The file permissions of cpufreq per-cpu sysfs files are not pres=
erved
>>     across suspend/resume because we internally go through the CPU
>>     Hotplug path which reinitializes the file permissions on CPU onl=
ine.
>>
>>     But the user is not supposed to know that we are using CPU hotpl=
ug
>>     internally within suspend/resume (IOW, the kernel should not sil=
ently
>>     wreck the user-set file permissions across a suspend cycle).
>>     Therefore, we need to preserve the file permissions as they are
>>     across suspend/resume.
>>
>>     The simplest way to achieve that is to just not touch the sysfs =
files
>>     at all - ie., just ignore the CPU hotplug notifications in the
>>     suspend/resume path (_FROZEN) in the cpufreq hotplug callback.
>>
>>     Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
>>     Reported-by: Durgadoss R <durgadoss.r@intel.com>
>>     Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.co=
m>
>>     Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>>
>>
>> To get a more reliable bisect result I had to start BOINC before (4
>> childs each with nice -19 started)
>=20
> Well, to be honest, I'm not really sure how the above commit can caus=
e the
> problem you're seeing to happen ...
>=20
> Srivatsa, Viresh, any ideas?
>

I tried to look up what problem is being reported, but apart from the h=
int
from the subject line, I couldn't find anything more. So, guessing that=
 there
is something wrong with cpufreq after an s3 cycle, Toralf, can you plea=
se
try out the below patch and see if it improves anything? (Don't revert =
anything,
just apply the below diff on a problematic kernel and see if it solves =
your
issue).


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


