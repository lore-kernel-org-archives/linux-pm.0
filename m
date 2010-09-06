From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Discuss] Speedstep on Celeron SU2300 - 20% more
 battery	lifetime on Windows
Date: Mon, 06 Sep 2010 08:47:28 -0700
Message-ID: <4C850D10.2050801__44543.0340515033$1283788117$gmane$org@linux.intel.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>	<201009020152.37466.trenn@suse.de>	<AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
	<201009061035.03727.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009061035.03727.trenn@suse.de>
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
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Tiago Marques <tiagomnm@gmail.com>
List-Id: linux-pm@vger.kernel.org

  On 9/6/2010 1:35 AM, Thomas Renninger wrote:
> Hi,
>
> I am adding lesswatts.org and linux-pm list.
> I expect you found out why you do not get frequency/P- states and it
> seem to be correct. On these lists, people can help you further
> to find out Linux vs Windows battery drain differences.
>
> If you have the same backlight settings, I expect C-state or graphics
> card must be the reason. There is nothing else than CPU or GPU
> that drains so much energy for being the reason of
> 20% more battery life time.
> Which graphics card and driver do you use (for nvidia/ati, trying the
> binary one for comparison, might show a big difference on a recent
> card)?
> Which C-state driver do you use (there is an acpi and intel_idle one
> with latest kernels):
> cat /sys/devices/system/cpu/cpuidle/current_driver
> I hope to be able to provide a c-state tool soon, for now you have to
> go through:
> cat /sys/devices/system/cpu/cpu*/cpuidle/state*
> to check which and how often/efficient C-states are used.

powertop will tell you exactly this

(and the next version will provide much much more detail)
