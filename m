From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Net / jme: Do not use legacy PCI power
	management
Date: Sun, 27 Mar 2011 18:36:10 -0700 (PDT)
Message-ID: <20110327.183610.15256387.davem__15405.172648798$1301276451$gmane$org@davemloft.net>
References: <201103261234.06274.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103261234.06274.rjw@sisk.pl>
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
Date: Sat, 26 Mar 2011 12:34:06 +0100

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The jme driver uses the legacy PCI power management, so it has to do
> some PCI-specific things in its ->suspend() and ->resume() callbacks,
> which isn't necessary and should better be done by the PCI
> sybsystem-level power management code.  It also doesn't use device
> wakeup flags correctly.
> 
> Convert jme to the new PCI power management framework and make it
> let the PCI subsystem take care of all the PCI-specific aspects of
> device handling during system power transitions.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied, thanks a lot.
