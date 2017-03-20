From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] power: bq24190_charger: mark PM functions as
 __maybe_unused
Date: Mon, 20 Mar 2017 07:33:09 -0700
Message-ID: <20170320143309.GF20572@atomide.com>
References: <20170320131424.271241-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170320131424.271241-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <liam@networkimprov.net>, Mark Greer <mgreer@animalcreek.com>, Colin Ian King <colin.king@canonical.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170320 06:17]:
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

Thanks for fixing that:

Acked-by: Tony Lindgren <tony@atomide.com>
