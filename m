From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/9] Add support for QCOM Core Power Reduction
Date: Mon, 8 Apr 2019 16:00:48 +0530
Message-ID: <CAOh2x==enW-jmtYi3F=TP8QS=wt8UHKV5td-tyJiCXV=D6ZBBQ@mail.gmail.com>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 10:40 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> This is a first RFC for Core Power Reduction (CPR), a form of
> Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.
>
> Since this is simply an RFC, things like MAINTAINERS hasn't
> been updated yet.
>
> CPR is a technology that reduces core power on a CPU or on other device.
> It reads voltage settings from efuses (that have been written in production),
> it uses these voltage settings as initial values, for each OPP.
>
> After moving to a certain OPP, CPR monitors dynamic factors such as
> temperature, etc. and adjusts the voltage for that frequency accordingly
> to save power and meet silicon characteristic requirements.
>
> This driver is based on an RFC by Stephen Boyd[1], which in turn is
> based on work by others on codeaurora.org[2].
>
> [1] https://lkml.org/lkml/2015/9/18/833
> [2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10

Please add relevant people to all the patches as it makes their life
easier and never
miss anyone from the cover-letter :)

--
viresh
