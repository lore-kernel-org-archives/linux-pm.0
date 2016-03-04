From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V7 1/4] ARM64: tegra: Remove unused #power-domain-cells
 property
Date: Fri, 4 Mar 2016 14:19:50 +0000
Message-ID: <56D99986.8040808@nvidia.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
 <1457094186-15786-2-git-send-email-jonathanh@nvidia.com>
 <20160304141346.GA28635@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16953 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcCDOT5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 09:19:57 -0500
In-Reply-To: <20160304141346.GA28635@ulmo.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


On 04/03/16 14:13, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Mar 04, 2016 at 12:23:03PM +0000, Jon Hunter wrote:
>> Remove the "#power-domain-cells" property which was incorrectly
>> included by commit e53095857166 ("arm64: tegra: Add Tegra210
>> support").
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 --
>>  1 file changed, 2 deletions(-)
> 
> Jon, can you resend this to arm@kernel.org to get this applied before
> the final v4.5? Feel free to add:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Yes, no problem.

Jon
