From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/5] Generic GPIO connected chargers support
Date: Wed, 17 Jan 2018 21:27:01 +0100
Message-ID: <20180117202701.GA8774@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33078 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeAQU1h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 15:27:37 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994728AbeAQU1fcuKpE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 21:27:35 +0100
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Hi,

this patchset tries to implement an idea mentioned here:
https://marc.info/?l=linux-pm&m=149849407023228&w=2
(with comments taken into account).

First two patches could be possibly merged as these are
cleanups only.

I'm sending the rest as a basis for a discussion which will hopefuly
bring some bright ideas :)

Thank you,
	ladis

Ladislav Michl (5):
  power: supply: gpio-charger: Drop driver remove function
  power: supply: gpio-charger: use helper variable to access device info
  power: supply: gpio-charger: generic gpio algo
  power: supply: gpio-charger: LTC3651 support
  power: supply: gpio-charger: LM3658 support

 drivers/power/supply/gpio-charger.c | 486 ++++++++++++++++++++++++++----------
 1 file changed, 348 insertions(+), 138 deletions(-)

-- 
2.15.1
