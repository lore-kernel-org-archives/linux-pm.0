From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Fri, 24 Mar 2017 10:55:31 -0500
Message-ID: <20170324155531.gn6iw6w3f5nqbpnx@rob-hp-laptop>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34624 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936513AbdCXPze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 11:55:34 -0400
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Mon, Mar 20, 2017 at 02:43:26AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Documentation of static battery characteristics that can be defined
> for batteries which cannot self-identify. This information is required
> by fuel-gauge and charger chips for proper handling of the battery.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

While "simple" is not generally something I like to see in a compatible 
string, we've beat this one to death.

Acked-by: Rob Herring <robh@kernel.org>
