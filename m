From: David Miller <davem@davemloft.net>
Subject: Re: WOL with flex filters, reflecting it in /sys
Date: Thu, 01 Oct 2009 14:22:57 -0700 (PDT)
Message-ID: <20091001.142257.125105313.davem__40003.1054080047$1254432214$gmane$org@davemloft.net>
References: <76FA3B279DD9DA48896E2B404944957203C09587@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76FA3B279DD9DA48896E2B404944957203C09587@USA7061MS02.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin.Leisner@xerox.com
Cc: martyleisner@yahoo.com, netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: "Leisner, Martin" <Martin.Leisner@xerox.com>
Date: Thu, 1 Oct 2009 13:55:03 -0700

> What I'm thinking of is a hierarchy in /sys/classes/net/<device>/wol/
> 
> wol/
>    /flex-filters
>       /0
>            data -- hex data to match
>            mask -- string of 1 and 0 -- if 1, the data is valid in the
> bit 
>                    position
>       ...
>       /n
> 	   data
>          mask
>   /wake_up_packet
>   /traditional --r/w (0/1)
>      /magic_packet
>      /arp
>      /unicast
>      /multicast
>      /broadcast
>      /phy

That's a pretty hairy interface for users to learn.  Are you
really sure this is nicer than adding this facility to ethtool? :-)
