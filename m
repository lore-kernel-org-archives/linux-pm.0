From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: qcom-smbb: add extcon dependency
Date: Wed, 29 Jun 2016 23:16:09 +0200
Message-ID: <3941061.eCNkMs7lBz@wuerfel>
References: <20160629143056.7405-1-arnd@arndb.de> <57740F1A.5040007@codeaurora.org> <20160629210958.GB15422@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:52091 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcF2VUz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 17:20:55 -0400
In-Reply-To: <20160629210958.GB15422@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Courtney Cavin <courtney.cavin@sonymobile.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, June 29, 2016 11:09:58 PM CEST Sebastian Reichel wrote:
> On Wed, Jun 29, 2016 at 11:10:34AM -0700, Stephen Boyd wrote:
> > On 06/29/2016 07:38 AM, Sebastian Reichel wrote:
> > > On Wed, Jun 29, 2016 at 04:30:02PM +0200, Arnd Bergmann wrote:
> > >> Building the smbb driver without extcon results in a link failure:
> > >>
> > >> drivers/power/built-in.o: In function `smbb_usb_valid_handler':
> > >> :(.text+0x3190): undefined reference to `extcon_set_cable_state_'
> > >> drivers/power/built-in.o: In function `smbb_charger_probe':
> > >> :(.text+0x3880): undefined reference to `devm_extcon_dev_allocate'
> > >> :(.text+0x3898): undefined reference to `devm_extcon_dev_register'
> > >>
> > >> This adds a Kconfig dependency.
> > >>
> > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >> Fixes: 56d7df8716b2 ("power: Add Qualcomm SMBB driver")
> > 
> > extcon use was only recently introduced so this should be
> > 
> > Fixes: 0b7fe26ae602 ("power: qcom_smbb: Make an extcon for usb cable
> > detection")
> 
> Right, I didn't notice the Fixes line is wrong. Since I will have to
> rebase now, I will just squash this into 0b7fe26ae602.

Ok, thanks and sorry for the mixup, I must have pasted the wrong line.

	Arnd

