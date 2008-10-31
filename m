From: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: [Question] AMD opteron can support CPUfreq by per
 core ?
Date: Fri, 31 Oct 2008 17:16:58 +0000
Message-ID: <490B3D8A.2070601@simon.arlott.org.uk>
References: <28c262360810292306x2f3fb6bag559943c59fa83006@mail.gmail.com>
	<804dabb00810302006x7d59474bg27b716ffadf4515a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <804dabb00810302006x7d59474bg27b716ffadf4515a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: Kernelnewbies <kernelnewbies@nl.linux.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> On Thu, Oct 30, 2008 at 2:06 PM, MinChan Kim <minchan.kim@gmail.com> wrote:
>> Hi,  all,
>>
>> I want to test CPUfreq function in  AMD opteron quad-core series.
>> But I am not sure linux in now can support CPUfreq for ADM opteron by per core ?
>> What I mean is not controling to put together 2 core by one package
>> but control by per core.
>> After all, I want to control all 4 cpu separetely.
>>
>> Is is possible? If it is possible, What kinds of model can support ?

All Quad-Core AMD Opterons support using a separate CPU frequency per core.
All four cores are all independent, but afaik you'll only get a reduction in 
voltage based on the highest speed of all four cores.

You may want to ensure you get a motherboard with DDPM so the CPU and memory 
controller power is independent. http://www.tyan.com/tech/ddpm.aspx

Make sure you use a recent kernel which handles C1E properly.


On 31/10/08 03:06, Peter Teoh wrote:
> check this out:
> 
> http://osdir.com/ml/kernel.cpufreq/2004-07/msg00012.html
> 
> from the reply, since the power management flag is at the per-core
> level (check /proc/cpuinfo), all control can be done at the per-core
> level, hard-ware wise.   (not sure of Linux Kernel itself)
> 
> But at least 4 flags must be present (read above email):   ts, ttp, fid, vid.
> 
> I must also say this is the first time I am aware of these flags too :-).

Don't top post.

I've never heard of these flags - that email is from 2004.

model name	: Quad-Core AMD Opteron(tm) Processor 2354

flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good pni monitor cx16 lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs

[    5.569030] powernow-k8:    0 : pstate 0 (2200 MHz)
[    5.569136] powernow-k8:    1 : pstate 1 (2000 MHz)
[    5.569233] powernow-k8:    2 : pstate 2 (1700 MHz)
[    5.569330] powernow-k8:    3 : pstate 3 (1400 MHz)
[    5.569434] powernow-k8:    4 : pstate 4 (1100 MHz)
-- 
Simon Arlott
