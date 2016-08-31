From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: [PATCH v4 0/2] Add support for Smart Battery System Manager
Date: Wed, 31 Aug 2016 21:54:16 +0200
Message-ID: <1472673256.5102.13.camel@schneider-inet.de>
References: <1bIiDr-0004G1-0P>
         <1472156461-25180-1-git-send-email-karl-heinz@schneider-inet.de>
         <20160831151044.xftg6k5f66n53jem@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160831151044.xftg6k5f66n53jem@earth>
Sender: linux-i2c-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Am Mittwoch, den 31.08.2016, 17:10 +0200 schrieb Sebastian Reichel:
> Hi,
> 
> On Thu, Aug 25, 2016 at 10:20:59PM +0200, Karl-Heinz Schneider wrote:
> > 
> > This patch series adds support for Smart Battery System Manager.
> > A SBSM is a device listening at I2C/SMBus address 0x0a and is
> > capable of
> > communicating up to four I2C smart battery devices. All smart
> > battery
> > devices are listening at address 0x0b, so the SBSM muliplexes
> > between
> > them. The driver makes use of the I2C-Mux framework to allow smart
> > batteries to be bound via device tree, i.e. the sbs-battery driver.
> > 
> > Via sysfs interface the online state and charge type are presented.
> > If
> > the driver is bound as ltc1760 (a Dual Smart Battery System
> > Manager)
> > the charge type can also be changed from trickle to fast.
> Driver looks fine to me. Waiting for Rob's ACK on the DT bindings.
> 
> -- Sebastian
Thanks
-- 
Karl-Heinz
