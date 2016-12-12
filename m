From: Caesar Wang <sasukewxt@163.com>
Subject: Re: [PATCH v3 4/5] thermal: rockchip: optimize the conversion table
Date: Mon, 12 Dec 2016 18:48:53 +0800
Message-ID: <e5ee84e5-be67-36fa-1173-7d862c1ec26e@163.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-5-git-send-email-wxt@rock-chips.com>
 <20161130062911.GB28498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:43648 "EHLO m50-134.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbcLLKvu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Dec 2016 05:51:50 -0500
In-Reply-To: <20161130062911.GB28498@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>
Cc: heiko@sntech.de, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, linux-rockchip@lists.infradead.org, rui.zhang@intel.com

在 2016年11月30日 14:29, Eduardo Valentin 写道:
> Hey,
>
> On Mon, Nov 28, 2016 at 07:12:03PM +0800, Caesar Wang wrote:
>
> <cut>
>
>> +	num = abs(table->id[mid].code - table->id[mid + 1].code);
>> +	num *= temp - table->id[mid].temp;
>> +	denom = table->id[mid + 1].temp - table->id[mid].temp;
>
> isn't the above 'mid + 1' off-by-one when mid ends being == table.length - 1?
>
> You would be accessing table->id[table.length], which is wrong memory
> access, no?

Yup, that's indeed a real issue for me.
FIxes on next version.

Thanks.

-Caesar

>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


