From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-spmi-temp-alarm: Improve
 thermal zone in example
Date: Wed, 25 Jul 2018 16:25:09 -0700
Message-ID: <CAD=FV=W9cpLt2EQwyTDyZyFiueV2yrLO_SLXOFcS09P_wGYnLw@mail.gmail.com>
References: <20180724235035.58146-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724235035.58146-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:50 PM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> The current example for a thermal zone isn't very useful as reference
> since it would result in a hardware shutdown at 145=C2=B0C, instead of
> allowing the system to try to shutdown gracefully. Without an ADC
> channel a maximum of two trip points is useful in practice for this
> sensor, with temperatures corresponding to the stage 1 and stage 2
> 'hardware trip points'. A critical trip point at stage 2 may allow the
> system to shutdown before a hardware shutdown at stage 3 kicks in. It
> should be noted though that by default the chip performs a 'partial
> shutdown' when the temperature reaches stage 2, which may prevent an
> orderly shutdown. The 'partial shutdown' can be disabled by software.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Assuming your patch to disable the partial shutdown lands, then:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...if that patch doesn't land (or if someone disagrees with me and
thinks we need an extra property to disable the partial shutdown) then
we would need the example to be different.  Because of that, maybe
this should be appended to the end of your series which includes the
patch to disable partial shutdown?

-Doug
