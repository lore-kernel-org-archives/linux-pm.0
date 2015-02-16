From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Mon, 16 Feb 2015 09:11:00 +0200
Message-ID: <54E19804.9080003@iki.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi> <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi> <20150212224242.GA23500@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:41962 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbBPHLF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 02:11:05 -0500
In-Reply-To: <20150212224242.GA23500@mithrandir>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

On 02/13/2015 12:42 AM, Thierry Reding wrote:
> On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
>> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>>
>> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
>> and also provides automatic CPU rail voltage scaling as well. The DFLL
>> is a separate IP block from the usual Tegra124 clock-and-reset
>> controller, so it gets its own node in the device tree.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
>> ---
>>   .../bindings/clock/nvidia,tegra124-dfll.txt        | 69 ++++++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
>>
...
>> +Required properties:
>> +- compatible : should be "nvidia,tegra124-dfll-fcpu"
>> +- reg : Defines the following set of registers, in the order listed:
>> +        - registers for the DFLL control logic.
>> +        - registers for the I2C output logic.
>> +        - registers for the integrated I2C master controller.
>> +        - look-up table RAM for voltage register values.
>
> Why do these all need to be separate sets? According to the TRM this is
> a single IP block with a single register region, why the need to split
> them apart?

On Tegra132, some of those register blocks (IIRC the first one) has 
moved to a different place (somewhere in the CAR register area). The TRM 
description indeed gives a single list of registers for the Tegra124 
implementation of the DFLL. The split into 4 blocks was to make the 
binding more future-proof and to be closer to the real hardware design.
