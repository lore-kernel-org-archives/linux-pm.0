From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RESEND PATCH V1 9/9] hwmon: tmp102: expose to thermal fw via DT
 nodes
Date: Thu, 18 Jul 2013 00:23:11 -0700
Message-ID: <20130718072311.GB11120@roeck-us.net>
References: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
 <1374074248-31690-10-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374074248-31690-10-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, wni@nvidia.com, l.stach@pengutronix.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 17, 2013 at 11:17:28AM -0400, Eduardo Valentin wrote:
> This patch adds to tmp102 temperature sensor the possibility
> to expose itself as thermal zone device, registered on the
> thermal framework.
> 
> The thermal zone is built only if a device tree node
> describing a thermal zone for this sensor is present
> inside the tmp102 DT node. Otherwise, the driver behavior
> will be the same.
> 
NACK, same reason as for the lm75 patch.

Guenter
