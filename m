From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Date: Thu, 14 Jun 2007 08:02:19 -0700
Message-ID: <20070614150219.GG6909__31740.2642606341$1181833964$gmane$org@holomorphy.com>
References: <46704923.1010009@googlemail.com> <46704C44.8020602@googlemail.com>
	<Pine.LNX.4.61.0706132320200.26751@mtfhpc.demon.co.uk>
	<20070614020055.GL15426@holomorphy.com>
	<Pine.LNX.4.61.0706141123160.28903@mtfhpc.demon.co.uk>
	<20070614142146.GN15426@holomorphy.com>
	<Pine.LNX.4.61.0706141539140.29274@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0706141539140.29274@mtfhpc.demon.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: Ioan Ionita <opslynx@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, Dan Aloni <da-x@monatomic.org>, Greg Kroah-Hartman <gregkh@suse.de>, Netdev <netdev@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Alex Riesen <raa.lkml@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, David Miller <davem@davemloft.net>, Chad Tindel <ctindel@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 14, 2007 at 03:57:25PM +0100, Mark Fortescue wrote:
> Benh's ptep_set_access_flags() patch needs to be applied in order to get 
> anyware with sun4c for all kernels >= linux-2.6.15. If not applied, you 
> will be lucky to get sash running as your init and even that will have 
> very limitit capabilities before it locks up the processor (power up 
> reset required).
> It has been applied to both the kernels I used for testing so this 
> problem is independent of the ptep_set_access_flags patch but that 
> does not mean that it is not a related issue.
> I will try to get some testing done over the weekend to narrow down 
> when the random illegal instructions first occour.
> If I start with 2.6.21 then if that is OK, then I should be able to narow 
> the issue down without too much trouble. If it is between 2.6.20 and 
> 2.6.21 then it will be a right pig as there are a large number of commits 
> that don't compile for sun4c between these two. What I am hoping is that 
> it occours in the 2.6.22-rc2 as per the x86_64.

Sounds like I'll be digging through my hardware stockpiles this weekend
to find a functional sun4c box.


-- wli
