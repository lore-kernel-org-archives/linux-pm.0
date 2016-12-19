From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] power: supply: bq24735-charger: optionally poll the
 ac-detect gpio
Date: Mon, 19 Dec 2016 16:16:04 -0600
Message-ID: <20161219221604.zkwxoodte4tp7u6q@rob-hp-laptop>
References: <20161214151026.5q6goxlfscv53tol@earth>
 <1481794126-5670-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33064 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbcLSWQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 17:16:07 -0500
Content-Disposition: inline
In-Reply-To: <1481794126-5670-1-git-send-email-peda@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Dec 15, 2016 at 10:28:46AM +0100, Peter Rosin wrote:
> If the ac-detect gpio does not support interrupts, provide a fallback
> to poll the gpio at a configurable interval.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
> 
> v2 -> v3 changes:
> - use device_property_read_u32 instead of of_property_read_u32
> 
> v1 -> v2 changes:
> - use poll-interval instead of ti,poll-interval-ms in the bindings
> 
> Cheers,
> peda
> 
>  .../bindings/power/supply/ti,bq24735.txt           |  2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/supply/bq24735-charger.c             | 49 +++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)
