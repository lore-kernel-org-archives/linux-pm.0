From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
 support
Date: Fri, 10 Jun 2011 14:47:30 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106101444490.20826__15706.0044505217$1307713711$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106101110130.11513@localhost6.localdomain6>
	<20110610134311.GK24424@n2100.arm.linux.org.uk>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110610134311.GK24424@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tuxonice-devel@tuxonice.net, Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 10 Jun 2011, Russell King - ARM Linux wrote:

[ ... ]
> What's the point when platform code has *ALREADY* to call these functions?
>
> Is it really too sodding difficult for platforms to do:
>
> my_suspend_hook()
> {
> 	mach_pre_suspend_hook();
> 	cpu_suspend();
> 	mach_post_suspend_hook();
> }
>
> ?
>
> <not read the rest of the message, this is getting idiotic>
>

Sorry for being unclear.

Yes, they already have to do all this. And they should.


Except for one thing:

They all, IN ADDITION, do ALSO:

 	wfi();			/* or whatever else to power down */


For Hibernation, _THAT_ needs to be out of the codepath.


So that one can snapshot without powering down.

FrankH.
