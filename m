From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] pci: fix kexec with power state D3
Date: Sun, 8 Mar 2009 12:08:35 +0100
Message-ID: <20090308110835.GB27811__46683.2956103191$1236510910$gmane$org@elte.hu>
References: <49B1F934.5050006@kernel.org> <20090308101530.GB14133@elte.hu>
	<200903081128.35970.rjw@sisk.pl> <200903081133.33020.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903081133.33020.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Wilcox <matthew@wil.cx>, NetDev <netdev@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Jesse Brandeburg <jesse.brandeburg@gmail.com>, linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Sunday 08 March 2009, Rafael J. Wysocki wrote:
> > On Sunday 08 March 2009, Ingo Molnar wrote:
> > > 
> > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > 
> > > > On Sunday 08 March 2009, Yinghai Lu wrote:
> > > > > 
> > > > > Impact: second kernel by kexec will have some pci devices working
> > > > > 
> > > > > Found one system with 82575EB, in the kernel that is kexeced, probe igb
> > > > > failed with -2.
> > > > > 
> > > > > it looks like the same behavior happened on forcedeth.
> > > > > try to check system_state to make sure if put it on D3
> > > > 
> > > > This is not enough, because the PM code doesn't change 
> > > > system_state and it uses pci_set_power_state too.
> > > > 
> > > > > Jesse Brandeburg said that we should do that check in core 
> > > > > code instead of every device driver.
> > > > 
> > > > Well, I'm not really sure.  The drivers are where the bug is.
> > > 
> > > So Yinghai has now written a driver fix and a generic code fix 
> > > as well and both are being rejected pointing to the other side? 
> > > 
> > > This really sucks for users (who'd be happy with any of the 
> > > patches) and the disagreement needs to be resolved ASAP.
> > 
> > I hope you read my other comment (that you deleted from the reply)?
> > 
> > If we're going to fix this at the core level along the Yinghai's patch lines,
> > we'll have to introduce a few additional values for system_state and make
> > suspend and hibernation code use them.
> > 
> > Do you think it's worth the effort, given that only a couple of drivers have
> > been found to be affected so far?
> 
> And, quite frankly, I'm not sure if users will be happy with 
> the $subject patch, because it _really_ breaks things (well, 
> the kexec users who don't use suspend might be, but surely 
> suspend users who don't use kexec won't).

Please note that i havent reviewed the patches and i did not 
take any sides in the discussion - i just flagged the maintainer 
ping-pong. As long as we pick one of the patches (or a third 
one) within a bound amount of time we should be fine :)

	Ingo
