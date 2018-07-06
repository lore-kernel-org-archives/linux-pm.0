From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Date: Fri, 6 Jul 2018 11:09:23 -0700
Message-ID: <20180706180923.GH129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
 <20180703234705.227473-8-mka@chromium.org>
 <5B3C5B78.6020401@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B3C5B78.6020401@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:

> I didn't see any framework which exporting the class instance.
> It is very dangerous. Unknown device drivers is able to reset
> the 'devfreq_class' instance. I can't agree this approach.

While I agree that it is potential dangerous it is actually a common
practice to export the class:

grep "extern struct class " include/linux/ -R
include/linux/rio.h:extern struct class rio_mport_class;
include/linux/tty.h:extern struct class *tty_class;
include/linux/fb.h:extern struct class *fb_class;
include/linux/ide.h:extern struct class *ide_port_class;
include/linux/device.h:extern struct class * __must_check __class_create(struct module *owner,
include/linux/devfreq.h:extern struct class *devfreq_class;
include/linux/switchtec.h:extern struct class *switchtec_class;
include/linux/input.h:extern struct class input_class;
include/linux/genhd.h:extern struct class block_class;
include/linux/power_supply.h:extern struct class *power_supply_class;
include/linux/rtc.h:extern struct class *rtc_class;

struct class_interface and class_interface_register() would be
pointless without exported classes.

My understanding is that the kernel is often lax on encapsulation and
exposes private/delicate data pragmatically within the kernel when
needed because "the kernel trusts itself".

Thanks

Matthias
