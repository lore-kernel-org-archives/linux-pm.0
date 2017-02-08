From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add thermal zone to bcm2835-thermal
 example
Date: Wed, 8 Feb 2017 16:02:03 -0600
Message-ID: <20170208220203.j4yjysg42e5gn2wx@rob-hp-laptop>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
 <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33441 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdBHWEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2017 17:04:32 -0500
Content-Disposition: inline
In-Reply-To: <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, Feb 04, 2017 at 02:16:26PM +0000, Stefan Wahren wrote:
> Add a thermal zone in order to make the example complete.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/thermal/brcm,bcm2835-thermal.txt      |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
