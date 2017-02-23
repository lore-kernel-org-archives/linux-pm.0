From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: bcm283x: Add CPU thermal zone with 1
 trip point
Date: Wed, 22 Feb 2017 17:54:58 -0800
Message-ID: <20170223015456.GA7769@localhost.localdomain>
References: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
 <1486928328-25870-2-git-send-email-stefan.wahren@i2se.com>
 <20170219011753.GB21016@localhost.localdomain>
 <1762674971.70633.1487507509664@email.1und1.de>
 <20170219212659.GA22580@localhost.localdomain>
 <9493160.170101.1487700876375@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36438 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbdBWBzX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2017 20:55:23 -0500
Content-Disposition: inline
In-Reply-To: <9493160.170101.1487700876375@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: kernel@martin.sperl.org, Frank Rowand <frowand.list@gmail.com>, Eric Anholt <eric@anholt.net>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hey,

On Tue, Feb 21, 2017 at 07:14:36PM +0100, Stefan Wahren wrote:
> > 

<cut>

> 
> I prepared a new patch series to fix that issue in my github repo [1]. At first we need to implement a new function of_property_read_s32_array() [2]. After that we could use this function in of-thermal in order to use signed integer for both coefficients [3].
> 
> @Eduardo: Is it okay for you?
> 

Yes, as I mentioned before, I am OK to patch of-thermal. And the
representation of offset and slope are already signed.

> @Martin: Do you want to send the next version of the patch series or should i?
> 
> [1] - https://github.com/lategoodbye/rpi-zero/commits/thermal
> [2] - https://github.com/lategoodbye/rpi-zero/commit/3dc43581ada74d1345f79b4c36562fdf5f7941e5
> [3] - https://github.com/lategoodbye/rpi-zero/commit/c02ed37c0ebdca98aee570862af10e90b3c9a0d0
> 

Number 3 is fine with me. Please send them in a single series for proper
review in linux-pm.

BR,
