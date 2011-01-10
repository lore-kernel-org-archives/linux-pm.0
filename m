From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] forcedeth: Do not use legacy PCI power
	management
Date: Sun, 09 Jan 2011 16:20:52 -0800 (PST)
Message-ID: <20110109.162052.98884306.davem__32954.4907356196$1294618914$gmane$org@davemloft.net>
References: <201101070049.16833.rjw@sisk.pl> <201101072212.05449.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101072212.05449.rjw@sisk.pl>
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
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 7 Jan 2011 22:12:05 +0100

> Subject: forcedeth: Do not use legacy PCI power management (v2)
> 
> The forcedeth driver uses the legacy PCI power management, so it has
> to do PCI-specific things in its ->suspend() and ->resume() callbacks
> and some of them are not done correctly.
> 
> Convert forcedeth to the new PCI power management framework and make
> it let the PCI subsystem take care of all the PCI-specific aspects of
> device handling during system power transitions.
> 
> Tested with nVidia Corporation MCP55 Ethernet (rev a2).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied, thanks.
