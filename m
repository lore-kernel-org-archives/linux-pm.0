From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] pci: fix kexec with power state D3
Date: Sun, 8 Mar 2009 11:15:30 +0100
Message-ID: <20090308101530.GB14133__42020.9394339055$1236507570$gmane$org@elte.hu>
References: <49B1F934.5050006@kernel.org>
	<4807377b0903062318q15ba52a7n82d4c9399b8a7fa8@mail.gmail.com>
	<49B37D38.7060304@kernel.org> <200903081108.24541.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903081108.24541.rjw@sisk.pl>
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

> On Sunday 08 March 2009, Yinghai Lu wrote:
> > 
> > Impact: second kernel by kexec will have some pci devices working
> > 
> > Found one system with 82575EB, in the kernel that is kexeced, probe igb
> > failed with -2.
> > 
> > it looks like the same behavior happened on forcedeth.
> > try to check system_state to make sure if put it on D3
> 
> This is not enough, because the PM code doesn't change 
> system_state and it uses pci_set_power_state too.
> 
> > Jesse Brandeburg said that we should do that check in core 
> > code instead of every device driver.
> 
> Well, I'm not really sure.  The drivers are where the bug is.

So Yinghai has now written a driver fix and a generic code fix 
as well and both are being rejected pointing to the other side? 

This really sucks for users (who'd be happy with any of the 
patches) and the disagreement needs to be resolved ASAP.

	Ingo
