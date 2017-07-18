From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Tue, 18 Jul 2017 12:29:55 +0800
Message-ID: <20170718042955.GA12080@b29397-desktop>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com>
 <10723509.cz5GGA4OTz@aspire.rjw.lan>
 <20170710022815.GA8720@b29397-desktop>
 <2659617.dvNVihq86F@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2659617.dvNVihq86F@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pe
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 17, 2017 at 03:39:07PM +0200, Rafael J. Wysocki wrote:
> > Sorry, I should describe more.
> > 
> > Let's take USB bus as an example, when the new USB device is at the
> > host port, the device structure at device model is not created until
> > it is discoverable by the USB bus. If this new USB device needs to be
> > powered on before can be discoverable by the bus, the device structure
> > will be not created without powering on operation. The code usb_alloc_dev
> > (drivers/usb/core/usb.c) is only called for discoverable device.
> > 
> > Unlike the other bus, eg, platform bus, it creates device structure
> > according to DT node. The USB bus was designed for hot plug model, the
> > device structure is for discoverable device. In recent years, we begin
> > to have some hard-wired USB device, Eg, onboard USB-hub, onboard USB 4G
> > Modem, etc at the market. It needs some board level power operation before
> > it can be found by the USB bus. This patch set is designed primarily for
> > fix this kind of problem. You will see at at pwrseq_generic.c, we use DT
> > version clock API of_clk_get and DT version gpio API of_get_named_gpio_flags
> > instead of device structure version, like devm_clk_get and
> > devm_gpiod_get_optional.
> > 
> > MMC system has similar use case, it creates power sequence platform
> > device for this issue, but all those power stuffs (clock, gpio, etc)
> > may not be suitable as a dedicated virtual device at DT, they are belonged
> > to one physical device, so this patch set is created to see if this issue
> > can be fixed better.
> 
> OK, thanks for the explanation.
> 
> The above needs to be part of your problem statement.

Ok, I will add it to cover letter.

> > 
> > The bus will power up all device nodes in this bus according to DT
> > information, the device structure has not created at this time.
> 
> OK
> 
> I still think that the information on power resources depended on by devices
> should be used for power management as well as for the initial power-up.
> 
> The most straightforward way to arrange for that would be to make it possible
> to find the DT node matching the device after the device has been discovered
> and struct device created for it, say by USB.  That would require adding some
> more information on the device to the DT node, probably.

After the device is created, the device node structure is under struct
device, say dev->of_node. The most difficulty for this issue is the
device creation is dynamic and is after the physical device is
discovered by the bus, the initial power-up is needed before the device
can be discovered by the bus.

> 
> Then, the DT device nodes would be used for the initial power-up and next, after
> discovering a device, you'd do a lookup in the DT, find the node matching it
> and read the power resuources information from there to populate the device's
> power state structure.  From that point on you can simply use the interface I
> suggested.
> 

Just like I said above, without initial power-up, the device can't be
discovered by the bus.

-- 

Best Regards,
Peter Chen
