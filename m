From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for active state of scpsys on mt8183
Date: Thu, 03 Jan 2019 14:53:51 -0800
Message-ID: <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henry Chen <henryc.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Henry Chen (2019-01-02 06:09:51)
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
>=20
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 2 frameworks basically:
>=20
> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>    requirements from different clients

Have you looked at using the interconnect framework for this instead of
using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
to do DRAM bandwidth requirement aggregation.

> 2. Active state management of power domains[1]: to handle the operating
>    voltage opp requirement from different power domains

Do you have any devices that aren't "OPP-ish" in how they use
frequencies and voltages? What I mean is devices such as i2c, SPI, UART
controllers that don't use the OPP library to set a frequency but want
to affect some voltage of their power domain when clk frequencies
change. The existing code works well for devices that naturally use the
OPP rate changing API, typically multimedia devices that churn through
data like a CPU and don't care about the frequency of their main clk
because it doesn't match physical link bit rates, etc. I haven't seen
any good solution for devices that don't fit well with the OPP API
though so I'm curious if Mediatek needs to solve that problem.=20
