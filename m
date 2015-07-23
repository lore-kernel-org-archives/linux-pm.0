From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCHv2 0/3] regmap: Use different lockdep class for each regmap
 init call
Date: Thu, 23 Jul 2015 16:45:53 +0800
Message-ID: <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35763 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbGWIpy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 04:45:54 -0400
Received: by oihq81 with SMTP id q81so161000344oih.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2015 01:45:54 -0700 (PDT)
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Boichat <drinkcat@chromium.org>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <maxime.coquelin@st.com>, Ajit

Hi Mark,

On Wed, Jul 8, 2015 at 2:30 PM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> Second version. Small fixup in the regmap patch itself [3/3] (the
> declaration of __devm_regmap_init_ac97 was missing lock_key/name
> parameters).
>
> Also, there are 2 drivers that are using function pointers named
> "regmap_init", which causes problems as it is now a macro: put these
> in parentheses to prevent the preprocessor from substituting them.
>
> Patches 1+2 should be pushed first to avoid breaking git bissect.
>
> Compile tested with allyesconfig on x86_64 and arm.
>
> Nicolas Boichat (3):
>   mfd: vexpress: Add parentheses around bridge->ops->regmap_init call
>   thermal: sti: Add parentheses around bridge->ops->regmap_init call
>   regmap: Use different lockdep class for each regmap init call

What's the status of this series (and the additional documentation
fix: https://lkml.org/lkml/2015/7/8/385)?

Do we need acks from the mfd/vexpress and thermal maintainers?
(mfd/vexpress maintainers are Liviu Dudau, Sudeep Holla, and Lorenzo
Pieralisi, I'm less clear about thermal, maybe Eduardo Valentin?)

Thanks!
