From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date: Tue, 30 Oct 2018 09:52:00 -0700
Message-ID: <CAD=FV=ViA_0Vpv+oUTHxUFfdoKftMN58wFxcbdYp2mF8SdULew@mail.gmail.com>
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com> <5b62572d-9f45-c0ee-776e-1486a9d40862@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b62572d-9f45-c0ee-776e-1486a9d40862@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raju P L S S S N <rplsssn@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Resending since I accidentally clicked back to HTML and lists all bounced.  :(

On Tue, Oct 30, 2018 at 9:24 AM Raju P L S S S N <rplsssn@codeaurora.org> wrote:
>
> On 10/24/2018 12:06 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 15, 2018 at 10:02 AM Raju P.L.S.S.S.N
> > <rplsssn@codeaurora.org> wrote:
> >> +               idle-states {
> >> +                       entry-method = "psci";
> >> +
> >> +                       C0_CPU_SPC: c0_spc {
> >
> > nit: all these nodes should have dashes instead of spaces in the node
> > names (labels can still have spaces).  AKA:
> >
> > C0_CPU_SPC: c0-spc {
>
> Sure. I will change this. (However, from device tree specification v0.2,
> I see that Table 2.1 mentions underscore as valid character for node.
> Please correct me if I'm missing something)

You're right that I don't see it there.  I've always heard that they
are allowed but discouraged.  One place that mentions this:

https://elinux.org/Device_Tree_Linux

> Linux conventions
> * node names
>   * use dash "-" instead of underscore "_"

That same site points that the majority of people use dashes in node
names instead of underscores.

-Doug
