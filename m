From: Ladislav Michl <ladis@linux-mips.org>
Subject: LTC3651 and other GPIO chargers
Date: Mon, 26 Jun 2017 18:21:06 +0200
Message-ID: <20170626162105.rgewvl2z2ftbxqyn@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:43438 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdFZQVJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2017 12:21:09 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992181AbdFZQVHPURhB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Jun 2017 18:21:07 +0200
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Sebastian Reichel <sre@kernel.org>

Hi there!

A driver for LTC3651 was recently added to -next
https://patchwork.kernel.org/patch/9717049/
which brings a question whenever we want to add separate driver
(or vendor specific bindings) for ever growing list of similar
chargers. For example those using the same status output lines
are: BQ24232HA, LTC4007, LTM8061, RT9502, LT3651, LT3650, TP4056,
MAX1737...
Others for example BQ24032A and LM3658 (which I have to support)
are using different status encoding, ie. LM3658:

stat1	stat2		Condition
  0	  0	Power-Down, charging is suspended or interrupted
  1	  0	Pre-qualification mode, CC and CV charging
  0	  1	Charge is completed
  1	  1	Bad battery (Safety timer expired), or LDO mode

What about extending gpio-charger instead?
- allow gpio list fdt subnode
  - consider each gpio line to represent bit in a word
- provide per property subnodes
  - each subnode holds a mask and mapping to property values
This way we should be able to cover most chargers providing status
using gpios. Comments welcome and appreciated - those will turn into
implementation.

Thank you,
	ladis
