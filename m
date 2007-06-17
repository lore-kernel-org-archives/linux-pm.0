From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Date: Sun, 17 Jun 2007 12:35:32 +0100 (BST)
Message-ID: <Pine.LNX.4.61.0706171223160.3680__36636.4835565493$1182080382$gmane$org@mtfhpc.demon.co.uk>
References: <46704923.1010009@googlemail.com> <46704C44.8020602@googlemail.com>
	<Pine.LNX.4.61.0706132320200.26751@mtfhpc.demon.co.uk>
	<20070614020055.GL15426@holomorphy.com>
	<Pine.LNX.4.61.0706141123160.28903@mtfhpc.demon.co.uk>
	<20070614142146.GN15426@holomorphy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070614142146.GN15426@holomorphy.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: discuss@x86-64.org, linux-usb-devel@lists.sourceforge.net, Mikael Pettersson <mikpe@it.uu.se>, Dan Aloni <da-x@monatomic.org>, Greg Kroah-Hartman <gregkh@suse.de>, Netdev <netdev@vger.kernel.org>, Stephen Hemminger <shemminger@linux-foundation.org>, Jay Vosburgh <fubar@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Alex Riesen <raa.lkml@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Chad Tindel <ctindel@users.sourceforge.net>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Ioan Ionita <opslynx@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

I have been investigating the random invalid instruction occourances on 
sparc32 (sun4c) and identified that the problem was introduced 
pre-v2.6.22-rc1. v2.6.21 is OK. The first time I have observed the issue 
so far is after commit b46b8f19c9cd435ecac4d9d12b39d78c137ecd66:
Increase slab redzone to 64bits.

Prior to this commit there apears to be a problem with the memory 
management (depmod -a causes the system to run out of memory!) that may be 
masking the issue. As a result of this, I am going to try to find the 
'last known good' commit after v2.6.21 to see if this helps narrow down 
the cause.

Regards
 	Mark Fortescue.

On Thu, 14 Jun 2007, William Lee Irwin III wrote:

> On Thu, Jun 14, 2007 at 11:30:25AM +0100, Mark Fortescue wrote:
>> They apear as soon as simpleinit starts up. Somtimes I get to a login
>> prompt before seeing any. Other times, commands in the simpleinit rc
>> script fail.
>> They do apear to be random. If a command failes, you re-run the command
>> and it is OK. Commands seen to fail are basic (depmod, rm cat ..).
>> The test I did use the same binaries with both the OK and problem kernels
>> so it is not a change to the application code, it is definatly a kernel
>> issue.
>
> This sounds like it may be addressed by benh's ptep_set_access_flags()
> fixes. Those fixes are still in -mm, hopefully to hit mainline by 2.6.22.
>
>
> -- wli
>
