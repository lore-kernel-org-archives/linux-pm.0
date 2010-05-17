From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Mon, 17 May 2010 10:42:17 +0800
Message-ID: <4BF0AD09.80404__36732.2461017922$1274109419$gmane$org@linux.intel.com>
References: <20100513115625.GF2169@shaohui> <20100507141142.GA8696@ucw.cz>
	<20100516174502.GI2418@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100516174502.GI2418@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: Christoph Lameter <cl@linux-foundation.org>, shaohui.zheng@linux.intel.com, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <ak@linux.intel.com>, x86@kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>, linux-pm@lists.linux-foundation.org, Len Brown <len.brown@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Alex Chiang <achiang@hp.com>, Mel Gorman <mel@csn.ul.ie>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: linux-pm@vger.kernel.org

Paul E. McKenney wrote:
> On Fri, May 07, 2010 at 04:11:42PM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> hotplug emulator: Abstract cpu register functions
>>>
>>> Abstract function arch_register_cpu and register_cpu, move the implementation
>>> details to a sub function with prefix "__". 
>>>
>>> each of the sub function has an extra parameter nid, it can be used to register
>>> CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
>>> (CPU PROBE/RELEASE) in x86.
>> I don't get it. CPU hotplug can already be tested using echo 0/1 >
>> online, and that works on 386. How is this different?

"echo 0/1 > online" is logical cpu online/offline.
The emulator intends to emulate physical add/remove of cpus.
They cover different code path.

You can get details of the terms via $KERN_SRC/Documentation/cpu-hotplug.txt.

>> It seems to add some numa magic. Why is it important?

In real world, numa affinity info of the cpus is required for physical cpu hotadd/remove
, which finally affects related data structures and code path. Emulator need the ability
to emulate it.

> My guess is that he wants to test the software surrounding NUMA on a
> non-NUMA (or different-NUMA) machine, perhaps in order to shake out bugs
> before the corresponding hardware is available.

This is one of the purposes. Auto tests and debugging all can get benefits from such emulation.


-haicheng
