From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2] PM / clk: Add support for obtaining clocks from
 device-tree
Date: Wed, 9 Mar 2016 16:57:54 +0000
Message-ID: <56E05612.702@nvidia.com>
References: <1457529213-2581-1-git-send-email-jonathanh@nvidia.com>
 <CAJZ5v0iEo=jj+T-0bQypxs8VTb7kPpczSRu+8-+F7oyRMk9nSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19966 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbcCIQ57 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 11:57:59 -0500
In-Reply-To: <CAJZ5v0iEo=jj+T-0bQypxs8VTb7kPpczSRu+8-+F7oyRMk9nSA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org


On 09/03/16 14:04, Rafael J. Wysocki wrote:
> On Wed, Mar 9, 2016 at 2:13 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> The PM clocks framework requires clients to pass either a con-id or a
>> valid clk pointer in order to add a clock to a device. Add a new
>> function of_pm_clk_add_clks() to allows device clocks to be retrieved
>> from device-tree and populated for a given device. Note that
>> of_clk_get_from_provider() is not defined if CONFIG_OF and
>> CONFIG_COMMON_CLK are not selected. Therefore, make of_pm_clk_add_clks()
>> dependent on these options.
>>
>> An optional function pointer may be passed to of_pm_clk_add_clks() that
>> can be used to filter the clocks that are added for a device when
>> calling of_pm_clk_add_clks().
>>
>> In order to handle errors encountered when adding clocks from
>> device-tree, add a function pm_clk_remove_clk() to remove any clocks
>> (using a pointer to the clk structure) that have been added
>> successfully before the error occurred.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>
>> Changes v1-v2:
>> - Added support for optional filter function as suggested by Geert U.
> 
> I'd like to get an ACK on this from someone more familiar with the DT
> stuff than I am.

No problem. Is Geert's ACK sufficient or is there someone else I should add?

Cheers
Jon
