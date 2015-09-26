From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 00/26] ARM: pxa: magician: Rework HTC Magician support
Date: Sat, 26 Sep 2015 17:15:57 +0200
Message-ID: <87zj09fbyq.fsf@belgarion.home>
References: <55FA4756.9080309@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55FA4756.9080309@tul.cz> (Petr Cvek's message of "Thu, 17 Sep
	2015 06:53:42 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, philipp.zabel@gmail.com
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patchset will clean, fix, optimize and add multiple devices,
> which can be found on the HTC Magician machine.
... zip ...
>  arch/arm/mach-pxa/include/mach/magician.h |  78 +--
>  arch/arm/mach-pxa/magician.c              | 907 +++++++++++++++++++++---------
>  2 files changed, 682 insertions(+), 303 deletions(-)

Ok Petr, that's way better.
This is how I see the next step :
 1) You fix the patch 1/26 and resend only that one, it's trivial whitespacing,
    no need to send another complete patchset
 2) I wait a week for Philip to ack all the patches I replied to (ie. all except
    patch 19/26 and 22/26)
 3) If Philipp doesn't NAK, then I'll queue all these patches to my next tree
    (git://github.com/rjarzmik/linux.git pxa/for-next)

Meanwhile, I'll have time to answer to patches 19 and 22. Next Sunday, I'll
reply once more that I have queued your patches (provided that you update patch
1/26), and you will be able to rebase on this tree, leaving at most 2 patches to
deal with.

Cheers.

-- 
Robert
