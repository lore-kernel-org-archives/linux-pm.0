From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
Date: Sun, 1 Jul 2018 14:18:52 +0300
Message-ID: <185ab8a2-f4e5-dd4f-6446-44ab7fddf12e@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-5-georgi.djakov@linaro.org>
 <20180627005523.GS129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180627005523.GS129942@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 06/27/2018 03:55 AM, Matthias Kaehlcke wrote:
> On Wed, Jun 20, 2018 at 03:11:37PM +0300, Georgi Djakov wrote:
>> On some Qualcomm SoCs, there is a remote processor, which controls some of
>> the Network-On-Chip interconnect resources. Other CPUs express their needs
>> by communicating with this processor. Add a driver to handle comminication
> 
> s/comminication/communication/
> 

[..]

>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RPM over SMD communication wrapper for interconects
> 
> s/interconects/interconnects/
> 

Thanks, will fix them!

BR,
Georgi
