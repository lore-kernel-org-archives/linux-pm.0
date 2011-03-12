From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [ANNOUNCE] cpupowerutils - cpufrequtils extended
	with quite some features
Date: Sat, 12 Mar 2011 10:59:10 +0100
Message-ID: <AANLkTinErtKD_eufvhOL-1OOffYSouf5KLLH2cCMyaT3__3272.66120953045$1300115861$gmane$org@mail.gmail.com>
References: <201103111247.00212.trenn@suse.de>
	<AANLkTimFg+uYGbSi=Ci-+_e89TgLkyMB7PAJcnt7mzTc@mail.gmail.com>
	<201103120053.53565.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103120053.53565.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>> Hi Thomas,
>> Do you think handling really vendor specific "boosts" like EeePC's SHE
>> is in cpupower scope
> This is an oem/vendor specific way to modify the front-side-bus
> throughput on (Intel atom only?) eeepc like machines (acer, asus and
> others?)?

I don't know exactly what it does, but yes it seems to modify the fsb
(and possibly something else on some models, who know ...), and it's
only specific to Asus EeePCs.
But Asus notebooks seems to have a similar "Power4Gear" function, that
may also overclock/downclock the gpu.

> You could try to experiment with registering your own delayed work queue
> in eeepc-laptopc.c and try to find best tunings and fittings for such
> requirements.
> If it works out and/or other xy-laptop.c or whatever drivers provide
> similar functionality it could get moved up into a more generic
> framework. A separate one next to cpuidle and cpufreq, for example
> fsb_mod?

I'll see if other platform drivers have something similar, but I
believe that at least one of them has a "peformance" mode.

> PS: Wouldn't the cpufreq subsystem suffice to register for this
> SHE thing?
> Could it be that SHE and real CPU freq (speedstep) is mutual exclusive?
> Is the only problem that p4_clockmod cannot be loaded then?

p4_clockmod is only loaded on olds EeePCs. New ones are using
acpi-cpufreq. And you can only load one cpufreq driver at a time.


-- 
Corentin Chary
http://xf.iksaif.net
