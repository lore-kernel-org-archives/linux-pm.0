From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC,5/7] NUMA hotplug emulator
Date: Sun, 16 May 2010 10:45:02 -0700
Message-ID: <20100516174502.GI2418__5131.92677540264$1274032072$gmane$org@linux.vnet.ibm.com>
References: <20100513115625.GF2169@shaohui>
 <20100507141142.GA8696@ucw.cz>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Christoph Lameter <cl@linux-foundation.org>, haicheng.li@linux.intel.com, shaohui.zheng@linux.intel.com, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andi Kleen <ak@linux.intel.com>, x86@kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>, linux-pm@lists.linux-foundation.org, Len Brown <len.brown@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Alex Chiang <achiang@hp.com>, Mel Gorman <mel@csn.ul.ie>, Jean Delvare <khali@linux-fr.org>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Hugh Dickins <hugh.dickins@tisc>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 04:11:42PM +0200, Pavel Machek wrote:
> Hi!
> 
> > hotplug emulator: Abstract cpu register functions
> > 
> > Abstract function arch_register_cpu and register_cpu, move the implementation
> > details to a sub function with prefix "__". 
> > 
> > each of the sub function has an extra parameter nid, it can be used to register
> > CPU under a fake NUMA node, it is a reserved interface for cpu hotplug emulation
> > (CPU PROBE/RELEASE) in x86.
> 
> I don't get it. CPU hotplug can already be tested using echo 0/1 >
> online, and that works on 386. How is this different?
> 
> It seems to add some numa magic. Why is it important?

My guess is that he wants to test the software surrounding NUMA on a
non-NUMA (or different-NUMA) machine, perhaps in order to shake out bugs
before the corresponding hardware is available.

							Thanx, Paul
