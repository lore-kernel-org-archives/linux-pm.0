From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/5] power_supply: charger-manager: add missing of_node_put
Date: Mon, 12 Oct 2015 11:20:33 +0900
Message-ID: <CAJKOXPc+42NMUkvnned-CcjKGzPt8KRUORV9ex3tuq+=_HBW0w@mail.gmail.com>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
	<1444480254-14399-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:32927 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbJLCUe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Oct 2015 22:20:34 -0400
In-Reply-To: <1444480254-14399-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Sebastian Reichel <sre@kernel.org>, kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>

2015-10-10 21:30 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> for_each_child_of_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
>
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
>
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> (
>    return child;
> |
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  drivers/power/charger-manager.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
