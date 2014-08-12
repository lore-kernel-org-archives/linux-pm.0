From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Subject: Re: Fwd: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Tue, 12 Aug 2014 18:39:39 -0500
Message-ID: <53EAA5BB.2010207@amd.com>
References: <4708675.eITUXPv8Ih@spock>	<1449757.YVvGmvgCpE@spock>
	<3606476.mQLS7miLfb@spock>	<2067094.cJOA1APdny@spock>
	<CAOjmkp_mrMYJJfEqqKtPVrbMuaoJ9W6212LKHETeUsOsJryh-Q@mail.gmail.com>
 <CAOjmkp8h19de3bYaLpqmXxEynKi--gHBf6MxXuuNoDzZXw=O8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0142.outbound.protection.outlook.com ([207.46.163.142]:30206
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751422AbaHLXjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Aug 2014 19:39:45 -0400
In-Reply-To: <CAOjmkp8h19de3bYaLpqmXxEynKi--gHBf6MxXuuNoDzZXw=O8Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: oleksandr@natalenko.name
Cc: viresh.kumar@linaro.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On 8/12/2014 2:51 PM, Aravind Gopalakrishnan wrote:
>
>
> Hello.
>
> Occasionally I get my machine hung completely. Fortunately, I've got=20
> and saved
> oops listing using netconsole before hang, and here it is [1].
>
> Here is little piece of oops from the link above:
>
> =3D=3D=3D
> [15051.270461] BUG: unable to handle kernel paging request at=20
> 00000000ff5ae8e4
> [15051.271583] IP: [<ffffffff8109ae6e>] srcu_notifier_call_chain+0xe/=
0x20
> =E2=80=A6
> [15051.956205] Call Trace:
> [15051.980641]  [<ffffffff81606085>] ?=20
> __cpufreq_notify_transition+0x95/0x1e0
> [15052.005640]  [<ffffffff816081ee>] cpufreq_notify_transition+0x3e/0=
x70
> [15052.030240]  [<ffffffff816083d8>]=20
> cpufreq_freq_transition_begin+0xe8/0x130
> [15052.054522]  [<ffffffff813b8940>] ? ucs2_strncmp+0x70/0x70
> [15052.078208]  [<ffffffff816089bf>] __target_index+0xbf/0x1a0
> [15052.101348]  [<ffffffff81608b9c>] __cpufreq_driver_target+0xfc/0x1=
60
> [15052.124250]  [<ffffffff8160b0d4>] od_check_cpu+0xa4/0xb0
> [15052.146789]  [<ffffffff8160c9ec>] dbs_check_cpu+0x16c/0x1c0
> [15052.168935]  [<ffffffff8160b4dd>] od_dbs_timer+0x11d/0x180
> [15052.190607]  [<ffffffff8108e6ff>] process_one_work+0x17f/0x4c0
> [15052.211825]  [<ffffffff8108f46b>] worker_thread+0x11b/0x3f0
> [15052.232490]  [<ffffffff8108f350>] ? create_and_start_worker+0x80/0=
x80
> [15052.253127]  [<ffffffff81096479>] kthread+0xc9/0xe0
> [15052.273292]  [<ffffffff810963b0>] ? flush_kthread_worker+0xb0/0xb0
> [15052.293487]  [<ffffffff81793efc>] ret_from_fork+0x7c/0xb0
> [15052.313544]  [<ffffffff810963b0>] ? flush_kthread_worker+0xb0/0xb0
> =E2=80=A6
> =3D=3D=3D
>
> Also here is my lspci [2] and cpuinfo [3] as well.
>
> Vanilla 3.15.8 and 3.16.0 are affected as well as latest Ubuntu 3.13=20
> kernel.
>
> No visible reason to trigger the bug. After hang machine doesn't=20
> respond via
> network, there's no disk IO, and also it doesn't respond to pressing =
power
> button in order to perform soft off.
>
> [1] https://gist.github.com/085af9da81197faf6637
> [2] https://gist.github.com/318ebda5576b099590b8
> [3] https://gist.github.com/9c1307463c7ad6835b2d
>
>

Hi,

I noticed this ping yesterday and tried to reproduce your issue on a=20
similar system I have (btw, this is a 'Kabini' processor and not a=20
'Kaveri') without success.

/proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 22
model           : 0
model name      : AMD Opteron(tm) X2150 APU
stepping        : 1
microcode       : 0x7000106
cpu MHz         : 800.000
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext=20
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc=20
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1=
=20
sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic=20
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt=20
topoext perfctr_nb perfctr_l2 arat xsaveopt hw_pstate proc_feedback npt=
=20
lbrv svm_lock nrip_save tsc_scale flushbyasid decodeassists pausefilter=
=20
pfthreshold bmi1
bogomips        : 3793.19
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate [11]

Since the BUG happens on a frequency transition, I tried this-
periodically ramped up the cpu frequency by running a workload to keep=20
all cores busy for sometime; And let cpu frequency drop down by killing=
=20
the load.
Repeated this cycle overnight yesterday but did not notice the BUG.
(Using ondemand governor, with uname -r: 3.16-rc4)
(I think you mentioned you were able to reproduce on 3.16. So assuming=20
-rc will be affected too)

Are you noticing this BUG when you are running any particular load?
I could help debug effort or test patches to fix issue(whenever=20
necessary) if I have some way to reproduce this..

-Aravind
