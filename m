From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 11/11] misc: throttler: Add Chrome OS EC throttler
Date: Fri, 8 Jun 2018 08:56:44 -0700
Message-ID: <20180608155644.GE88063@google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-12-mka@chromium.org>
 <e1681e0f-2141-12a7-bed1-4d27a43ac9e8@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e1681e0f-2141-12a7-bed1-4d27a43ac9e8@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

On Fri, Jun 08, 2018 at 04:09:18PM +0200, Enric Balletbo i Serra wrote:

> On 07/06/18 20:12, Matthias Kaehlcke wrote:
> > The driver subscribes to throttling events from the Chrome OS
> > embedded controller and enables/disables system throttling based
> > on these events.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Changes in v2:
> > - added SPDX line instead of license boiler-plate
> > - use macro to avoid splitting line
> > - changed variable name for throttler from 'cte' to 'ce_thr'
> > - formatting fixes
> > - Kconfig: removed odd dashes around 'help'
> > - added 'Reviewed-by' tag
> > 
> > Note: I finally decided to keep 'Chrome OS' instead of changing it
> > to 'ChromeOS'. Both are currently used in the kernel, the latter is
> > currently more prevalent, however the official name is 'Chrome OS',
> > so there is no good reason to keep introducing the 'alternative' name.
> > 
> 
> I am pretty sure that somebody from Google told me the contrary, so
> 
> ¯\_(ツ)_/¯
> 
> Anyway, you will probably know better than me :)

The different names in the kernel code indicate that even folks at
Google disagree on this ;-) The name might have evolved over time.

chrome://chrome on a Chromebook names it 'Chrome OS', as do official
pages like https://www.google.com/chromebook/ and
https://www.chromium.org/chromium-os so I think it is better to use
this name.

> > +MODULE_LICENSE("GPL");
> 
> Something that I learnt recently. To match the SPDX-license tag you should set
> this to "GPL v2" [1]
> 
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]
> 
> [1] https://elixir.bootlin.com/linux/v4.17/source/include/linux/module.h#L172

Will update in the next revision

Thanks!

Matthias
