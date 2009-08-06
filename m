From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 5/5] net: smsc911x: switch to new dev_pm_ops
Date: Thu, 06 Aug 2009 13:26:04 -0700 (PDT)
Message-ID: <20090806.132604.241009415.davem__13468.924634117$1249590424$gmane$org@davemloft.net>
References: <20090805.202922.241102337.davem@davemloft.net>
	<OF06D1E485.71250FEA-ON8025760A.003F9572-8025760A.00415798@smsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <OF06D1E485.71250FEA-ON8025760A.003F9572-8025760A.00415798@smsc.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steve.Glendinning@smsc.com
Cc: linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@caiaq.de, Ian.Saturley@smsc.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Steve.Glendinning@smsc.com
Date: Thu, 6 Aug 2009 12:53:45 +0100

> David Miller <davem@davemloft.net> wrote on 06/08/2009 04:29:22:
> 
>> From: Daniel Mack <daniel@caiaq.de>
>> Date: Wed,  5 Aug 2009 20:29:31 +0200
>> 
>> > Hibernation is unsupported for now, which meets the actual
>> > implementation in the driver. For free/thaw, the chip's D2 state 
> should
>> > be entered.
>> > 
>> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
>> 
>> Steve, if it looks good to you I can toss this into net-next-2.6
>> 
>> Just let me know.
> 
> Looks fine.  Compiles ok and doesn't actually change any PM 
> implementation.
> 
> Acked-by: <steve.glendinning@smsc.com>

Applied, thanks everyone.
