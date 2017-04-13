From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v12.6 08/11] devicetree: power: bq27xxx: Add
 monitored-battery documentation
Date: Thu, 13 Apr 2017 15:15:14 -0500
Message-ID: <20170413201514.seugnuncc43e6jyv@rob-hp-laptop>
References: <20170410050712.930-1-liam@networkimprov.net>
 <20170410050712.930-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33648 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdDMUPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 16:15:17 -0400
Content-Disposition: inline
In-Reply-To: <20170410050712.930-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Sun, Apr 09, 2017 at 10:07:09PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Document monitored-battery = <&battery_node>
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  .../devicetree/bindings/power/supply/bq27xxx.txt   | 31 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
