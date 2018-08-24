From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider
 bindings
Date: Fri, 24 Aug 2018 17:51:37 +0300
Message-ID: <672e6c6c-222f-5e7f-5d0c-acc8da68b1ab@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-3-georgi.djakov@linaro.org>
 <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
 <e114ed83-fd54-4952-f375-e1d94826ac6e@linaro.org>
 <20180820153207.xx5outviph7ec76p@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820153207.xx5outviph7ec76p@flea>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.ke
List-Id: linux-pm@vger.kernel.org

Hi Maxime,

On 08/20/2018 06:32 PM, Maxime Ripard wrote:
> Hi Georgi,
> 
> On Tue, Aug 07, 2018 at 05:54:38PM +0300, Georgi Djakov wrote:
>>> There is also a patch series from Maxime Ripard that's addressing the
>>> same general area. See "dt-bindings: Add a dma-parent property". We
>>> don't need multiple ways to address describing the device to memory
>>> paths, so you all had better work out a common solution.
>>
>> Looks like this fits exactly into the interconnect API concept. I see
>> MBUS as interconnect provider and display/camera as consumers, that
>> report their bandwidth needs. I am also planning to add support for
>> priority.
> 
> Thanks for working on this. After looking at your serie, the one thing
> I'm a bit uncertain about (and the most important one to us) is how we
> would be able to tell through which interconnect the DMA are done.
> 
> This is important to us since our topology is actually quite simple as
> you've seen, but the RAM is not mapped on that bus and on the CPU's,
> so we need to apply an offset to each buffer being DMA'd.

Ok, i see - your problem is not about bandwidth scaling but about using
different memory ranges by the driver to access the same location. So
this is not really the same and your problem is different. Also the
interconnect bindings are describing a path and endpoints. However i am
open to any ideas.

Thanks,
Georgi
