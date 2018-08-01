From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Date: Wed, 1 Aug 2018 10:18:26 -0700
Message-ID: <20180801171826.GK68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
 <20180703234705.227473-8-mka@chromium.org>
 <5B3C5B78.6020401@samsung.com>
 <20180706180923.GH129942@google.com>
 <41164a91-b271-5f3b-b461-21ff5997cc84@samsung.com>
 <20180716194114.GA129942@google.com>
 <20180731192904.GG68975@google.com>
 <5B616CE0.50400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B616CE0.50400@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 01, 2018 at 05:18:40PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 01일 04:29, Matthias Kaehlcke wrote:
> > On Mon, Jul 16, 2018 at 12:41:14PM -0700, Matthias Kaehlcke wrote:
> >> Hi Chanwoo,
> >>
> >> On Thu, Jul 12, 2018 at 06:08:36PM +0900, Chanwoo Choi wrote:
> >>> Hi Matthias,
> >>>
> >>> On 2018년 07월 07일 03:09, Matthias Kaehlcke wrote:
> >>>> Hi,
> >>>>
> >>>> On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:
> >>>>
> >>>>> I didn't see any framework which exporting the class instance.
> >>>>> It is very dangerous. Unknown device drivers is able to reset
> >>>>> the 'devfreq_class' instance. I can't agree this approach.
> >>>>
> >>>> While I agree that it is potential dangerous it is actually a common
> >>>> practice to export the class:
> >>>>
> >>>
> >>> I tried to find the real usage of exported class instance
> >>> and I add the comment for each class instance. Almost exported class
> >>> instance are used in the their own director or some exported class
> >>> like rio_mport_class/switchtec_class are created from specific device driver
> >>> instead of subsystem.
> >>>
> >>> Only following two cases are used on outside of subsystem directory.
> >>> devtmpfs.c and alarmtimer.c are core feature of linux kernel.
> >>>
> >>> 	drivers/base/devtmpfs.c uses 'block_class'.
> >>> 	kernel/time/alarmtimer.c uses 'rtc_class'.
> >>>
> >>> I cannot yet agree this approach due to only block_class and rtc_class.
> >>
> >> I thought your main concern was that the class is exported, which is
> >> what several other subsystems do. That the class isn't used outside of
> >> the subsystem directory most likely means that there is no need for
> >> it, rather than that it shouldn't be done at all (depending on the
> >> type of use of course).
> >>
> >> In any case not exporting the class object provides a limited
> >> protection against potential abuse of the class at best. To use the
> >> class API all that is needed is a 'struct device' of a devfreq device,
> >> which has a pointer to the class object (dev->class).
> >>
> >> Theoretically I could register a fake devfreq device to obtain access
> >> to the class object, though that doesn't seem a very neat approach ;-)
> >>
> >>> You added the following comment why devfreq_class instance is necessary.
> >>> Actullay, I don't know the best solution right now. But, all device drivers
> >>> can be added or removed if driver uses the module type. It is not a problem
> >>> for only devfreq instance.
> >>
> >> Certainly it's not a problem limited to devfreq devices. In many other
> >> cases bus notifiers can be used, but since devfreq devices areen't
> >> tied to a specific bus this is not an option here.
> >>
> >> If you really don't want to export the class we could add wrappers
> >> for (un)registering a class interface:
> >>
> >> int devfreq_class_interface_register(struct class_interface *)
> >> void devfreq_class_interface_unregister(struct class_interface *)
> 
> About this approach, I agree because it doesn't export the devfreq_class
> instance as you commented.

Great, I'll change it in the next revision!
