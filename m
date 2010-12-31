From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] tg3: Do not use legacy PCI power management
Date: Fri, 31 Dec 2010 11:14:40 -0800 (PST)
Message-ID: <20101231.111440.28810446.davem__48481.0736416422$1293822919$gmane$org@davemloft.net>
References: <201012252356.23424.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012252356.23424.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, mcarlson@broadcom.com, mchan@broadcom.com
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 25 Dec 2010 23:56:23 +0100

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The tg3 driver uses the legacy PCI power management, so it has to do
> some PCI-specific things in its ->suspend() and ->resume() callbacks,
> which isn't necessary and should better be done by the PCI
> sybsystem-level power management code.
> 
> Convert tg3 to the new PCI power management framework and make it
> let the PCI subsystem take care of all the PCI-specific aspects of
> device handling during system power transitions.
> 
> Tested on HP nx6325 with a NetXtreme BCM5788 adapter.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied.
