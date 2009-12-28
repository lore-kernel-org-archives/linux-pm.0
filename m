From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] phylib: Properly reinitialize PHYs after
 hibernation
Date: Sun, 27 Dec 2009 21:55:04 -0800 (PST)
Message-ID: <20091227.215504.71112983.davem__25345.8866769963$1261979789$gmane$org@davemloft.net>
References: <20091222221451.GB9268@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091222221451.GB9268@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: cbouatmailru@gmail.com
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, leoli@freescale.com, afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Wed, 23 Dec 2009 01:14:51 +0300

> Since hibernation assumes power loss, we should fully reinitialize
> PHYs (including platform fixups), as if PHYs were just attached.
> 
> This patch factors phy_init_hw() out of phy_attach_direct(), then
> converts mdio_bus to dev_pm_ops and adds an appropriate restore()
> callback.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
