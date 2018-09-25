From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 5/8] interconnect: qcom: Add RPM communication
Date: Tue, 25 Sep 2018 13:17:35 -0500
Message-ID: <20180925181735.GA28385@bogus>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-6-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831140151.13972-6-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 31, 2018 at 05:01:48PM +0300, Georgi Djakov wrote:
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.

I don't think you should have a binding nor a separate driver for this. 
It's not actually an interconnect provider, so it doesn't belong in 
bindings/interconnect. And it just looks like abuse of DT to instantiate 
some driver.

All the driver amounts to is a 1 function wrapper for RPM_KEY_BW 
messages. Can't this be part of the parent?

Rob
