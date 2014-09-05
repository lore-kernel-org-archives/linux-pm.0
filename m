From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Fri, 5 Sep 2014 19:11:05 +0530
Message-ID: <CAJuA9ah7cxAySNObNjqEPdgwnTok3OiO81faex_8hJMNQtVU5g@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com>
	<53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan>
	<53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	<7h8umc60we.fsf@paris.lan>
	<CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
	<CAGa+x85-Anb+HsSUQRaaeex19-HK+yZDW0UpFBwAtsQ8Sf2Aqg@mail.gmail.com>
	<CAGa+x86jU8MR=r_xuaiorbNNyqrezb0b6Ozy-MPg9HvsARESOw@mail.gmail.com>
	<CAJuA9ajtsrY7zSDMs=c6BZ0AqERoBgvq++dTF4Dn673zGMfcgQ@mail.gmail.com>
	<CAMAWPa-8h5PNhgT+ApBhA8p=i+4oFOnYnQsQ4mK1JKwwAhpvpQ@mail.gmail.com>
	<CAJuA9ah5M_pXRMXPB6o7JLhgVUHM7kYo9HOV6Yxv4Z=hKMdG=w@mail.gmail.com>
	<7hmwah6cop.fsf@paris.lan>
	<CAJuA9ahe=9gdTaGcRb69syvRfwkkGMgDiiNfOMA9TBo42cWVZw@mail.gmail.com>
	<CAJuA9ag2pybyLDUyW43wMQu4PA1cB4V9c1bc7WB3xjqzhqNGTw@mail.gmail.com>
	<7hsik847p2.fsf@paris.lan>
	<CAJuA9aiXwgxrS_AYw5tt5GryhrtoOpK2RhhLcjxShNqswiCmqA@mail.gmail.com>
	<7hfvg74ioq.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:51398 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970AbaIENlI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 09:41:08 -0400
In-Reply-To: <7hfvg74ioq.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Chander Kashyap <k.chander@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, Sep 4, 2014 at 7:00 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Thomas Abraham <ta.omasab@gmail.com> writes:
>
>> On Thu, Sep 4, 2014 at 4:45 AM, Kevin Hilman <khilman@kernel.org> wrote:
>>> Hi Thomas,
>>>
>>> Thomas Abraham <ta.omasab@gmail.com> writes:
>>>
>>> [...]
>>>
>>>> A new branch [1] has been created using commits from exynos5-v3.17-rc1
>>>> branch + cpufreq + regulator + temp fixes. I have tested this branch
>>>> on Exynos5800 Chromebook2 and cpufreq works fine with both ondemand
>>>> and performance governors. Please let me know if there are any issues
>>>> with this new branch. It is based on v3.17-rc3.
>>>
>>> Excellent!  Thank you.
>>>
>>> The only thing missing now is the CPUidle support for 5800, and all
>>> that's needed for that is the compatible string patch[1] which Daniel
>>> has queued up.
>>>
>>> With that patch, display + CPUidle + CPUfreq are working pretty well on
>>> my exynos5800/chromebook2 with the big.LITTLE switcher disabled.  If I
>>> turn on the switcher, it boots OK, but as soon as I try to run powertop
>>> (upstream v2.6.1) it gets stuck.  Have you tried this branch with the
>>> switcher enabled?
>>
>> Yes, I have tested switcher + cpufreq + cpuidle with this branch and
>> there are no issues found. I haven't tested with powertop yet. I will
>> try and do that and let you know the result.
>>
>> You mentioned that when you run powertop, it gets stuck. When that
>> happens, is there any log on the console or does system just turn
>> unresponsive?
>
> The console is not responsive, but kernel seems busy because I see
> periodic timeout messages from the samsung clock driver.

Ok, I haven't tried to recreate this issue. I will try and do that.

>
> Note that I see these messages when things are functioning normally
> also.

I did notice this a few times before but today I was able to reproduce
this consistently with other test cases. This timeout is because the
CPU clock blocks of the cluster that has been turned down are being
reconfigured, which on Exynos will not work. The following is a
temporary patch which solves this issue.


>From b0c4057d428134fe12446431ede1d9a579fd1d05 Mon Sep 17 00:00:00 2001
From: Thomas Abraham <thomas.ab@samsung.com>
Date: Fri, 5 Sep 2014 17:11:10 +0530
Subject: [PATCH] TEMP: cpufreq/bL: let the CPU switch complete before
scaling frequency

