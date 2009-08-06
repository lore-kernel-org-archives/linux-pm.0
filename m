From: Steve.Glendinning@smsc.com
Subject: Re: [PATCH 5/5] net: smsc911x: switch to new dev_pm_ops
Date: Thu, 6 Aug 2009 12:53:45 +0100
Message-ID: <OF06D1E485.71250FEA-ON8025760A.003F9572-8025760A.00415798__18937.3022680686$1249570842$gmane$org@smsc.com>
References: <20090805.202922.241102337.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090805.202922.241102337.davem@davemloft.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@caiaq.de, Ian.Saturley@smsc.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

David Miller <davem@davemloft.net> wrote on 06/08/2009 04:29:22:

> From: Daniel Mack <daniel@caiaq.de>
> Date: Wed,  5 Aug 2009 20:29:31 +0200
> 
> > Hibernation is unsupported for now, which meets the actual
> > implementation in the driver. For free/thaw, the chip's D2 state 
should
> > be entered.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> Steve, if it looks good to you I can toss this into net-next-2.6
> 
> Just let me know.

Looks fine.  Compiles ok and doesn't actually change any PM 
implementation.

Acked-by: <steve.glendinning@smsc.com>

Unfortunately I can't test it.  The only dev platform I have in front of 
me
is SH7709S, which doesn't boot since 
4ff29ff8e8723a41e7defd8bc78a7b16cbf940a2
(the sh maintainers are aware and working on it:
http://marc.info/?l=linux-sh&m=124891631203530&w=2)

Steve
