From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V12 2/4] ARM: dts: bcm283x: Add CPU thermal zone with 1
 trip point
Date: Sat, 1 Apr 2017 09:37:18 -0700
Message-ID: <20170401163717.GB28514@localhost.localdomain>
References: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
 <1490990586-30898-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35083 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdDAQhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 12:37:22 -0400
Content-Disposition: inline
In-Reply-To: <1490990586-30898-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Mar 31, 2017 at 08:03:04PM +0000, Stefan Wahren wrote:
> As suggested by Eduardo Valentin this adds the thermal zone for
> the bcm2835 SoC with its single thermal sensor. We start with
> the criticial trip point and leave the cooling devices empty
> since we don't have any at the moment. Since the coefficients
> could vary depending on the SoC we need to define them separate.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>
