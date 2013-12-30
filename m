From: Jane Li <jiel@marvell.com>
Subject: Re: [PATCH] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Mon, 30 Dec 2013 14:29:32 +0800
Message-ID: <52C112CC.4040306@marvell.com>
References: <1388136651-21883-1-git-send-email-jiel@marvell.com> <CAKohpokWMgXotgKWFmqOPzdoZME=frBQOjeU1uFJwQ778DHAKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:22816 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab3L3G3l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2013 01:29:41 -0500
In-Reply-To: <CAKohpokWMgXotgKWFmqOPzdoZME=frBQOjeU1uFJwQ778DHAKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


On 12/27/2013 05:40 PM, Viresh Kumar wrote:
> On 27 December 2013 15:00,  <jiel@marvell.com> wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> -static DEFINE_MUTEX(cpufreq_governor_lock);
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index dc196bb..4faafe7 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -254,6 +254,7 @@ struct cpufreq_driver {
>>
>>   int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>>   int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>> +static DEFINE_MUTEX(cpufreq_governor_lock);
> No way, this would never work. This would create separate locks
> in each file that includes cpufreq.h. And so the locks you are talking
> about wouldn't protect governor.

I checked my code, and found I lost following part.
My local code base is not exactly same as open source, and has included this.


diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index e6be635..c4d0ee6 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -19,6 +19,7 @@
  #include <linux/export.h>
  #include <linux/kernel_stat.h>
  #include <linux/slab.h>
+#include <linux/cpufreq.h>

  #include "cpufreq_governor.h"

> Have you actually tested this code? If this fixes the breakage you
> saw? If this fixes it then you need to do better investigation of your
> problem.

Yes, I test it. After adding cpufreq_governor_lock in gov_queue_work() and running same test, there is no debugobjects warning.

> you actually need to remove the static keyword from cpufreq.c file.
> Nothing else.

Modify cpufreq_governor_lock definition. Do you think it is OK?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 16d7b4a..185c9f5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -39,7 +39,7 @@ static struct cpufreq_driver *cpufreq_driver;
  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data_fallback);
  static DEFINE_RWLOCK(cpufreq_driver_lock);
-static DEFINE_MUTEX(cpufreq_governor_lock);
+DEFINE_MUTEX(cpufreq_governor_lock);
  static LIST_HEAD(cpufreq_policy_list);

  #ifdef CONFIG_HOTPLUG_CPU
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index e6be635..485ee0d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -22,6 +22,8 @@

  #include "cpufreq_governor.h"

+extern struct mutex cpufreq_governor_lock;
+
  static struct attribute_group *get_sysfs_attr(struct dbs_data *dbs_data)
  {
         if (have_governor_per_policy())

