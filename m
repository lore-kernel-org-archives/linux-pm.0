From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 4/5] thermal: rockchip: optimize the conversion table
Date: Tue, 29 Nov 2016 22:29:11 -0800
Message-ID: <20161130062911.GB28498@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33686 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbcK3G3P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 01:29:15 -0500
Content-Disposition: inline
In-Reply-To: <1480331524-18741-5-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Hey,

On Mon, Nov 28, 2016 at 07:12:03PM +0800, Caesar Wang wrote:

<cut>

> +	num = abs(table->id[mid].code - table->id[mid + 1].code);
> +	num *= temp - table->id[mid].temp;
> +	denom = table->id[mid + 1].temp - table->id[mid].temp;


isn't the above 'mid + 1' off-by-one when mid ends being == table.length - 1?

You would be accessing table->id[table.length], which is wrong memory
access, no?

