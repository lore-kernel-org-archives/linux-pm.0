From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powernv: Pass PSSCR value and mask to power9_idle_stop
Date: Wed, 12 Oct 2016 16:35:35 +1100
Message-ID: <87lgxuf7tk.fsf@linux.vnet.ibm.com>
References: <cover.1475130107.git.ego@linux.vnet.ibm.com>
 <21e080ffa52f432b40750028a624aee1baebbaf7.1475130107.git.ego@linux.vnet.ibm.com>
 <87int84d6w.fsf@concordia.ellerman.id.au>
 <0e7ad8ff-8c44-86bc-f560-258bc7b29a32@gmail.com>
 <20161007072058.GC13873@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20161007072058.GC13873@in.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "skiboot@lists.ozlabs.org" <skiboot@lists.ozlabs.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Tue, Oct 04, 2016 at 10:33:27PM +1100, Balbir Singh wrote:
>> 
>> 
>> On 04/10/16 21:32, Michael Ellerman wrote:
>> > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> > 
>> >> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >>
>> >> The power9_idle_stop method currently takes only the requested stop
>> >> level as a parameter and picks up the rest of the PSSCR bits from a
>> >> hand-coded macro. This is not a very flexible design, especially when
>> >> the firmware has the capability to communicate the psscr value and the
>> >> mask associated with a particular stop state via device tree.
>> >>
>> >> This patch modifies the power9_idle_stop API to take as parameters the
>> >> PSSCR value and the PSSCR mask corresponding to the stop state that
>> >> needs to be set. These PSSCR value and mask are respectively obtained
>> >> by parsing the "ibm,cpu-idle-state-psscr" and
>> >> "ibm,cpu-idle-state-psscr-mask" fields from the device tree.
>> >>
>> >> In addition to this, the patch adds support for handling stop states
>> >> for which ESL and EC bits in the PSSCR are zero. As per the
>> >> architecture, a wakeup from these stop states resumes execution from
>> >> the subsequent instruction as opposed to waking up at the System
>> >> Vector.
>> > 
>> > That looks good.
>> > 
>> >> This patch depends on the following skiboot patch that exports the
>> >> PSSCR values and the mask for all the stop states:
>> >> https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html
>> > 
>> > But we can't depend on a skiboot patch. The kernel has to cope with
>> > running on an old skiboot.
>>
>
> Hmm.. We can still do that. The older skiboot only provides the RL
> field of the PSSCR value for each stop state and the corresponding
> PSSCR mask is set to 0xF in the older skiboot for all the stop states.
>
> We can insist that the future skiboot sets the ESL, EC, PSLL, TR, MTL
> and the the RL fields of the PSSCR for any exported stop state. This
> should be reflected in the psscr_mask of that stop state.  Thus, the
> psscr_mask of any stop state proposed in the future will have:
> (PSSCR_ESL_MASK | PSCCR_EC_MASK | PSCCR_PSLL_MASK | PSSCR_TR_MASK |
> PSSCR_MTL_MASK | PSSCR_RL_MASK) bits set in the skiboot.
>
> To handle the older firmware, we can do something like the following
> during the discovery of the stop states to mimic the behaviour present
> in the 4.8 kernel running on older firmware.
>
> =============== drivers/cpuidle/cpuidle-powernv.c =======================
> /*
>  * By default we set the ESL and EC bits in the PSSCR.
>  * The MTL and PSLL are set to the maximum value possible as per the
>  * ISA, i.e 15.
>  * The Transition Rate is set to the Maximum value 3.
>  */
> #define DEFAULT_PSSCR_VAL      PSSCR_ESL_MASK |			\
> 			       PSCCR_EC_MASK | PSCCR_PSLL_MASK |\
> 			       PSSCR_TR_MASK | PSSCR_MTL_MASK
>
> #define DEFAULT_PSSCR_MASK     PSSCR_ESL_MASK |			\
> 			       PSCCR_EC_MASK | PSCCR_PSLL_MASK |\
> 			       PSSCR_TR_MASK | PSSCR_MTL_MASK | \
> 			       PSSCR_RL_MASK
>
>
> static int powernv_add_idle_states(void)
> {
> 	.
> 	.
> 	.
> 	for (i = 0; i < dt_idle_states; i++) {
> 	    u64 val, mask;
> 	    	.	    
> 		.
> 		.
> 		val = (DEFAULT_PSSCR_VAL & ~psscr_mask[i]) | psscr_val[i];
> 		mask = DEFAULT_PSSCR_MASK | psscr_mask[i];
> 		stop_psscr_table[nr_idle_states].val = val;
>         	stop_psscr_table[nr_idle_states].mask = mask;
> 	}
> }		
> ============================================================================
>
>
> Is this approach ok ?

What if we just treat the 0xF state from firmware as special and set it
to DEFAULT_PSSCR_MASK in that case? That deals with old skiboot, new
kernel, and sets a pretty small special case that's easy to track into
the future as something we should watch out for.

Additionally, if we make skiboot set sane values in ~DEFAULT_PSSCR_MASK
for valid fields in PSSCR on boot/(also kexec?), then
we should end up in a situation where everything works with everything
(even if you don't get the best power saving). Specifically, new
skiboot, old kernel... but it looks like there's nothing currently
missing there

Should this patch also have Fixes: 3005c597ba4 and CC to stable?

-- 
Stewart Smith
OPAL Architect, IBM.
