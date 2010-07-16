From: "Ai Li" <aili@codeaurora.org>
Subject: Re: [PATCH] cpuidle: extend cpuidle and menu governor to
	handle dynamic states
Date: Fri, 16 Jul 2010 13:19:43 -0600
Message-ID: <000301cb251b$d8cb7bf0$8a6273d0$__17777.2886505865$1279308212$gmane$org@org>
References: <1279225825-31069-1-git-send-email-aili@codeaurora.org>
	<4C3FDAF1.7030107@linux.intel.com>
	<000001cb250b$e2813e60$a783bb20$@org>
	<4C4096A8.8060306@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C4096A8.8060306@linux.intel.com>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: 'Arjan van de Ven' <arjan@linux.intel.com>
Cc: len.brown@intel.com, dwalker@codeaurora.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, shemminger@vyatta.com
List-Id: linux-pm@vger.kernel.org

> the power value in the structure should represent ONLY the power
> level during the low power stage.
> And this should be independent of total duration.
> all other power is taken into account in terms of break even
> point/etc...

With static cstates, determining the break even point is
straitforward, compare the power numbers of state Cn and Cn-1, since
the states are ordered in increasing order of latency and power.
With dynamic cstates, Cn-1 may not be a valid state to compare any
more, for example, because Cn-1's latency may have become too high.
It seems the driver would need to know which cstate the govenor would
compare Cn to, and that would break the design philosophy of driver +
govenor.  The break even point does not seem to have a transistive
property, where the govenor can calculat Cn vs Cn-2 from some
arithmatic combination of Cn vs Cn-1 and Cn-1 vs Cn-2 values.  On the
other hand, if the power_usage field also includes the entry and exit
stages, then the driver does not need to know whether it should
calculate break even point for Cn vs Cn-1, or Cn vs Cn-2, etc.


> > One of the concerns I have is backwards compatibility.  As far as
> I
> > know, none of the current cpuidle drivers use the power_usage
> field.
> > If we always do compare_power, those drivers would break until
> > someone with technical device knowledge update the drivers to
> specify
> > power...  I could derive fake power_usage numbers by default,
> using
> > the cstate index position.  That seems kind of hacky but it would
> > remove the need for the compare_power flag and retain the current
> > behavior when cpuidle drivers do not provide their own power
> numbers.
> >
> 
> I'm fine with this approach actually; if someone does not fill it
> in, we fake data that makes it
> valid... better than getting complex code.

OK.

~Ai

Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
