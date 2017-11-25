From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Sat, 25 Nov 2017 08:30:23 -0800
Message-ID: <000301d3660a$b4224fd0$1c66ef70$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> <002c01d35d0f$8b0416f0$a10c44d0$@net> FMl8e97ZchCDuFMlDezTwJ FS1bekJUDC2CsFSwpebYuw IH9feHKSnhSAJIHtze5qna
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:56813 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdKYQa3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Nov 2017 11:30:29 -0500
In-Reply-To: IH9feHKSnhSAJIHtze5qna
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Yu Chen' <yu.c.chen@intel.com>
Cc: =?utf-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?utf-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>, Doug Smythies <dsmythies@telus.net>

On 2017.11.24 09:36 Doug Smythies wrote:

> Phoronix mafft: 1.8% MORE energy; ~3.5% performance DEGRADATION. (investigation pending.)

Investigation complete. ~400 more Phoronix mafft tests were done. The revised results are:

Phoronix mafft: no consistent energy or performance change.

... Doug
