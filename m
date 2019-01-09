From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Date: Wed, 09 Jan 2019 09:46:44 -0800
Message-ID: <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com>
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <20181221115946.10095-4-rplsssn@codeaurora.org> <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com> <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org> <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com> <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org> <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com> <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org> <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Raju P L S S S N (2019-01-08 21:34:32)
>=20
>=20
> On 1/7/2019 9:47 PM, Raju P L S S S N wrote:
> >=20
> >=20
> > On 1/4/2019 2:49 AM, Stephen Boyd wrote:
> >>
> >> I'd hope that each RSC's PDC timer wakes up the owner of the RSC so th=
at
> >> we can use the sysreg based timers and ignore the MMIO based timers
> >> here. This isn't a very important distinction to make though, so if you
> >> have to use the MMIO timers then it just means some extra DT things ne=
ed
> >> to be done to relate the MMIO timers with the RSC that has the timer
> >> that needs to be programmed too.
> >=20
> >>
> >> Either way we would need a way to either hook the ARM architected timer
> >> driver in the kernel, or reimplement the bit of code needed to impleme=
nt
> >> the clockevent based on the ARM architected timer that programs the ARM
> >> timer and the PDC timer together.
> >>
> >=20
> > Could you please provide some more details on the implementation?
>=20
> Hi Stephen,
>=20
> Regardless of implementation options about application processor=20
> subsytem PDC timer, I think there is a need to differentiate the fact=20
> that for application processor subsystem PDC timer programming is done=20
> by SW but not for display processor subsystem as HW sleep solver takes=20
> care of PDC timer during sleep entry/exit. How about having a dt=20
> property like qcom,pdc-timer-mode =3D "solver"/"sw" ? The current patch=20
> introduced client based model using regmap to achieve this=20
> differentiation between these two subsystems. By using the dt property,=20
> once rpmh-src driver instance for application subsystem can have PDC=20
> timer programing implemented. Let me know if there is another way.
>=20
> For implementation of PDC timer, I see the following based on above=20
> discussion -
> 1. Take the existing cpu_pm_notify approach and move the current series=20
> approach of programing PDC timer registers to RSC driver. This wouldn't=20
> involve any changes in clock_event_framework/broadcast framework.
>=20
> 2. Add api hooks (like reading the next wake up programmed) to ARM=20
> architecture timer driver so that the value is copied to PDC timer using =

> the api with in RSC driver based on cpu_pm_notifications.
>=20
> 3. Changes in clockevent to program both ARM mem timer & PDC timer=20
> together. Could you please share some more details on this?
>=20
>=20
> Please let me know if the first approach is ok.
>=20

The first approach requires that we expose internals of the clockevent
and broadcast timer information to drivers. From my perspective it looks
like a weird kludge to workaround the fact that the broadcast timer
doesn't actually work on this platform. That's why I'm suggesting that
you fix the broadcast timer on your platform to actually work, and do
that within the clockevent/broadcast layers instead of indirecting that
through cpu_pm notifiers.

That could be done by making a PDC clockevent that has some DT binding
of a property pointing to an MMIO timer frame and then reimplementing
the MMIO timer code in the PDC driver on top of the frame/register
region it pulls out of there. Or it could be written in reverse by
having the generic MMIO timer driver point to the PDC somehow and
implement some platform specific API to pass that information to the
real wakeup programming part in PDC.

I'm leaning toward the first approach where PDC is the clockevent and
that uses the MMIO timer on the backend to do what it needs to program a
wakeup. That way you can mandate the usage of the physical timer and
keep this quirk away from the ARM timer driver. It also makes the idea
of a qcom,pdc-timer-mode sort of useless because the PDC will have a
property that points to the timer frame and that will mean "use this for
broadcast wakeup". I'm not sure how the ARM folks feel about this
though. It would probably require some sort of ARM timer API that lets
us program the MMIO timer frame from the PDC driver. So exporting
arch_timer_reg_write() and making that always inlined to optimize hot
paths would be required.
