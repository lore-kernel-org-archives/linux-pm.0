From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch net-next RFC 03/12] mlxsw: core: Add core environment
 module for port temperature reading
Date: Tue, 26 Jun 2018 16:22:38 +0200
Message-ID: <20180626142238.GB5064@lunn.ch>
References: <1530015037-67361-1-git-send-email-vadimp@mellanox.com>
 <1530015037-67361-4-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530015037-67361-4-git-send-email-vadimp@mellanox.com>
Sender: netdev-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, linux-pm@vger.kernel.org
Cc: netdev@vger.kernel.org, linux@roeck-us.net, rui.zhang@intel.com, edubezval@gmail.com, jiri@resnulli.us
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 26, 2018 at 12:10:28PM +0000, Vadim Pasternak wrote:

Adding the linux-pm@vger.kernel.org list.

> Add new core_env module to allow port temperature reading. This
> information has most critical impact on system's thermal monitoring and
> is to be used by core_hwmon and core_thermal modules.
> 
> New internal API reads the temperature from all the modules, which are
> equipped with the thermal sensor and exposes temperature according to
> the worst measure. All individual temperature values are normalized to
> pre-defined range.

This patchset has been sent to the netdev list before. I raised a few
questions about this, which is why it is now being posted to a bigger
group for review.

The hardware has up to 64 temperature sensors. These sensors are
hot-plugable, since they are inside SFP modules, which are
hot-plugable. Different SFP modules can have different operating
temperature ranges. They contain an EEPROM which lists upper and lower
warning and fail temperatures, and report alarms when these thresholds
a reached.

This code takes the 64 sensors readings and calculates a single value
it passes to one thermal zone. That thermal zone then controls one fan
to keep this single value in range.

I queried is this is the correct way to do this? Would it not be
better to have up to 64 thermal zones? Leave the thermal core to
iterate over all the zones in order to determine how the fan should be
driven?

This is possibly the first board with so many sensors. However, i
doubt it is totally unique. Other big Ethernet switches with lots of
SFP modules may be added later. Also, 10G copper PHYs often have
temperature sensors, so this is not limited to just boards with
optical ports. So having a generic solution would be good.

What do the Linux PM exports say about this?

Thanks
	Andrew