On Exynos5420/Exyons5800, the clock blocks that make up the CPU clock
supply do no operate when the cluster in which they belong is powered off.
The CPU clock supply path is PLL -> Mux/Dividers -> CPU_clock.

In the arm_big_little CPUfreq driver, the frequency is scaled first and
then the CPU is switched to the new cluster. In case the switch was for
the first-man CPU in that new cluster, the frequency scaling step in
arm_big_little CPUfreq driver would not work for Exynos since the
in-bound cluster is powered off at that point. Note: On Exynos, the
cluster is powered off when all the CPUs in that cluster are powered off
which implies that the CPU clock blocks for that cluster do not operate
anymore.

So when using arm_big_little CPUfreq driver for Exynos, two changes are
required. The first change is to let the CPU to switch to the new cluster
before scaling the frequency. The second change is to ensure that the
switch has been completed before scaling the frequency.

With these changes, the message "wait_until_divider_stable: timeout in
divider stabilization" is not seen anymore.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/include/asm/bL_switcher.h |   15 ++++++++++++++-
 drivers/cpufreq/arm_big_little.c   |    9 ++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/bL_switcher.h
b/arch/arm/include/asm/bL_switcher.h
index 1714800..d609b86 100644
--- a/arch/arm/include/asm/bL_switcher.h
+++ b/arch/arm/include/asm/bL_switcher.h
@@ -20,9 +20,22 @@ typedef void (*bL_switch_completion_handler)(void *cookie);
 int bL_switch_request_cb(unsigned int cpu, unsigned int new_cluster_id,
                         bL_switch_completion_handler completer,
                         void *completer_cookie);
+
+static void bL_switch_complete_cb(void *cookie)
+{
+        struct completion *switch_complete = (struct completion *) cookie;
+        complete(switch_complete);
+}
+
 static inline int bL_switch_request(unsigned int cpu, unsigned int
new_cluster_id)
 {
-       return bL_switch_request_cb(cpu, new_cluster_id, NULL, NULL);
+       struct completion complete;
+
+       init_completion(&complete);
+       bL_switch_request_cb(cpu, new_cluster_id, &bL_switch_complete_cb,
+                                       &complete);
+       wait_for_completion(&complete);
+       return 0;
 }

 /*
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index a46c223..baeff47 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -129,6 +129,13 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32
new_cluster, u32 rate)
        int ret;
        bool bLs = is_bL_switching_enabled();

+       /* Switch cluster */
+       if (old_cluster != new_cluster) {
+               pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
+                               __func__, cpu, old_cluster, new_cluster);
+               bL_switch_request(cpu, new_cluster);
+       }
+
        mutex_lock(&cluster_lock[new_cluster]);

        if (bLs) {
@@ -167,7 +174,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32
new_cluster, u32 rate)
                                __func__, cpu, old_cluster, new_cluster);

                /* Switch cluster */
-               bL_switch_request(cpu, new_cluster);
+               /*bL_switch_request(cpu, new_cluster);*/

                mutex_lock(&cluster_lock[old_cluster]);

-- 
1.6.6.rc2

>
> Kevin
>
>
> [1]
> [  337.832031] wait_until_divider_stable: timeout in divider stablization
> [  337.847024] wait_until_divider_stable: timeout in divider stablization
> [  337.862024] wait_until_divider_stable: timeout in divider stablization
> [  337.957028] wait_until_divider_stable: timeout in divider stablization
> [  337.972024] wait_until_divider_stable: timeout in divider stablization
> [  337.987024] wait_until_divider_stable: timeout in divider stablization
> [  340.082029] wait_until_divider_stable: timeout in divider stablization
> [  340.097024] wait_until_divider_stable: timeout in divider stablization
> [  340.112024] wait_until_divider_stable: timeout in divider stablization
> [  346.242030] wait_until_divider_stable: timeout in divider stablization
> [  346.257024] wait_until_divider_stable: timeout in divider stablization
> [  346.272024] wait_until_divider_stable: timeout in divider stablization
> [  348.322029] wait_until_divider_stable: timeout in divider stablization
> [  348.337025] wait_until_divider_stable: timeout in divider stablization
> [  348.352024] wait_until_divider_stable: timeout in divider stablization
