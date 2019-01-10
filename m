From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Date: Thu, 10 Jan 2019 13:27:56 -0800
Message-ID: <154715567680.19284.12367636883540337540@swboyd.mtv.corp.google.com>
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com> <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org> <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com> <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org> <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com> <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org> <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org> <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com> <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ae4bf87-88be-466d-0f1e-ff7bf5c4e816@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Raju P L S S S N (2019-01-10 08:58:41)
>=20
>=20
> On 1/9/2019 11:16 PM, Stephen Boyd wrote:
> > That could be done by making a PDC clockevent that has some DT binding
> > of a property pointing to an MMIO timer frame and then reimplementing
> > the MMIO timer code in the PDC driver on top of the frame/register
> > region it pulls out of there. Or it could be written in reverse by
> > having the generic MMIO timer driver point to the PDC somehow and
> > implement some platform specific API to pass that information to the
> > real wakeup programming part in PDC.
> >=20
> > I'm leaning toward the first approach where PDC is the clockevent and
> > that uses the MMIO timer on the backend to do what it needs to program a
> > wakeup. That way you can mandate the usage of the physical timer and
> > keep this quirk away from the ARM timer driver. It also makes the idea
> > of a qcom,pdc-timer-mode sort of useless because the PDC will have a
> > property that points to the timer frame and that will mean "use this for
> > broadcast wakeup". I'm not sure how the ARM folks feel about this
> > though. It would probably require some sort of ARM timer API that lets
> > us program the MMIO timer frame from the PDC driver. So exporting
> > arch_timer_reg_write() and making that always inlined to optimize hot
> > paths would be required.
> >=20
>=20
> Regarding the first approach -
> If PDC clk_evt_dev is created and registered to broadcast framework, it=20
> means it will replace MMIO timer event device in broadcast framework (as =

> only one broadcast event timer can exist). So in registration phase, the =

> tick broadcast framework would configure broadcat event handler for=20
> PDC(clk_evt_dev).

Yes all the MMIO timer frames would need to be marked as "disabled" I
suppose, or somehow we would need to tell the MMIO timer driver to not
register the MMIO timer frame from there because it's used by the PDC
now. Maybe that would require changing the MMIO timer's compatible
string to be something different.

>=20
> Even if we have some way of exporting arch_timer_reg_write() to program=20
> the wakeup for MMIO timer, the irq handler for MMIO timer is responsible =

> to invoke event_handler. However, since MMIO timer is replaced by PDC=20
> timer event device, event handler will not be able to inform broadcast=20
> framework. What can be done about this?
>=20

It sounds like you imagine that the MMIO timer frame will still be
active and in use by the ARM architected timer driver? I wasn't thinking
that would be the case. I was thinking that the PDC code would basically
reimplement all of the ARM timer code again by calling some shared timer
code so that we avoid code duplication. Including the irq handler that
would be registered for by the PDC driver and flow from that piece of
code instead of the ARM timer code.
