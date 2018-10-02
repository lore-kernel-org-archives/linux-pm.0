From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v9 5/8] interconnect: qcom: Add RPM communication
Date: Tue, 2 Oct 2018 14:02:42 +0300
Message-ID: <ab1db6d6-3eff-0fec-6647-3bc1910bc8b2@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-6-georgi.djakov@linaro.org>
 <20180925181735.GA28385@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925181735.GA28385@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 09/25/2018 09:17 PM, Rob Herring wrote:
> On Fri, Aug 31, 2018 at 05:01:48PM +0300, Georgi Djakov wrote:
>> On some Qualcomm SoCs, there is a remote processor, which controls some of
>> the Network-On-Chip interconnect resources. Other CPUs express their needs
>> by communicating with this processor. Add a driver to handle communication
>> with this remote processor.
> 
> I don't think you should have a binding nor a separate driver for this. 
> It's not actually an interconnect provider, so it doesn't belong in 
> bindings/interconnect. And it just looks like abuse of DT to instantiate 
> some driver.

The idea of this binding here is to represent the remote processor, that
is also in control of some of the shared interconnect paths. The
bandwidth needs of the DSPs and modem are also reported to this remote
processor. It also takes over some of the bandwidth management while the
application CPU is powered down. So yes, it is also a kind of an
interconnect provider, so IMO it should be in DT.
We already have similar DT sub-nodes for remote regulator and clock
resources and this is just adding another sub-node for the interconnect
bandwidth related subsystem.

This, together with each separate NoC hardware block (in patch 6/8) are
building up the whole topology. The configuration of interconnect paths
consists of a combination of register writes, clock scaling and sending
a message to the remote processor.

> All the driver amounts to is a 1 function wrapper for RPM_KEY_BW 
> messages. Can't this be part of the parent?

I am re-using this part for other SoCs and have separated it to avoid
duplication.

Thanks,
Georgi
