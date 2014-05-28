From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] regulators: Add definition of regulator_set_voltage_time()
 for !CONFIG_REGULATOR
Date: Wed, 28 May 2014 21:59:37 +0530
Message-ID: <CAKohpo=AnusM2FGs=JLozSyTc0N7SDXQxe+rPiLEHP6ewxY4ow@mail.gmail.com>
References: <1780c3205893be8567fa29ccd86674e2f32555b4.1401192160.git.viresh.kumar@linaro.org>
	<20140527192923.GC12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52477 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbaE1Q3h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 May 2014 12:29:37 -0400
Received: by mail-oa0-f46.google.com with SMTP id g18so690277oah.19
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2014 09:29:37 -0700 (PDT)
In-Reply-To: <20140527192923.GC12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>

On 28 May 2014 00:59, Mark Brown <broonie@kernel.org> wrote:
> Hrm, I'd have expected this to return -EINVAL when stubbed.  I'd also
> have expected regulator_set_voltage() to return -EINVAL mind you.  I

Or ENOSYS ? I will fix both routines once you confirm..
