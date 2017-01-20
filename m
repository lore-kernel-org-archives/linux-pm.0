From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Thu, 19 Jan 2017 20:23:25 -0800
Message-ID: <20170120042323.GA6651@localhost.localdomain>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33864 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdATEXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 23:23:36 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so4609589pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jan 2017 20:23:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170120041400.GA24617@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernel@martin.sperl.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 19, 2017 at 08:14:02PM -0800, Eduardo Valentin wrote:
> Hello Martin,
> 
> On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel@martin.sperl.org wrote:
> > From: Martin Sperl <kernel@martin.sperl.org>
> > 
> > Add basic thermal driver for bcm2835 SOC.
> > 
> > This driver currently relies on the firmware setting up the
> > tsense HW block and does not set it up itself.
> > 
> > Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> > Acked-by: Eric Anholt <eric@anholt.net>
> > Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> > 
> 
> <cut>


Also, I am getting this warn from sparse:
drivers/thermal/bcm2835_thermal.c:110:16: warning: cast truncates bits
from constant value (3ffffffffff00 becomes ffffff00)
drivers/thermal/bcm2835_thermal.c:134:16: warning: cast truncates bits
from constant value (3ffffffffff becomes ffffffff)

Have you seen this?
