From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events description
Date: Thu, 2 May 2019 15:24:20 -0500
Message-ID: <CAL_JsqJcm9Z6vYFHGyAZ+h3-kmSv6e=3NtO-fjJn3-QT0JoX+w@mail.gmail.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
 <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
 <20190430223629.GA22317@bogus> <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 3:52 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rob,
>
> On 5/1/19 12:36 AM, Rob Herring wrote:
> > On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
> >> Extend the documenation by events description with new 'event-data-type'
> >> field. Add example how the event might be defined in DT.
> >
> > Why do we need event types in DT? We don't do this for other h/w such as
> > ARM PMU.
> In ARM PMU all the events are hard-coded into the driver code i.e. in v7
> arch/arm/kernel/perf_event_v7.c
> and are seen from perf. They are different type and for different
> purpose. The Ecynos PPMU events are not seen in perf, they are
> for internal monitoring and must not be reset by other actors like perf.
> They are used by the 'bus drivers' to made some heuristics and tune the
> internal settings, like frequency.
>
> Chanwoo has written PPMU driver which relies on DT definition.
> The DT events are used by other DT devices by phandle.

How is that done? I don't see anything in the binding for that.

Rob
