From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 00/11] Hookup typec power-negotation to the PMIC and
 charger
Date: Thu, 31 Aug 2017 18:26:37 +0200
Message-ID: <20170831162637.GA8353@kroah.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 30, 2017 at 11:48:03AM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v3 of my typec power-negotation hookup series. New this version:
> - Drop a few patches merged into linux-power-supply.git/for-next
> - Drop the "power: supply: bq24190_charger: Remove extcon handling"
>   patch *for now*, this can only be merged once all the other patches are
>   in place (and extcon handling is no longer needed)
> - Address some review comments in some of the other patches, see the
>   per patch changelogs inside the commit messages
> 
> I believe that this series is ready for merging now and I would like to
> ask the various subsys maintainers to pick up and merge these patches.
> All the patches can be merged independent of eachother with the exception
> of the last 2 patches:
> 
> i2c-cht-wc: Add device-properties for fusb302 integration
> platform/x86: intel_cht_int33fe: Update fusb302 type string, add properties
> 
> Which should not be merged until all the other patches are in place.

staging patches all now merged, thanks!

greg k-h
