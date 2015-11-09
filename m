From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: bq27xxx_battery: Add I2C module check dependency in Kconfig
Date: Mon, 09 Nov 2015 22:32:01 +0100
Message-ID: <4760713.cM5ekhZCt2@wuerfel>
References: <1447104183-13556-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1447104183-13556-1-git-send-email-afd@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, Xiong Zhou <jencce.kernel@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2015 15:23:03 Andrew F. Davis wrote:
> Check if I2C core has been built as a module when BATTERY_BQ27XXX
> is built-in. If so disable I2C functionality.
> 
> Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency in Kconfig")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Thanks for the fix!

Acked-by: Arnd Bergmann <arnd@arndb.de>
