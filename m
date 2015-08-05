From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [RFC] TI BQ242xx Battery Charger Development/Consolidation Plans
Date: Wed, 5 Aug 2015 11:05:21 -0500
Message-ID: <55C23441.2030305@ti.com>
References: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49162 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbbHEQFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 12:05:53 -0400
In-Reply-To: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: linux-pm@vger.kernel.org

Not too long I ago started working on a new driver called bq242xx_charger.c 
that will add support for TI's BQ24250, BQ24251, BQ24261M, and BQ24262 Li-Ion
battery charger/power-path management ICs and that work is about 50% done. I 
chose a working name of bq242xx_charger.c in the hopes that in addition to
providing immediate support for said devices that this driver can later be used
as a platform to add other devices of the BQ242xx sub-family in an effort to
re-use/consolidate and help keep drivers/power organized.

Long story short I also realized that we just got a new bq24257_charger.c
driver (for the BQ24257) already in the Linux 4.2 tree which creates somewhat
of a conflict with the bq242xx_charger.c work in progress.

I would like to solicit ideas/comments regarding the following plan of attack:

- Continue bq242xx_charger.c development as scoped in the first paragraph
- Work on getting it accepted into upstream
- As future work, absorb the already existing bq24257_charger.c driver into the
  bq242xx_charger.c driver, and deprecate its usage

There might be a potential risk for user confusion for a transitional time if
somebody was just looking at the filenames to select their driver due to part
number overlap. However I argue folks are more likely to go the Kconfig route
to select their driver so this may not be a problem after all.

Thanks!

-- 
Andreas Dannenberg
Texas Instruments Inc.

