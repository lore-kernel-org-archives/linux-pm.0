From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv1 00/14] power: supply: Fix custom sysfs attribute
 registration
Date: Tue, 2 Oct 2018 16:00:38 -0700
Message-ID: <20181002230038.GA11102@kroah.com>
References: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 01, 2018 at 12:03:35AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> Udev may not detect sysfs attributes, that have been added
> after the device has been created. Code doing that is racy [0].
> The power-supply class properly registers its attributes
> when the device is created, but some drivers add additional
> custom attributes in a racy way.
> 
> The first patch from this series adds native support for custom
> sysfs attributes to the power-supply subsystem. This feature
> allows cleaner code and avoids a race condition preventing udev
> from noticing the custom properties.
> 
> The following patches replace all instances of sysfs_create_*
> in drivers/power/supply to use the new feature and a couple
> of small cleanups.
> 
> TL;DR: This patchsets replaces all sysfs_create_* in power-supply.
> 
> [0] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> 
> -- Sebastian
> 
> Sebastian Reichel (14):
>   power: supply: core: add support for custom sysfs attributes
>   power: supply: bq2415x: fix race-condition in sysfs registration
>   power: supply: ds2780: fix race-condition in sysfs registration
>   power: supply: ds2781: fix race-condition in sysfs registration
>   power: supply: lp8788: fix race-condition in sysfs registration
>   power: supply: bq24190_charger: fix race-condition in sysfs
>     registration
>   power: supply: bq24257: fix race-condition in sysfs registration
>   power: supply: charger-manager: simplify generation of sysfs attribute
>     group name
>   power: supply: charger-manager: fix race-condition in sysfs
>     registration
>   power: supply: pcf50633: fix race-condition in sysfs registration
>   power: supply: ds2780: fix race-condition in bin attribute
>     registration
>   power: supply: ds2781: fix race-condition in bin attribute
>     registration
>   power: supply: ds2780: switch to devm_power_supply_register
>   power: supply: ds2781: switch to devm_power_supply_register
> 
>  drivers/power/supply/bq2415x_charger.c   | 119 ++++++++++-------------
>  drivers/power/supply/bq24190_charger.c   |  43 ++------
>  drivers/power/supply/bq24257_charger.c   |  15 +--
>  drivers/power/supply/charger-manager.c   |  62 +++++-------
>  drivers/power/supply/ds2780_battery.c    |  87 +++++------------
>  drivers/power/supply/ds2781_battery.c    |  82 +++++-----------
>  drivers/power/supply/lp8788-charger.c    |  62 +++++-------
>  drivers/power/supply/pcf50633-charger.c  |  17 ++--
>  drivers/power/supply/power_supply_core.c |   1 +
>  include/linux/power/charger-manager.h    |   3 +-
>  include/linux/power_supply.h             |   3 +
>  11 files changed, 172 insertions(+), 322 deletions(-)

Nice work, and it removes more code than it adds, always a win.

greg k-h
