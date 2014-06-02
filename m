From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time()
 for !CONFIG_REGULATOR
Date: Mon, 2 Jun 2014 22:25:18 +0530
Message-ID: <CAKohpo=4gY42TJ0CcUBarHRnUvFKkXTykTYCfGUnAZ+CFwYE9g@mail.gmail.com>
References: <20140527192923.GC12304@sirena.org.uk>
	<CAKohpo=AnusM2FGs=JLozSyTc0N7SDXQxe+rPiLEHP6ewxY4ow@mail.gmail.com>
	<20140528173858.GG5099@sirena.org.uk>
	<CAKohpokk_sNQ7Be5F8NLa7pLrssPm9qPf-fDEUYkiurJ6Etrpg@mail.gmail.com>
	<20140602095112.GV5099@sirena.org.uk>
	<CAKohpom7XNFJ7dBzNVW0TX3gyxo4RJdJ4yriYLa_noforhyciw@mail.gmail.com>
	<20140602100201.GX5099@sirena.org.uk>
	<CAKohpomj5-tHPkBLMrgGpsDCaCxW-8hGMunMTmJgXGgEgTR=vA@mail.gmail.com>
	<20140602122332.GA31751@sirena.org.uk>
	<CAKohpo=vPojhX_9u6Coa=2Kiu0jY9hCTg2B0WiWfJS8ZQxK4Rg@mail.gmail.com>
	<20140602152014.GL31751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36681 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbaFBQzT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 12:55:19 -0400
Received: by mail-oa0-f48.google.com with SMTP id g18so4855199oah.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2014 09:55:19 -0700 (PDT)
In-Reply-To: <20140602152014.GL31751@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>

On 2 June 2014 20:50, Mark Brown <broonie@kernel.org> wrote:
> No, not at all and I don't think it applies to the clock API either -
> it's got similar issues with real physical clocks not always supporting
> all operations.  Consider for a moment what happens if we try to set and
> then use a clock rate ona fixed clock.

Okay, so the patch 1/3 isn't enough as we need to fix other drivers as
well which are expected to work with CONFIG_REGULATOR=n. That
would be some work and will try to send a patchset for that..

As Rafael has asked you to apply the patches, can you please apply
patch 2-3 for now?

--
viresh
