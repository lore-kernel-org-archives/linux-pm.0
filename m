From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: fix 64-bit build warning
Date: Thu, 12 Jan 2017 09:32:26 +0100
Message-ID: <2151755.ZC9SDDZNPX@wuerfel>
References: <20170111145211.746189-1-arnd@arndb.de> <20170112025824.ifplt45l3syibjda@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112025824.ifplt45l3syibjda@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 12, 2017 3:58:24 AM CET Sebastian Reichel wrote:
> Hi Arnd,
> 
> On Wed, Jan 11, 2017 at 03:51:55PM +0100, Arnd Bergmann wrote:
> > Casting a pointer to 'int' is not always valid:
> > 
> > drivers/power/supply/axp20x_usb_power.c: In function 'axp20x_usb_power_probe':
> > drivers/power/supply/axp20x_usb_power.c:297:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> > 
> > This makes the code use uintptr_t explicitly.
> > 
> > Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use of_device_id data field instead of device_is_compatible")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I queued Michal's patch instead:
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=15df6d98ec3b40775918fc6ef73d7f1c2d0cf870

Hmm, that doesn't look right: You can't really rely on an 'enum' type to
have a specific size, especially not the same size as a pointer, in portable
code.

IIRC on many architectures it defaults to 'int' rather than 'long', and
it might also be 'short' on architectures that default to enums being
the smallest integer type that fits.

	Arnd
