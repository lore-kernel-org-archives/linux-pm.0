From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V3 0/5] firmware: Add support for TI System Control Interface (TI-SCI) protocol driver
Date: Thu, 08 Sep 2016 10:31:03 -0700
Message-ID: <m2y432nvs8.fsf@baylibre.com>
References: <20160906190127.23522-1-nm@ti.com> <7hshtbtu8l.fsf@baylibre.com>
        <f41d968c-46c9-997e-0fa0-edbef34a1fa5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f41d968c-46c9-997e-0fa0-edbef34a1fa5@ti.com> (Nishanth Menon's
        message of "Thu, 8 Sep 2016 09:00:37 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rob Herring <robh@kernel.org>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, David Griego <david.griego@linaro.org>
List-Id: linux-pm@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> On 09/07/2016 01:55 PM, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>
> [...] full mail thread in https://lkml.org/lkml/2016/9/6/747
>
>>> Overall architecture is very similar to SCPI[4] as follows:
>>
>> Dumb Q: I'm curious about the limitations in SCPI that were found that
>> made TI decided to implement its own version.

[...]

> Long story short, investigation was done into what SCPI was providing
> (TI internal ofcourse) and SCPI did not fit our SoC generation needs -

Thanks for the detailed explanation.  Very helpful.

To be clear, I'm not a proponent of always using ARM "standards"
(especially when it's not exactly clear if it's a standard or a Juno
thing) but I'm seeing several SoCs come out with SCPI derivatives, or
old ARM versions etc., so was just curious about the decision making
process.

Thanks for sharing,

Kevin
