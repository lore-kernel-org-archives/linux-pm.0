From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [2/2] 2.6.22-rc4: known regressions v3
Date: Wed, 13 Jun 2007 19:00:55 -0700
Message-ID: <20070614020055.GL15426__47456.7934791141$1181786634$gmane$org@holomorphy.com>
References: <46704923.1010009@googlemail.com> <46704C44.8020602@googlemail.com>
	<Pine.LNX.4.61.0706132320200.26751@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0706132320200.26751@mtfhpc.demon.co.uk>
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
Cc: discuss@x86-64.org, linux-usb-devel@lists.sourceforge.net, Mikael Pettersson <mikpe@it.uu.se>, Dan Aloni <da-x@monatomic.org>, Greg Kroah-Hartman <gregkh@suse.de>, Netdev <netdev@vger.kernel.org>, Stephen Hemminger <shemminger@linux-foundation.org>, Jay Vosburgh <fubar@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Alex Riesen <raa.lkml@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Chad Tindel <ctindel@users.sourceforge.net>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Ioan Ionita <opslynx@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2007 at 11:25:20PM +0100, Mark Fortescue wrote:
> The random seg faults on x86_64 is interesting as I have been getting 
> random illegal instruction faults on sparc (sun4c) with 2.6.22-rc3. I have 
> not yet tried to track it down. All I know at present is that it is not a 
> problem on 2.6.20.9.

Very interesting. Any hints as to how to test or how long to wait
before the illegal instructions happen?


-- wli
