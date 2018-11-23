From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/7] ata: libahci_platform: comply to PHY framework
Date: Fri, 23 Nov 2018 16:36:56 +0100
Message-ID: <20181123153656.GD30913@lunn.ch>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-2-miquel.raynal@bootlin.com>
 <20181123151806.GC30913@lunn.ch>
 <20181123152730.GU30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181123152730.GU30658@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 23, 2018 at 03:27:30PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 23, 2018 at 04:18:06PM +0100, Andrew Lunn wrote:
> > Russell King wrote a comphy driver for the Armada 3XX family. It only
> > supports network PHYs. Did you check it does the right thing when
> > passed PHY_MODE_SATA? This is slightly different to Hans's comment, in
> > that i expect phy_set_mode() is implemented for the comphy driver, but
> > it might not understand PHY_MODE_SATA and return an error?
> 
> It makes no difference until the comphy is wired up to the SATA
> device in the appropriate DT files.  Until then, there's no way
> that the comphy will ever see PHY_MODE_SATA.

O.K, great.

Thanks
	Andrew
