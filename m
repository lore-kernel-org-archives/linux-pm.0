From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
Date: Fri, 20 Jul 2018 09:10:36 -0600
Message-ID: <CAL_JsqL10WT5AK37_8o3M_=UiLx_thcm1W3UNz2qBaB5dRo8XA@mail.gmail.com>
References: <20180706053552.11438-1-daniel@zonque.org> <20180706053552.11438-2-daniel@zonque.org>
 <20180711150157.GA18150@rob-hp-laptop> <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5070717c-4c9f-c580-8f50-2369dcd74aef@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: zbr@ioremap.net, Mark Rutland <mark.rutland@arm.com>, szabolcs.gyurko@tlt.hu, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 6:40 AM Daniel Mack <daniel@zonque.org> wrote:
>
> On Wednesday, July 11, 2018 05:01 PM, Rob Herring wrote:
> > On Fri, Jul 06, 2018 at 07:35:48AM +0200, Daniel Mack wrote:
> >> This patch adds a generic w1 bindings document that describes how w1
> >> slave deviceses are grouped under master nodes. It also augments the
> >> existing w1-gpio.txt document a bit.
> >>
> >> Signed-off-by: Daniel Mack <daniel@zonque.org>
> >> ---
> >>   .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
> >>   Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
> >>   2 files changed, 33 insertions(+), 3 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Note that this will conflict with a unit-address fix that I have queued
> > up for 4.18 (will send this week).
>
> How would we best handle this? Sebastian, are you going to apply this
> series, and add a note to the PR for 4.19 on how to resolve the conflict?

Either 4.18-rc6 or my devicetree-fixes-for-4.18 tag (based on rc1) can
be pulled in. Or just note the conflict. It is trivial enough.

Rob
