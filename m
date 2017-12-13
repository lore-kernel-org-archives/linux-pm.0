From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Wed, 13 Dec 2017 08:49:46 -0800
Message-ID: <000801d37432$637cdab0$2a769010$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net> P0Mmegy2kTqmMP0MoeccOV P9fLe8wpe7WleP9fMeeBW3
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:42741 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753164AbdLMQtu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 11:49:50 -0500
In-Reply-To: P9fLe8wpe7WleP9fMeeBW3
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Andy Tang' <andy.tang@nxp.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Doug Smythies' <dsmythies@telus.net>

Hi Viresh,

In addition to what I wrote earlier:

I can also make the conservative governor work under the
intel_cpufreq scaling driver, with the default 500 uSec
sampling time, by increasing the
/sys/devices/system/cpu/cpufreq/conservative/freq_step
value from the default of 5 to 100.

In this case there is not a specific break point freq_step,
but rather a very gradual increase in CPU freq as a function
of freq_step for a 100% load on a CPU.

Now, I wonder if the two issues here might be related after all.

... Doug
