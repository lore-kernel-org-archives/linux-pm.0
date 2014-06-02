From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time()
 for !CONFIG_REGULATOR
Date: Mon, 2 Jun 2014 12:50:59 +0530
Message-ID: <CAKohpokk_sNQ7Be5F8NLa7pLrssPm9qPf-fDEUYkiurJ6Etrpg@mail.gmail.com>
References: <1780c3205893be8567fa29ccd86674e2f32555b4.1401192160.git.viresh.kumar@linaro.org>
	<20140527192923.GC12304@sirena.org.uk>
	<CAKohpo=AnusM2FGs=JLozSyTc0N7SDXQxe+rPiLEHP6ewxY4ow@mail.gmail.com>
	<20140528173858.GG5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:63637 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbaFBHVA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 03:21:00 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so4224939oag.20
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2014 00:20:59 -0700 (PDT)
In-Reply-To: <20140528173858.GG5099@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>

On 28 May 2014 23:08, Mark Brown <broonie@kernel.org> wrote:
> Whatever - I don't think the particular code makes any practical
> difference.  We would need to audit existing users who don't have a
> REGULATOR dependency for breakage though.

I tried auditing all 29 files which had this symbol: regulator_set_voltage
and couldn't find anything which might break with the proposed change.

Either these are making sure that we have a valid regulator or they have
code inside #ifdef CONFIG_REGULATOR ..
