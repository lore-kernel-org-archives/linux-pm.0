From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Mon, 22 Feb 2016 11:25:02 -0800
Message-ID: <56CB608E.5080107@linux.intel.com>
References: <000401d16bfc$21338450$639a8cf0$@net> <87a8mv9ujm.fsf@iki.fi>
 <36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
 <87egc6zc2q.fsf@iki.fi>
 <36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
 <56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
 <20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>
 <20160222164114.GU28226@vireshk-i7> <20160222164822.GV28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7906 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbcBVTZk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Feb 2016 14:25:40 -0500
In-Reply-To: <20160222164822.GV28226@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arto Jantunen <viiru@iki.fi>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 02/22/2016 08:48 AM, Viresh Kumar wrote:
> On 22-02-16, 22:11, Viresh Kumar wrote:
>>> Thanks. I tried this, and somewhat surprisingly it doesn't change the
>>> result. I guess we are back to doing a full bisect?
>> Good. That was kind of what I expected, so no surprise :)
>>
>> I think bisect wouldn't be that difficult, please try :)
> Okay, for record, I looked at all the patches that went into 4.5-rcs
> into drivers/cpufreq/ directory and there is absolutely nothing in
> there, that could have caused this. I suspect some x86 core changes
> have broken this stuff.
Correct. There is no change submitted in this release cycle to impact to 
cpufreq drivers.

Arto,

I want to understand your issue. I just gave a try by setting default 
governors to ondemand and performance and changing them on fly.
I didn't see any issue. So try the steps below. It doesn't work for you 
then I have some dumps to send at the end.

Verify that you are using HWP
[linux]$ dmesg | grep -i HWP
[    2.136799] intel_pstate: HWP enabled


1. Test with default governor as powersave

Default governor is on_damand, which will be "powersave" for 
Intel_Pstate driver. In kernel config
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y

[linux ~]$ uname -a
Linux spandruv-mobl.jf.intel.com 4.5.0-rc2+ #13 SMP Fri Feb 19 13:58:16 
PST 2016 x86_64 x86_64 x86_64 GNU/Linux

[linux ~]$ sudo cpupower frequency-info
analyzing CPU 0:
   driver: intel_pstate
   CPUs which run at the same hardware frequency: 0
   CPUs which need to have their frequency coordinated by software: 0
   maximum transition latency: 0.97 ms.
   hardware limits: 400 MHz - 3.10 GHz
   available cpufreq governors: performance, powersave
   current policy: frequency should be within 400 MHz and 3.10 GHz.
                   The governor "powersave" may decide which speed to use
                   within this range.
   current CPU frequency is 503 MHz (asserted by call to hardware).
   boost state support:
     Supported: yes
     Active: yes

[linux ~]$ sudo turbostat -i 1
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      36    4.59     776    1512
        0      42    5.10     817    1511
        2      22    2.91     766    1512
        1      44    5.74     770    1512
        3      34    4.61     746    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      17    3.06     551    1512
        0      32    5.97     543    1512
        2       7    1.26     546    1512
        1      17    2.94     570    1512
        3      11    2.06     550    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      24    4.45     541    1512
        0      21    3.81     557    1512
        2      25    4.76     525    1512
        1      35    6.35     552    1512
        3      15    2.90     525    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      17    3.25     524    1512
        0      20    3.71     530    1512
        2      14    2.78     510    1512
        1       8    1.56     516    1512
        3      26    4.97     529    1512

Now change the default policy to performance
[linux]$ sudo cpupower frequency-set -g performance
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3

[linux ~]$ sudo turbostat -i 1
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      33    1.14    2925    1512
        0      19    0.66    2879    1512
        2      83    2.79    2993    1512
        1      13    0.48    2662    1512
        3      18    0.63    2879    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      34    1.17    2942    1512
        0      19    0.64    2914    1512
        2      83    2.77    2996    1512
        1      24    0.84    2812    1512
        3      12    0.42    2888    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      64    2.30    2779    1512
        0      93    3.36    2768    1512
        2      49    1.73    2850    1512
        1      29    1.16    2497    1512
        3      85    2.96    2860    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      31    1.08    2828    1512
        0      15    0.57    2582    1512
        2      18    0.67    2645    1512
        1      31    1.12    2792    1512
        3      59    1.97    2982    1512

