From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Sky2 driver dies some time after resume
Date: Tue, 22 May 2007 01:11:08 -0300
Message-ID: <1179807068.32496.50.camel@localhost>
References: <1179782957.32496.17.camel@localhost>
	<20070521153549.6bd46f7e@freepuppy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070521153549.6bd46f7e@freepuppy>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > I've noticing a weird behavior on sky2 driver after returning from
> > suspend. 

> Which distro? some scripts are different.

I'm using Mandriva 2007.1.

I'm hibernating here by using
	/usr/bin/klaptop_acpi_helper --hibernate

I'm not sure what scripts klaptop is using (kde version is 3.5.6).

If you want, I may run some hibernation script instead.

> Also, check if MSI is being restore properly on resume. There are some BIOS's
> that muck with MSI when ACPI calls them during resume. On Sony VAIO laptop,
> I needed to disable MSI or it resume wouldn't work.

ACPI seems to work badly on this Gateway notebook. I'm loading kernel
with noacpi. Probably, this will also disable MSI.
> 
> Linus also reported some oddness where the driver couldn't send big packets.
> Could you try:
> 	ethtool -r eth0
> That causes a phy renegotiation .

I did the following procedure, after hibernation:

# ping -f otherhost
	(worked as expected)

# ping -f otherhost -s 500
	(worked as expected)

# rsync -vuza otherhost:/sometree .

At the middle of the transfer, network stopped work.

# ethtool -r eth0

Didn't worked (I ran this several times)

dmesg (after emerging from hibernation):

CPU1 is up
usb usb2: root hub lost power or was reset
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
usb 3-6: USB disconnect, address 8
usb 3-6: new high speed USB device using ehci_hcd and address 9
usb 3-6: configuration #1 chosen from 1 choice
sky2 eth0: Link is down.
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
sky2 eth0: Link is down.
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none

# ethtool eth0

Settings for eth0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x000000ff (255)
        Link detected: yes

# rmmod sky2; modprobe sky2; dmesg

sky2 eth0: disabling interface
ACPI: PCI interrupt for device 0000:02:00.0 disabled
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
sky2 v1.10 addr 0xc0200000 irq 16 Yukon-FE (0xb7) rev 1
sky2 eth0: addr 00:e0:b8:ba:33:39
sky2 eth0: enabling interface
sky2 eth0: ram buffer 4K
ADDRCONF(NETDEV_UP): eth0: link is not ready
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control none
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Now, network is working like a charm.

I suspect that something weird occurs with big packets after
hibernation.

> 
-- 
Cheers,
Mauro
