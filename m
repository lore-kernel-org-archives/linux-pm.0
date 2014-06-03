From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time()
 for !CONFIG_REGULATOR
Date: Tue, 3 Jun 2014 20:10:00 +0530
Message-ID: <CAKohpo=T3BG9X0gHfRA-x8B3ou3Y=XHcs=OTYAHikX61iAJ9xw@mail.gmail.com>
References: <1780c3205893be8567fa29ccd86674e2f32555b4.1401192160.git.viresh.kumar@linaro.org>
	<20140527192923.GC12304@sirena.org.uk>
	<CAKohpo=AnusM2FGs=JLozSyTc0N7SDXQxe+rPiLEHP6ewxY4ow@mail.gmail.com>
	<20140528173858.GG5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35882 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaFCOkB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jun 2014 10:40:01 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so6178635oac.25
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2014 07:40:00 -0700 (PDT)
In-Reply-To: <20140528173858.GG5099@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>

On 28 May 2014 23:08, Mark Brown <broonie@kernel.org> wrote:
> Whatever - I don't think the particular code makes any practical
> difference.  We would need to audit existing users who don't have a
> REGULATOR dependency for breakage though.

Exactly what kind of drivers are we looking to fix here? These might
be the possible cases:
- We are checking 'regulator pointer' before calling and don't need to
handle anything there..
- drivers depend on CONFIG_REGULATOR and so again we don't need
to handle anything
- None of above are true and drivers aren't checking return value of
regulator_set_voltage()
OR
They are checking it and failing when it failed..

What do we want to do in these cases?
