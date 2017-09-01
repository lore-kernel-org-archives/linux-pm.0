From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/5] devicetree: power: Add docs for TI BQ24190
 battery charger
Date: Fri, 1 Sep 2017 10:38:56 -0500
Message-ID: <20170901153856.f3ea3pteny7zii47@rob-hp-laptop>
References: <20170828212349.19037-1-liam@networkimprov.net>
 <20170828212349.19037-3-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34742 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdIAPi6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 11:38:58 -0400
Content-Disposition: inline
In-Reply-To: <20170828212349.19037-3-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Mon, Aug 28, 2017 at 02:23:46PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Document monitored-battery and ti,system-minimum-microvolt properties.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/power/supply/bq24190.txt   | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt

Acked-by: Rob Herring <robh@kernel.org>
