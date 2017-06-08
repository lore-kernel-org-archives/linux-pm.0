From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Thu, 8 Jun 2017 15:42:19 +0200
Message-ID: <CAKfTPtCVsDkjTx5u9ecDj0P2zJ2w3LVRDGiGL2XMT4eES2tVpg@mail.gmail.com>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
 <CAKfTPtBvc-AiQ67P1L2bYtg=0vzzGwT=pTPM7thT-TxH-KKstg@mail.gmail.com> <CAMBp1jNWrosu4vaFwqy4cKs69r3-zX_b06-09eitCcfteHBG2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34328 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdFHNmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 09:42:46 -0400
Received: by mail-lf0-f45.google.com with SMTP id v20so18233155lfa.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 06:42:45 -0700 (PDT)
In-Reply-To: <CAMBp1jNWrosu4vaFwqy4cKs69r3-zX_b06-09eitCcfteHBG2w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Wangtao <jean.wangtao@linaro.org>
Cc: edubezval@gmail.com, javi.merino@kernel.org, viresh kumar <viresh.kumar@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Tao Wang <kevin.wangtao@hisilicon.com>, "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng@hisilicon.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com

On 8 June 2017 at 14:59, Jean Wangtao <jean.wangtao@linaro.org> wrote:
>
> Hi Vincent,
>
> 2017=E5=B9=B46=E6=9C=888=E6=97=A5 =E4=B8=8B=E5=8D=883:19=EF=BC=8C"Vincent=
 Guittot" <vincent.guittot@linaro.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kevin,
>
> On 5 June 2017 at 11:07, Tao Wang <kevin.wangtao@hisilicon.com> wrote:
>> cpu idle cooling driver performs synchronized idle injection across
>> all cpu in same cluster, offers a new method to cooling down cpu,
>> that is similar to intel_power_clamp driver, but is basically
>> designed for ARM platform.
>> Each cluster has its own idle cooling device, each core has its own
>> idle injection thread, idle injection thread use play_idle to enter
>> idle. In order to reach deepest idle state, all cores are aligned by
>> jiffies. the injected idle ratio can be controlled through cooling
>> device interface.
>>
>> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
>> ---
>>  drivers/thermal/Kconfig            |   13 +
>>  drivers/thermal/Makefile           |    3 +
>>  drivers/thermal/cpu_idle_cooling.c |  648
>> ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 664 insertions(+)
>>  create mode 100644 drivers/thermal/cpu_idle_cooling.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index b5b5fac..f78e85c 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -154,6 +154,19 @@ config CPU_THERMAL
>>
>>           If you want this support, you should say Y here.
>>
>> +config CPU_IDLE_THERMAL
>> +       tristate "generic cpu idle cooling support"
>> +       depends on CPU_FREQ
>
> Does CPU_IDLE_THERMAL really depend on CPU_FREQ ?
>
>
> because I use a interface of cpufreq to get cpu idle time and current wal=
l
> time, that cause the dependency

IMO, you should better use directly get_cpu_idle_time_us and remove
your dependency with cpufreq
Furthermore, get_cpu_idle_time from cpufreq may consider iowait as
busy time which could make sense for cpufreq but not really for idle
injection


>
> This dependency should be put for CPU_THERMAL_COMBO in the patch 2
>
>
> CPU_THERMAL_COMBO depend on CPU_THERMAL and CPU_IDLE_THERMAL, but the cod=
e
> of patch 2 have no direct relationship with cpufreq, so I didn't add the
> dependency

yes you're right, CPU_THERMAL_COMBO depends already on CPUFREQ

>
>
>> +       help
>> +         This implements the generic cpu cooling mechanism through idle
>> +         injection.
>> +
>> +         This will throttle cpu by injecting specified idle time in
>> +         a fixed cycle. All cpu in same cluster will enter idle
>> synchronously
>> +         to reach deepest idle state when injecting idle.
>> +
>> +         If you want this support, you should say Y here.
>> +
>>  config CLOCK_THERMAL
>>         bool "Generic clock cooling support"
>>         depends on COMMON_CLK
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 094d703..a4db66e 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -26,6 +26,9 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)   +=3D clock_cooli=
ng.o
>>  # devfreq cooling
>>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) +=3D devfreq_cooling.o
>>
>> +# cpu idle cooling
>> +obj-$(CONFIG_CPU_IDLE_THERMAL) +=3D cpu_idle_cooling.o
>> +
>>  # platform thermal drivers
>>  obj-y                          +=3D broadcom/
>>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)     +=3D qcom-spmi-temp-alarm.o
>> diff --git a/drivers/thermal/cpu_idle_cooling.c
>> b/drivers/thermal/cpu_idle_cooling.c
>> new file mode 100644
>> index 0000000..89a15c5
>> --- /dev/null
>
> [snip]
>
>
