From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Mon, 17 May 2010 11:38:48 +0200
Message-ID: <4BF10EA8.9050904__48828.4787782051$1274109474$gmane$org@linux.intel.com>
References: <20100513115625.GF2169@shaohui> <20100507141142.GA8696@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100507141142.GA8696@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Lameter <cl@linux-foundation.org>, haicheng.li@linux.intel.com, shaohui.zheng@linux.intel.com, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, x86@kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Alex Chiang <achiang@hp.com>, Mel Gorman <mel@csn.ul.ie>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.orgHugh Dickins <h>
List-Id: linux-pm@vger.kernel.org

, Pavel Machek wrote:
> Hi!
>
>> hotplug emulator: Abstract cpu register functions
>>
>> Abstract function arch_register_cpu and register_cpu, move the implementation
>> details to a sub function with prefix "__".
>>
>> each of the sub function has an extra parameter nid, it can be used to register
>> CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
>> (CPU PROBE/RELEASE) in x86.
>
> I don't get it. CPU hotplug can already be tested using echo 0/1>
> online, and that works on 386. How is this different?

It tests a different code path.

> It seems to add some numa magic. Why is it important?

It tests memory and node hotadd too. Memory/node hotadd is a quite problematic
feature and needs all the testing support it can get.

-Andi
