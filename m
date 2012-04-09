From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [PATCHv2 0/5] coupled cpuidle state support
Date: Mon, 09 Apr 2012 16:35:40 -0700
Message-ID: <87mx6k7a2b.fsf@ti.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
 <CAMbhsRQAw2+as13NVvWkh7ojyRs+jNpFist2gmiiEY52U=o84A@mail.gmail.com>
 <4F75ACCA.4090009@ti.com> <4F828BAB.5010302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F828BAB.5010302@ti.com> (Santosh Shilimkar's message of "Mon,
 09 Apr 2012 12:41:39 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Rob Lee <rob.lee@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Friday 30 March 2012 06:23 PM, Santosh Shilimkar wrote:
>> Colin,
>> 
>> On Friday 16 March 2012 05:07 AM, Colin Cross wrote:
>>> On Wed, Mar 14, 2012 at 11:29 AM, Colin Cross <ccross@android.com> wrote:
>> 
>> [...]
>> 
>>>>
>>>> v2:
>>>>   * removed the coupled lock, replacing it with atomic counters
>>>>   * added a check for outstanding pokes before beginning the
>>>>     final transition to avoid extra wakeups
>>>>   * made the cpuidle_coupled struct completely private
>>>>   * fixed kerneldoc comment formatting
>>>>   * added a patch with a helper function for resynchronizing
>>>>     cpus after aborting idle
>>>>   * added a patch (not for merging) to add trace events for
>>>>     verification and performance testing
>>>
>>> I forgot to mention, this patch series is on v3.3-rc7, and will
>>> conflict with the cpuidle timekeeping patches.  If those go in first
>>> (which is likely), I will rework this series on top of it.  I left it
>>> on v3.3-rc7 now to make testing easier.
>> 
>> I have re-based your series against Len Browns
>> next branch [1] which has time keeping and other cpuidle patches.
>> Have also folded the CPU hotplug fix which I posted in the
>> original coupled idle patch.
>> 
> As you know, we have been playing around this series for OMAP
> for last few weeks. This version series seems to work as intended
> and found it pretty stable in my testing. Apart from the cpu
> hotplug fix and the trace event comment, series looks fine
> to me.
>
> FWIW,
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

Also

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

as I've been working with Santosh on getting this stabilized on OMAP and
we are very keen to see this functionality merged.

Thanks,

Kevin
