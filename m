From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle
	power_save=off
Date: Wed, 30 Nov 2011 06:55:40 +0530
Message-ID: <4ED58614.9090204@linux.vnet.ibm.com>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
	<20111117112906.9191.54050.stgit@localhost6.localdomain6>
	<1322435233.23348.19.camel@pasglop>	<4ED36A7D.9070308@linux.vnet.ibm.com>
	<1322512771.23348.45.camel@pasglop>
	<4ED47F48.2070107@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED47F48.2070107@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

On 11/29/2011 12:14 PM, Deepthi Dharwar wrote:

> On 11/29/2011 02:09 AM, Benjamin Herrenschmidt wrote:
> 
>> On Mon, 2011-11-28 at 16:33 +0530, Deepthi Dharwar wrote:
>>
>>> On an LPAR if cpuidle is disabled, ppc_md.power_save is still set to
>>> cpuidle_idle_call by default here. This would result in calling of
>>> cpuidle_idle_call repeatedly, only for the call to return -ENODEV. The
>>> default idle is never executed.
>>> This would be a major design flaw. No fallback idle routine.
>>>
>>> We propose to fix this by checking the return value of
>>> ppc_md.power_save() call from void to int.
>>> Right now return value is void, but if we change this to int, this
>>> would solve two problems. One being removing the cast to a function
>>> pointer in the prev patch and this design flaw stated above.
kernel/idle.c:  ppc_md.power_save = NULL;
>>>
>>> So by checking the return value of ppc_md.power_save(), we can invoke
>>> the default idle on failure. But my only concern is about the effects of
>>> changing the ppc_md.power_save() to return int on other powerpc
>>> architectures. Would it be a good idea to change the return type to int
>>> which would help us flag an error and fallback to default idle?
>>
>> I would have preferred an approach where the cpuidle module sets
>> ppc_md.power_save when loaded and restores it when unloaded ... but that
>> would have to go into the cpuidle core as a powerpc specific tweak and
>> might not be generally well received.
>>
>> So go for it, add the return value, but you'll have to update all the
>> idle functions (grep for power_save in arch/powerpc to find them).
>>
> 
> 
> Thanks Ben. Yes, I will update all the idle functions under powerpc.
> I will re-work these patches with the discussed changes.
> 
> Regards,
> Deepthi
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
> 
> 

Hi Ben,

I was trying to add a return value for power_save for all arch/powepc
idle functions but a few of them directly call *.S  routines, as they
are asm.

What would be a good way to change the return value  for asm routines ?
Do we make a change in asm only, put the return value in r3 or write a
wrapper function which would call these asm routines and return an int ?

Regards,
Deepthi
