From: Thomas Renninger <trenn@suse.de>
Subject: Re: [ANNOUNCE] cpupowerutils - cpufrequtils extended
	with quite some features
Date: Sat, 12 Mar 2011 00:53:53 +0100
Message-ID: <201103120053.53565.trenn__2326.67288878492$1299887715$gmane$org@suse.de>
References: <201103111247.00212.trenn@suse.de>
	<AANLkTimFg+uYGbSi=Ci-+_e89TgLkyMB7PAJcnt7mzTc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimFg+uYGbSi=Ci-+_e89TgLkyMB7PAJcnt7mzTc@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I excluded some people/lists...

On Friday, March 11, 2011 04:56:01 PM Corentin Chary wrote:
...
> > The tool should compile and work on as much architectures as
> > possible.
> 
> Hi Thomas,
> Do you think handling really vendor specific "boosts" like EeePC's SHE
> is in cpupower scope ?
Not really.

> Still, it would not solve the issue of setting SHE mode in a standard
> way, or associating it with a governor.
I am not familiar with this stuff.
This is an oem/vendor specific way to modify the front-side-bus 
throughput on (Intel atom only?) eeepc like machines (acer, asus and 
others?)?

You could try to experiment with registering your own delayed work queue
in eeepc-laptopc.c and try to find best tunings and fittings for such 
requirements.
If it works out and/or other xy-laptop.c or whatever drivers provide 
similar functionality it could get moved up into a more generic 
framework. A separate one next to cpuidle and cpufreq, for example 
fsb_mod?
-> then cpupower should get enhanced to show its statistics, provide 
easy knobs to tune things and provide a manpage what this is all 
about...

       Thomas

PS: Wouldn't the cpufreq subsystem suffice to register for this
SHE thing?
Could it be that SHE and real CPU freq (speedstep) is mutual exclusive?
Is the only problem that p4_clockmod cannot be loaded then?
I know it's needed to "unlock" certain eeepcs, but this not typical?
Are there any statistics how much p4_clockmod saves power on such
machines?

    Thomas
