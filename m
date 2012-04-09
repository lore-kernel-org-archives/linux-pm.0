From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 0/5] coupled cpuidle state support
Date: Mon, 09 Apr 2012 12:41:39 +0530
Message-ID: <4F828BAB.5010302@ti.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
	<CAMbhsRQAw2+as13NVvWkh7ojyRs+jNpFist2gmiiEY52U=o84A@mail.gmail.com>
	<4F75ACCA.4090009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F75ACCA.4090009@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Rob Lee <rob.lee@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday 30 March 2012 06:23 PM, Santosh Shilimkar wrote:
> Colin,
> 
> On Friday 16 March 2012 05:07 AM, Colin Cross wrote:
>> On Wed, Mar 14, 2012 at 11:29 AM, Colin Cross <ccross@android.com> wrote:
> 
> [...]
> 
>>>
>>> v2:
>>>   * removed the coupled lock, replacing it with atomic counters
>>>   * added a check for outstanding pokes before beginning the
>>>     final transition to avoid extra wakeups
>>>   * made the cpuidle_coupled struct completely private
>>>   * fixed kerneldoc comment formatting
>>>   * added a patch with a helper function for resynchronizing
>>>     cpus after aborting idle
>>>   * added a patch (not for merging) to add trace events for
>>>     verification and performance testing
>>
>> I forgot to mention, this patch series is on v3.3-rc7, and will
>> conflict with the cpuidle timekeeping patches.  If those go in first
>> (which is likely), I will rework this series on top of it.  I left it
>> on v3.3-rc7 now to make testing easier.
> 
> I have re-based your series against Len Browns
> next branch [1] which has time keeping and other cpuidle patches.
> Have also folded the CPU hotplug fix which I posted in the
> original coupled idle patch.
> 
As you know, we have been playing around this series for OMAP
for last few weeks. This version series seems to work as intended
and found it pretty stable in my testing. Apart from the cpu
hotplug fix and the trace event comment, series looks fine
to me.

FWIW,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

An updated version of this series along with OMAP cpuidle
driver updates against 3.4-rc2 is available here [1] in
case some body is interested looking at it.

Regards
Santosh

[1] git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
for_3.5/coupled_cpuidle-rebase
