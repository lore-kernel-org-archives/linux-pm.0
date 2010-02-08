From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] i915 / PM: Fix crash while aborting
 hibernation (Re: [regression] "drm/i915: implement new pm ops" disables irq
 on aborted s2disk)
Date: Mon, 08 Feb 2010 09:49:08 +0000
Message-ID: <4B6FDE14.8070406__10245.1786086478$1265622622$gmane$org@tuffmail.co.uk>
References: <4B695BA0.4000007@tuffmail.co.uk> <201002032344.41915.rjw@sisk.pl>
	<20100204013157.GA30011@zhen-devel.sh.intel.com>
	<201002072148.24588.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002072148.24588.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kernel Testers List <kernel-testers@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, Zhenyu Wang <zhenyuw@linux.intel.com>, linux-pm@lists.linux-foundation.org, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday 04 February 2010, Zhenyu Wang wrote:
>   
>> On 2010.02.03 23:44:41 +0100, Rafael J. Wysocki wrote:
>>     
>>> On Wednesday 03 February 2010, Alan Jenkins wrote:
>>>       
>>>> Hi
>>>>
>>>> I found this regression on my EeePC 701 with modesetting enabled.  When 
>>>> I hibernate using s2disk, I can abort the hibernation by pressing the 
>>>> backspace key.  Doing so breaks X on 2.6.32-rc6 (but not 2.6.32).
>>>>         
>>> Yeah.
>>>
>>> To be honest, I knew that's going to happen, but didn't have the time to take
>>> care of it.
>>>
>>> The problem is that i915 does literally _nothing_ in its .thaw() callback,
>>> although it should at least reverse whatever .freeze() did to the hardware
>>> (and memory allocations and so on), so that the adapter is functional
>>> after creating the image.
>>>
>>> Fixing this requires some thought, though, because at the moment .freeze()
>>> thinks it's .suspend(), which is not the case as this report clearly shows.
>>> So, in fact i915_pci_suspend() has to be split into the .freeze() part and
>>> the poweroff part cleanly and that's not  so simple (at least to me).
>>>
>>>       
>> Right, I think that'll be more clean, stuff in i915_save/restore_state() need
>> to be splited too, especially isolate stuff for mode setting and other device
>> state, as what my original purpose for this is to remove extra mode setting 
>> cycle in old behavior so not waste time for hibernate.
>>     
>
> We can't really do that, because we'll need to restore the saved state at the
> resume-from-hibernation stage.
>
> The appended patch fixes the issue for me, although it's been only tested
> a little.  It sort of defeats the purpose of commit
> cbda12d77ea590082edb6d30bd342a67ebc459e0, but I don't see any less invasive
> way to fix this except maybe for reverting that commit entirely.
>
> Note that the drm_irq_[un]install() thing may be unnecessary, but I wasn't sure
> about that and surely wouldn't suggest doing that for 2.6.33.  Also it looks like
> some things from the freeze and thaw parts may be moved to the "low-level"
> suspend and resume parts, respectively, but that would require some
> i915_gem_* surgery I was too scared to do.
>
> Alan, please test, i915 guys, please review.
>
> Rafael
>   

The patch works very nicely on my eeepc.

Thanks
(and thanks again for all your hard work this cycle, and specifically 
for pointing me to the s2disk hang-fix)

Alan
