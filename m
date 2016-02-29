From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V6 10/10] ARM64: tegra: Add audio PM domain device node
 for Tegra210
Date: Mon, 29 Feb 2016 10:41:50 +0000
Message-ID: <56D4206E.6070504@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
 <1456501724-28477-11-git-send-email-jonathanh@nvidia.com>
 <20160229073009.GJ23745@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9347 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcB2KmD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 05:42:03 -0500
In-Reply-To: <20160229073009.GJ23745@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org



On 29/02/16 07:30, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Feb 26, 2016 at 03:48:44PM +0000, Jon Hunter wrote:
>> Add the audio power-domain for tegra210. Note that this also removes the
>> existing "#power-domain-cells" which was incorrectly included by
>> commit e53095857166 ("arm64: tegra: Add Tegra210 support").
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> ---
>>
>> So far I have only added the audio power-domain for tegra210 as this is
>> what I have been testing with to date. However, once this series is
>> accepted then we can begin to add more.
>>
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> I'm slightly reluctant to apply this, since the domain isn't used
> anywhere. I'm assuming it will be used by the audio driver that you've
> been working on, but if that's not going to be merged this cycle, we'd
> end up with an unused label. Not that that's invalid in any way, but my
> rule of thumb has been not to introduce labels until they are used.
> 
> Therefore I suggest we postpone this to the series that adds audio
> support.

That's fine with me or I can drop the label, until it is used by a device?

Jon
