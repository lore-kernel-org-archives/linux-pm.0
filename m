From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 02/12] PM / devfreq: Fix handling of min/max_freq == 0
Date: Mon, 18 Jun 2018 13:12:41 -0700
Message-ID: <20180618201239.GA153862@rodete-desktop-imager.corp.google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-3-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180614194712.102134-3-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 12:47:02PM -0700, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> devfreq device") initializes df->min/max_freq with the min/max OPP when
> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") adds df->scaling_min/max_freq and the
> following to the frequency adjustment code:
> 
>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> 
> With the current handling of min/max_freq this is incorrect:
> 
> Even though df->max_freq is now initialized to a value != 0 user space
> can still set it to 0, in this case max_freq would be 0 instead of
> df->scaling_max_freq as intended. In consequence the frequency adjustment
> is not performed:
> 
>   if (max_freq && freq > max_freq) {
> 	freq = max_freq;
> 
> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> when the user passes a value of 0. This also prevents df->max_freq from
> being set below the min OPP when df->min_freq is 0, and similar for
> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> checks for this case can be removed.
> 
> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

FWIW, I've reviewed patches 1-9 (the core devfreq bugfixes and features,
and a small cpufreq helper fixup), and they seem pretty clear and good
to me, aside from a minor error in the current subject
(s/devfreg/devfreq/). So:

Reviewed-by: Brian Norris <briannorris@chromium.org>
