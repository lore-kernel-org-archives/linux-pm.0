From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH 29/44] staging: nvec: Register with kernel poweroff handler
Date: Wed, 08 Oct 2014 20:51:10 +0200
Message-ID: <1986471.ednzxGGBeV@ax5200p>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-30-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1412659726-29957-30-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Guenter Roeck <linux@roeck-us.net>, devel@driverdev.osuosl.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Andrey Danin <danindrey@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Montag 06 Oktober 2014, 22:28:31 schrieb Guenter Roeck:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with default priority value of 128 since we don't know
> any better.

I just tested this change and it seems to break power off. What the driver 
does it to queue the power off request and execute it sometime later. The 
command is send via i2c to an embedded controller (mfd device) which is 
responsible for removing the power.

I haven't analyzed further, but I guess this could be related with the atomic 
discussion brought up in some other thread of this patch series.

Marc
