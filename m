From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH] power: bq24190_charger: mark PM functions as
 __maybe_unused
Date: Mon, 20 Mar 2017 20:55:56 -0700
Message-ID: <20170321035556.GA17398@animalcreek.com>
References: <20170320131424.271241-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37949 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754594AbdCUDz6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 23:55:58 -0400
Content-Disposition: inline
In-Reply-To: <20170320131424.271241-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>, Mark Greer <mgreer@animalcreek.com>, Colin Ian King <colin.king@canonical.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 20, 2017 at 02:14:15PM +0100, Arnd Bergmann wrote:
> Without CONFIG_PM, we get a harmless warning:
> 
> drivers/power/supply/bq24190_charger.c:1514:12: error: 'bq24190_runtime_resume' defined but not used [-Werror=unused-function]
> drivers/power/supply/bq24190_charger.c:1501:12: error: 'bq24190_runtime_suspend' defined but not used [-Werror=unused-function]
> 
> To avoid the warning, we can mark all four PM functions as __maybe_unused,
> which also lets us remove the incorrect #ifdef.
> 
> Fixes: 3d8090cba638 ("power: bq24190_charger: Check the interrupt status on resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Probably too late but if it isn't...

Acked-by: Mark Greer <mgreer@animalcreek.com>
