From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 02/13] PM / Domains: Add DT bindings for power-on/off
 latencies
Date: Fri, 26 Sep 2014 19:52:29 +0200
Message-ID: <CAMuHMdU+4MX-XYe9rHmyPN3=-VQRg+CrnxWEaU2M_Jg+1Psw8A@mail.gmail.com>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
 <1411662520-22795-3-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrAv9oyBzX764+CWkOxfN1kN_MddB3ks1q69+TnmnHXuQ@mail.gmail.com>
 <20140926152835.GK10233@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140926152835.GK10233@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Philipp Zabel <philipp.zabel@gmail.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

On Fri, Sep 26, 2014 at 5:28 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 25 September 2014 18:28, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> > +Optional properties:
>> > + - power-on-latency: Power-on latency of the PM domain, in ns,
>> > + - power-off-latency: Power-off latency of the PM domain, in ns.
>> > +
>> >  Example:
>> >
>> >         power: power-controller@12340000 {
>> >                 compatible = "foo,power-controller";
>> >                 reg = <0x12340000 0x1000>;
>> >                 #power-domain-cells = <1>;
>> > +               power-on-latency = <250000>;
>> > +               power-off-latency = <250000>;
>
> This assumes every power domain within a power controller has the
> same latencies? That isn't always true. This should be an array
> of values corresponding to the number of power domains if
> #power-domain-cells is 1, or just one value if the cell count is
> 0.

Thanks, you're right. Will update.

However, I'd still like to allow just one value in the #power-domain-cells = <1>
case if the latencies are the same. Is that OK for you?

Thanks again.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
