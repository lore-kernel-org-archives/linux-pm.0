From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/3] power: supply: Add driver for Microchip UCS1002
Date: Tue, 30 Apr 2019 09:10:08 -0700
Message-ID: <20190430161008.GA731@roeck-us.net>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-3-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430064557.28469-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pm@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 11:45:56PM -0700, Andrey Smirnov wrote:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
