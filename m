From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
Date: Wed, 1 Aug 2018 10:39:46 -0700
Message-ID: <20180801173946.GL68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234851epcas2p366dcf068db0a7761d7cdccabc4f1fb6e@epcas2p3.samsung.com>
 <20180703234705.227473-10-mka@chromium.org>
 <5B616F0D.1050901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B616F0D.1050901@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Wed, Aug 01, 2018 at 05:27:57PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 04일 08:47, Matthias Kaehlcke wrote:
> > The Throttler is used for non-thermal throttling of system components
> > like CPUs or devfreq devices.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> If possible, I hope the more detailed example for "cpu0_opp03, &cpu1_opp02, &gpu_opp03"
> because I'm confusing the meaning of 'cpu0_opp03' phandle.

I omitted the OPP definitions to avoid cluttering the example. I'm
happy to add them if DT folks also think it would add value.

> cpu0_opp03 indicates the only one specific OPP entry among set of
> OPP entries of CPU0 cpufreq? or cpu0_opp03 indicates the set of OPP
> entries for CPU0 cpufreq ?

cpu0_opp03 and the other phandles are specific OPP entries, that
indicate the throttler which frequencies/OPPs should be used for
throttling. For devices/CPUs with multiple levels of throttling
multiple entries from its OPP set are listed. In the example a single
level of throttling is used for all devices/CPUs.
