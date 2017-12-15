From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Thu, 14 Dec 2017 17:29:50 -0800
Message-ID: <001e01d37544$354e82c0$9feb8840$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net> <20171213061759.GT25177@vireshk-i7> <000701d37479$e0570320$a1050960$@net> <HE1PR0402MB2828076F9049436EFE149A29F30A0@HE1PR0402MB2828.eurprd04.prod.outlook.com> PYBveIvmB7WlePYC0enKU6
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:60422 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754538AbdLOB3y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Dec 2017 20:29:54 -0500
In-Reply-To: PYBveIvmB7WlePYC0enKU6
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Andy Tang' <andy.tang@nxp.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>

Hi,

On 2017.12.14 Stratos Karafotis wrote:

> I'm not sure I understood what the problem is (maybe because I can't see
> the description of the issue in the quotes).

For my part of it, the problem is that the default sample_period for
the intel_cpufreq scaling driver (i.e. intel_pstate in passive mode)
is 500 uSec. Everything, as far as I can determine, becomes busted if
the sampling period is less than a jiffy.

By the way, the default sampling period for the acpi_cpufreq driver seems to be
10 milliseconds, and everything is fine. I do not know why the defaults for
the intel_cpufreq driver are so short, and suggest that they shouldn't be,
in which case your commit might be O.K.

>
> Commit 00bfe05889e91b5112893b001e4a47b0a0f8bdd7 affects only conservative
> governor.
> Do you have the same issue with ondemand too?

Yes, this entire thread has been about the conservative governor.

That was the first time Andy mentioned issues with on demand, but
I do see it misbehave with the intel_cpufreq default sample period
(a.k.a sampling_rate) of 500uSec. See another e-mail I send in a moment.

... Doug
