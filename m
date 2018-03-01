From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 00/15] Krait clocks + Krait CPUfreq
Date: Thu, 1 Mar 2018 14:28:30 +0100
Message-ID: <CACRpkdbu9Kxvuwr-nLHxyEYiTeGK38o7MKCFf-MMjYxwgcJPPA@mail.gmail.com>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: viresh kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>Russell
List-Id: linux-pm@vger.kernel.org

Hi Sricharan,

thanks for picking up Stephen's patch set and working on this
clocking business!

Would you happen to know if the MSM8660/APQ8060 that
I'm using a bit has the same Krait clocking so I need to augment
that SoC to use this too (on top of this, naturally, this is a good first
step)?

On Tue, Feb 27, 2018 at 3:06 PM, Sricharan R <sricharan@codeaurora.org> wrote:

>   * Dropped the DT update from the series. Will send separately

Are these available somewhere so I can test the sum total on
the Nexus 7 and see if I get some graphics? I've been sticking a
patch from Stephen's series in for some time and it makes the
MDP graphics works on the 2013 Nexus 7.

Yours,
Linus Walleij
