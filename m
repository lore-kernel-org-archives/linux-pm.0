From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Date: Thu, 14 Jun 2007 15:57:25 +0100 (BST)
Message-ID: <Pine.LNX.4.61.0706141539140.29274__14087.5521734872$1181833222$gmane$org@mtfhpc.demon.co.uk>
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
Cc: Ioan Ionita <opslynx@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, Dan Aloni <da-x@monatomic.org>, Greg Kroah-Hartman <gregkh@suse.de>, Netdev <netdev@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Alex Riesen <raa.lkml@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, David Miller <davem@davemloft.net>, Chad Tindel <ctindel@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org


Benh's ptep_set_access_flags() patch needs to be applied in order to get 
anyware with sun4c for all kernels >= linux-2.6.15. If not applied, you 
will be lucky to get sash running as your init and even that will have 
very limitit capabilities before it locks up the processor (power up 
reset required).

It has been applied to both the kernels I used for testing so this 
problem is independent of the ptep_set_access_flags patch but that 
does not mean that it is not a related issue.

I will try to get some testing done over the weekend to narrow down 
when the random illegal instructions first occour.

If I start with 2.6.21 then if that is OK, then I should be able to narow 
the issue down without too much trouble. If it is between 2.6.20 and 
2.6.21 then it will be a right pig as there are a large number of commits 
that don't compile for sun4c between these two. What I am hoping is that 
it occours in the 2.6.22-rc2 as per the x86_64.

I am going to have to put a 'reset' button onto my test system as power up 
resets are bad news on this old hardware and almost all kernel failures 
result in a processor lockup. I have even had to make BUG reports 'panic' 
as thoes that I have during kernel fault location had are terminal to a 
sun4c (they cause a processor lockup).

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
