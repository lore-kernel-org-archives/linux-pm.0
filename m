From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH v4] power_supply: power_supply_read_temp only if use_cnt >
 0
Date: Wed, 22 Jun 2016 11:31:39 -0400
Message-ID: <01a31c96-3c21-511c-c279-04016bb17e52@nvidia.com>
References: <1465507719-819-1-git-send-email-rklein@nvidia.com>
 <8b081e45-94c8-bb53-69ca-0a617c668de5@nvidia.com>
 <20160622142353.GA16084@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7116 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcFVPbs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 11:31:48 -0400
In-Reply-To: <20160622142353.GA16084@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org

On 6/22/2016 10:23 AM, Sebastian Reichel wrote:
> * PGP Signed by an unknown key
> 
> Hi Rhyland,
> 
> On Tue, Jun 21, 2016 at 02:06:55PM -0400, Rhyland Klein wrote:
>> Sebastian, might this be accepted soon? We can't enable the bq27xxx
>> driver for Tegra210 Smaug without running into the crash this prevents.
> 
> Yes, I have already queued this in my fixes branch some days ago,
> but did not yet pushed it. It's pushed out now:
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=5bc28b93a36e3cb3acc2870fb75cb6ffb182fece
> 

Thanks!

-rhyland

-- 
nvpublic
