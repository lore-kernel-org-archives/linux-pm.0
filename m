From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] cpuidle: extend cpuidle and menu governor to
 handle dynamic states
Date: Fri, 16 Jul 2010 12:33:10 -0700
Message-ID: <4C40B3F6.5010106__32134.1879469857$1279308867$gmane$org@linux.intel.com>
References: <1279225825-31069-1-git-send-email-aili@codeaurora.org>
	<4C3FDAF1.7030107@linux.intel.com>
	<000001cb250b$e2813e60$a783bb20$@org>
	<4C4096A8.8060306@linux.intel.com>
	<000301cb251b$d8cb7bf0$8a6273d0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <000301cb251b$d8cb7bf0$8a6273d0$@org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: len.brown@intel.com, dwalker@codeaurora.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, shemminger@vyatta.com
List-Id: linux-pm@vger.kernel.org

On 7/16/2010 12:19 PM, Ai Li wrote:
>> the power value in the structure should represent ONLY the power
>> level during the low power stage.
>> And this should be independent of total duration.
>> all other power is taken into account in terms of break even
>> point/etc...
>>      
> With static cstates, determining the break even point is
> straitforward, compare the power numbers of state Cn and Cn-1, since
> the states are ordered in increasing order of latency and power.
> With dynamic cstates, Cn-1 may not be a valid state to compare any
> more, for example, because Cn-1's latency may have become too high.
> It seems the driver would need to know which cstate the govenor would
> compare Cn to, and that would break the design philosophy of driver +
> govenor.  The break even point does not seem to have a transistive
> property, where the govenor can calculat Cn vs Cn-2 from some
> arithmatic combination of Cn vs Cn-1 and Cn-1 vs Cn-2 values.  On the
> other hand, if the power_usage field also includes the entry and exit
> stages, then the driver does not need to know whether it should
> calculate break even point for Cn vs Cn-1, or Cn vs Cn-2, etc.
>    

that's nice in theory.
in practice though, this is all noise compared to some of the accuracy 
in the predictions.

break even generally is done against C1 only (since C1 is assumed to 
always be there)....
yes it'd be nice to also have it against Cx in a matrix form, but that 
is a level of complexity that
hasn't been worth it.

Note that the prediction is.... a prediction. I can show you data on how 
well it does (now that it's
much better in 2.6.35-rc), but it's still "50% of the time we're within 
a factor of two of actual".
not "we're 90% of the time within 10%".
