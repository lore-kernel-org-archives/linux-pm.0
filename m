From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Thu, 13 May 2010 14:11:20 +0200
Message-ID: <20100513141120.10524f05__9998.41414527527$1273752927$gmane$org@hyperion.delvare>
References: <20100513115625.GF2169@shaohui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513115625.GF2169@shaohui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohui Zheng <shaohui.zheng@intel.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, haicheng.li@linux.intel.com, shaohui.zheng@linux.intel.com, Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Hidetoshi@smtp1.linux-foundation.org, Andi Kleen <ak@linux.intel.com>, x86@kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Seto <seto.hidetoshi@jp.fujitsu.com>, Alex Chiang <achiang@hp.com>, Mel Gorman <mel@csn.ul.ie>, James@smtp1.linux-foundation.org, Greg@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 May 2010 19:56:25 +0800, Shaohui Zheng wrote:
> 
> hotplug emulator: Abstract cpu register functions
> 
> Abstract function arch_register_cpu and register_cpu, move the implementation
> details to a sub function with prefix "__". 
> 
> each of the sub function has an extra parameter nid, it can be used to register
> CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
> (CPU PROBE/RELEASE) in x86.
> 
> Signed-off-by: Shaohui Zheng <shaohui.zheng@intel.com>
> Signed-off-by: Haicheng Li <haicheng.li@intel.com>

I don't know anything about this, please don't Cc me on these patches.
Given the very long Cc list, I'm certain many other developers you have
included are not interested. Please focus on the relevant lists next
time!

-- 
Jean Delvare
