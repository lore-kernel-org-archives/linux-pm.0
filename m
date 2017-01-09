From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] devicetree: property-units: add mWh and mAh units
Date: Mon, 9 Jan 2017 11:53:30 -0600
Message-ID: <20170109175330.c7hbl4kic22bhf5m@rob-hp-laptop>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-2-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33094 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbdAIRxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 12:53:35 -0500
Content-Disposition: inline
In-Reply-To: <20170105021007.22088-2-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: tony@atomide.com, sre@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Jan 04, 2017 at 06:10:05PM -0800, Matt Ranostay wrote:
> Add entries for microwatt-hours and microamp-hours to property
> units.
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  Documentation/devicetree/bindings/property-units.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

This can go in with the rest of the series.

Rob

