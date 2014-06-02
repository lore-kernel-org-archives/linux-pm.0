From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time()
 for !CONFIG_REGULATOR
Date: Mon, 2 Jun 2014 15:24:05 +0530
Message-ID: <CAKohpom7XNFJ7dBzNVW0TX3gyxo4RJdJ4yriYLa_noforhyciw@mail.gmail.com>
References: <1780c3205893be8567fa29ccd86674e2f32555b4.1401192160.git.viresh.kumar@linaro.org>
	<20140527192923.GC12304@sirena.org.uk>
	<CAKohpo=AnusM2FGs=JLozSyTc0N7SDXQxe+rPiLEHP6ewxY4ow@mail.gmail.com>
	<20140528173858.GG5099@sirena.org.uk>
	<CAKohpokk_sNQ7Be5F8NLa7pLrssPm9qPf-fDEUYkiurJ6Etrpg@mail.gmail.com>
	<20140602095112.GV5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:65050 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbaFBJyF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 05:54:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so4382822oag.40
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2014 02:54:05 -0700 (PDT)
In-Reply-To: <20140602095112.GV5099@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>

On 2 June 2014 15:21, Mark Brown <broonie@kernel.org> wrote:
> When you say they check for a valid regulator how are they doing that?
> The stub will come into play if there isn't a dependency on REGULATOR.

I meant they fail and quit if regulator_get() failed and so the first parameter
to regulator_set_voltage() is guaranteed to be valid.