As expected busy MHz changed to possible max.

[linux]$ sudo cpupower frequency-set -g powersave
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3

[linux ~]$ sudo turbostat -i 1
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      22    3.31     672    1512
        0      19    2.40     809    1511
        2      19    2.18     863    1512
        1      41    7.10     584    1512
        3       9    1.57     596    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      57    7.59     749    1512
        0      59    6.78     876    1512
        2      54    6.96     770    1512
        1      71   10.18     700    1512
        3      43    6.43     672    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      78   10.50     739    1512
        0     115   14.19     811    1512
        2      86   11.08     774    1512
        1      53    6.98     758    1512
        3    CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y  57 9.75     
582    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      51    7.14     720    1512
        0      35    4.95     710    1512
        2      47    5.88     798    1512
        1      78    9.32     832    1512
        3      46    8.40     546    1512

Busy MHz is no longer max possible.

2.
Now set the default governor in kernel config as "performance" and rebuild.
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y

[linux ~]$ sudo turbostat -i 1
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -     323   12.00    2689    1512
        0     293   11.25    2607    1512
        2     220    8.58    2571    1512
        1     176    6.87    2565    1512
        3     601   21.30    2821    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      37    1.26    2913    1512
        0      74    2.47    2988    1512
        2      35    1.18    2920    1512
        1      21    0.79    2683    1512
        3      18    0.61    2891    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      30    1.04    2879    1512
        0      64    2.17    2970    1512
        2      16    0.56    2901    1512
        1      15    0.57    2620    1512
        3      25    0.88    2810    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      48    1.65    2887    1512
        0      36    1.29    2814    1512
        2      77    2.59    2957    1512
        1      23    0.87    2661    1512
        3      55    1.85    2943    1512

No change to powersave
[linux ~]$ sudo cpupower frequency-set -g powersave
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3
[linux ~]$ sudo turbostat -i 1
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      18    3.22     565    1512
        0      16    2.51     647    1511
        2       8    1.45     551    1512
        1      33    5.94     551    1512
        3      16    2.98     532    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      20    3.57     548    1512
        0      14    2.06     685    1512
        2      13    2.38     527    1512
        1      16    2.85     559    1512
        3      36    6.99     511    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      20    3.62     542    1512
        0      17    2.87     597    1512
        2      13    2.18     585    1512
        1      36    7.02     509    1512
        3      13    2.41     536    1512

Change back to performance
[linux ~]$ sudo cpupower frequency-set -g performance
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3
[linux ~]$ sudo turbostat -i 1
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      33    1.14    2898    1512
        0      78    2.61    2998    1513
        2      24    0.86    2815    1512
        1      16    0.61    2618    1512
        3      14    0.49    2867    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      33    1.11    2938    1512
        0      79    2.62    3019    1512
        2      19    0.68    2832    1512
        1      21    0.77    2740    1512
        3      11    0.38    2973    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      35    1.23    2888    1512
        0      23    0.84    2722    1512
        2      21    0.72    2898    1512
        1      82    2.78    2938    1512
        3      16    0.56    2870    1512
      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
        -      63    2.24    2820    1512
        0      67    2.38    2800    1512
        2      73    2.56    2864    1512
        1      87    3.07    2842    1512
        3      25    0.93    2676    1512


Now if you don't get above results, then send the following for each 
mode "powersave" and "performance".

rdmsr 0xCE
rdmsr 0x1AD
rdmsr 0x770
rdmsr 0x771
rdmsr 0x772
rdmsr 0x773
rdmsr 0x774
rdmsr 0x777

Thanks,
Srinivas











