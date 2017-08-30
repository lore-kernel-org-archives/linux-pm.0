From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 08/11] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Wed, 30 Aug 2017 07:46:50 -0700
Message-ID: <20170830144649.GF6008@atomide.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20170830094814.17758-9-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Hans de Goede <hdegoede@redhat.com> [170830 02:49]:
> Register the 5V boost converter as a regulator named "usb_otg_vbus".
> 
> This commit also adds support for bq24190_platform_data, through which
> non device-tree platforms can pass the regulator_init_data (containing
> mappings for the consumer amongst other things).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This will make it easy for USB PHY drivers to implement USB host mode:

Acked-by: Tony Lindgren <tony@atomide.com>
