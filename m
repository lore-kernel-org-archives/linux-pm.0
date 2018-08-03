From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
Date: Thu, 2 Aug 2018 17:24:52 -0700
Message-ID: <20180803002452.GV68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-4-mka@chromium.org>
 <CGME20180802233605epcas2p2fc6b1cef0dc773f6c7e59017721917bc@epcas2p2.samsung.com>
 <20180802233600.GT68975@google.com>
 <5B639BD2.5050008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B639BD2.5050008@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 03, 2018 at 09:03:30AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 03일 08:36, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > this patch and "PM / devfreq: Fix handling of min/max_freq == 0"
> > address issues not directly related with the throttler. It seems it
> > could still take a while for the throttler to move forward, do you
> > want me to spin out these two patches so that they can get merged
> > independently from the rest of the series?
> 
> How about resend the devfreq patches(patch1/2/3/4/6) which don't depend on
> throttler core with my reviewed tag? Maybe, it is easy to merge them through Myungjoo.

Sure, I can do this if you think it is reasonable to merge all these
patches without the throttler.

These are the patches we are talking about and my interpretation of
their status:

[01] PM / devfreq: Init user limits from OPP limits, not viceversa
  landed in Rafaels tree

[02] PM / devfreq: Fix handling of min/max_freq == 0
  independent fix, can land

[03] PM / devfreq: Don't adjust to user limits in governors
  independent improvement, can land

[04] PM / devfreq: Add struct devfreq_policy
  edge case, can land if devfreq maintainers think that factoring out
  some fields to the policy struct is an improvement independently of
  the throttler

[05] PM / devfreq: Add support for policy notifiers
  under heavy discussion ;-), can't land

[06] PM / devfreq: Make update_devfreq() public
  has no user without the throttler, not sure if it should be merged
  without it. up to devfreq maintainers.

Please let me know what you think

Thanks

Matthias
