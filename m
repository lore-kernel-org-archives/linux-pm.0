From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v2] thermal: of-thermal: Reduce log level for message
 when can't find thermal zone
Date: Tue, 17 Nov 2015 13:51:03 +0900
Message-ID: <564AB237.506@mentor.com>
References: <1447728214-31097-1-git-send-email-jiada_wang@mentor.com> <20151117033701.GB27415@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:59863 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbKQEwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 23:52:22 -0500
In-Reply-To: <20151117033701.GB27415@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello

On 11/17/2015 12:37 PM, Eduardo Valentin wrote:
> On Tue, Nov 17, 2015 at 11:43:34AM +0900, Jiada Wang wrote:
>> Some systems register thermal zone by themself and don't need to
>> have thermal zones node in DT. Therefore reduce the log level from
>> ERROR to DEBUG when thermal zone node can't be found in
>> of_thermal_destroy_zones().
>
>
> This is already applied [1]. I applied V1 though.
> What is the difference from v1?
>
fixed typo in commit subject
"fine" -> "find"

Thanks,
Jiada
> [1] -
> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=fixes&id=285249884ec19480f99c011d223760bb1fc865a2
>
> BR,
>
> Eduardo Valentin
>
