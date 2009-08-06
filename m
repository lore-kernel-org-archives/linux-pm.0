From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 5/5] net: smsc911x: switch to new dev_pm_ops
Date: Wed, 05 Aug 2009 20:29:22 -0700 (PDT)
Message-ID: <20090805.202922.241102337.davem__5016.08207491717$1249529421$gmane$org@davemloft.net>
References: <1249496971-9019-3-git-send-email-daniel@caiaq.de>
	<1249496971-9019-4-git-send-email-daniel@caiaq.de>
	<1249496971-9019-5-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1249496971-9019-5-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: daniel@caiaq.de
Cc: steve.glendinning@smsc.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Daniel Mack <daniel@caiaq.de>
Date: Wed,  5 Aug 2009 20:29:31 +0200

> Hibernation is unsupported for now, which meets the actual
> implementation in the driver. For free/thaw, the chip's D2 state should
> be entered.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

Steve, if it looks good to you I can toss this into net-next-2.6

Just let me know.
