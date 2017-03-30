From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V11 6/6] thermal: bcm2835: add thermal driver for bcm2835
 SoC
Date: Wed, 29 Mar 2017 21:57:27 -0700
Message-ID: <20170330045725.GA12995@localhost.localdomain>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-7-git-send-email-stefan.wahren@i2se.com>
 <20170329045807.GC2582@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34545 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754233AbdC3E5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 00:57:31 -0400
Content-Disposition: inline
In-Reply-To: <20170329045807.GC2582@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Mar 28, 2017 at 09:58:09PM -0700, Eduardo Valentin wrote:
> On Sun, Mar 12, 2017 at 10:11:05PM +0000, Stefan Wahren wrote:
> > Add basic thermal driver for bcm2835 SoC.
> > 
> > This driver currently make sure that tsense HW block is set up
> > correctly.
> > 
> > Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Acked-by: Eric Anholt <eric@anholt.net>
> 
> I see no issue with this driver at this point.
> 
> As I mentioned, the full series needs to go together. You either get an
> Ack from OF maintainers, and I take the series, or you can add my
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> 
> after fixing the small comment from Nobuhiro.
> 

Based on other drivers that require negative values, I assume patches 1
and 2 of these series are needed, but more for enforcing the API, given
that the current of-thermal driver still retrieves the negative values
from DTB [1].

A third option on top of what I suggested above is to split the series.
Given that you could still get the proper coefficients
with current of-thermal, I would suggest you to split this series into
two (patches 1-2, 3-6) in your next version, so we avoid futher delays
on the driver, while patches 1-2 waits for acks from OF side.

[1] - https://patchwork.kernel.org/patch/9612613/
