From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
 support
Date: Thu, 9 Jun 2011 18:07:59 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106091803050.11513__5607.81777971915$1307639367$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106091707220.11513@localhost6.localdomain6>
	<4DF0F650.4040604@ti.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF0F650.4040604@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, tuxonice-devel@tuxonice.net, frank.hofmann@tomtom.com, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Thu, 9 Jun 2011, Santosh Shilimkar wrote:

> On 6/9/2011 9:56 PM, Frank Hofmann wrote:
>> 
>> 
[ ... ]
>> a) What reasons if any are there why cpu_{v7_do_}suspend/resume are not
>> ok to use (on OMAP) for snapshotting core state, for the purpose of
>> hibernation ?
>> If there are any such issues, then how could they be addresssed ?
>> 
> Part of the answer is what Russell described. We think it's doable,
> but it needs some work. First and fore most is this code should
> be able to be executed from DDR. It's not the case today.

Ah, I gather that's the _real_ critical point, i.e.

 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 					omap34xx_cpu_suspend_sz);

relies on this to be completely consecutive in mem, and relocatable, i.e. 
calling _outside_ that area isn't possible ?

I.e. unless a way can be found to _embed_ cpu_suspend/resume here, it's 
pretty hard to use ?

Would it be possible / acceptable to have it be relocatable code, and put 
it into a common .section ?


Thanks for the feedback,
FrankH.
