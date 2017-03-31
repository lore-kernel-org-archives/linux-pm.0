From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH V12 4/4] thermal: bcm2835: add thermal driver for bcm2835
 SoC
Date: Fri, 31 Mar 2017 23:22:44 +0200
Message-ID: <8a96e828806c94be51820c1cd1557025@milecki.pl>
References: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
 <1490990586-30898-5-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:46272 "EHLO
        16.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbdDAA7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 20:59:34 -0400
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 619EB661FD
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 23:22:55 +0200 (CEST)
In-Reply-To: <1490990586-30898-5-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On 2017-03-31 22:03, Stefan Wahren wrote:
> Add basic thermal driver for bcm2835 SoC.
> 
> This driver currently make sure that tsense HW block is set up
> correctly.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Acked-by: Eric Anholt <eric@anholt.net>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

It works great on Raspberry Pi Zero W!

Tested-by: Rafał Miłecki <rafal@milecki.pl>

Sorry for the earlier false failure report. I guess I was missing 
something,
maybe some DT change? Anyway, it works now! :)
