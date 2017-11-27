From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC PATCH v2 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Mon, 27 Nov 2017 15:38:52 +0200
Message-ID: <20171127133852.GB2403@kuha.fi.intel.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <20171124121902.GA2403@kuha.fi.intel.com>
 <3f1b813d-a9a9-756e-718c-5b2aa2b72906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30144 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdK0Ni5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Nov 2017 08:38:57 -0500
Content-Disposition: inline
In-Reply-To: <3f1b813d-a9a9-756e-718c-5b2aa2b72906@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com

On Sat, Nov 25, 2017 at 03:03:02PM +0100, Hans de Goede wrote:
> > Is it OK to everybody that the type of the psy is changed like that?
> > Hans?!
> > 
> > We do have drivers that already change the type, for example
> > drivers/power/supply/isp1704_charger.c, but what does the user space
> > expect? The ABI for the power supply class was never documented I
> > guess.
> 
> The main userspace consumer of the power_supply sysfs class is upower,
> upower knows about 3 types: "Mains", "Battery" and "USB", anything
> else it gives a type of UP_DEVICE_KIND_UNKNOWN. So POWER_SUPPLY_TYPE_USB_TYPE_C
> vs POWER_SUPPLY_TYPE_USB_PD_PPS does matter to it.

OK.

Thanks Hans,

-- 
heikki
