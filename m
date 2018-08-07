From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re:[PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Date: Tue, 7 Aug 2018 17:54:38 +0300
Message-ID: <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, maxime.ripard@bootlin.com
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kerne
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 08/03/2018 12:02 AM, Rob Herring wrote:
> On Tue, Jul 31, 2018 at 10:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> This binding is intended to represent the interconnect hardware present
>> in some of the modern SoCs. Currently it consists only of a binding for
>> the interconnect hardware devices (provider).
> 
> If you want the bindings reviewed, then you need to send them to the
> DT list. CC'ing me is pointless, I get CC'ed too many things to read.

Ops, ok!

> The consumer and producer binding should be a single patch. One is not
> useful without the other.

The reason for splitting them is that they can be reviewed separately.
Also we can rely on platform data instead of using DT and the consumer
binding. However will do as you suggest.

> There is also a patch series from Maxime Ripard that's addressing the
> same general area. See "dt-bindings: Add a dma-parent property". We
> don't need multiple ways to address describing the device to memory
> paths, so you all had better work out a common solution.

Looks like this fits exactly into the interconnect API concept. I see
MBUS as interconnect provider and display/camera as consumers, that
report their bandwidth needs. I am also planning to add support for
priority.

Thanks,
Georgi
