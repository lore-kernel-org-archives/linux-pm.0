From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] power: bq24190_charger: Uniform pm_runtime_get()
 failure handling
Date: Wed, 29 Mar 2017 09:30:25 -0700
Message-ID: <20170329163025.GO8575@atomide.com>
References: <20170329014913.3970-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42652 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbdC2Qa3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 12:30:29 -0400
Content-Disposition: inline
In-Reply-To: <20170329014913.3970-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170328 18:52]:
> From: Liam Breck <kernel@networkimprov.net>
> 
> On pm_runtime_get() failure, always emit an error message.
> Prevent unbalanced pm_runtime_get by calling:
>   pm_runtime_put_noidle() in irq handler
>   pm_runtime_put_sync() on any probe() failure
> Rename probe() out labels instead of renumbering them.
> 
> Fixes: 13d6fa8447fa power: bq24190_charger: Use PM runtime autosuspend
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
> v2: not rebased to Hans' extcon patch, which needs some work.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
