From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem "waking-up"
Date: Sun, 21 Jun 2009 08:49:29 +0200
Message-ID: <20090621064929.GA1810@ucw.cz>
References: <f695d6b80906112008n71dbb675i96da2168ed9aeb15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f695d6b80906112008n71dbb675i96da2168ed9aeb15@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Isamar Maia <isamar@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-06-12 00:08:38, Isamar Maia wrote:
> Hi Folks,
> 
> Hope here is the right place to send this posting.
> 
> I am trying to make a notebook working with all its features and I am
> facing a hard
> work with that.
> 
> It is a SiS based Chipset as the lscpi output says below:
> 
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 671MX
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS AGP Port
> (virtual PCI-to-PCI bridge)
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS968 [MuTIOL
> Media IO] (rev 01)
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01)
> 00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.1
> Controller (rev 0f)
> 00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.1
> Controller (rev 0f)
> 00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
> 00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 191
> Gigabit Ethernet Adapter (rev 02)
> 00:05.0 IDE interface: Silicon Integrated Systems [SiS] SATA
> Controller / IDE mode (rev 03)
> 00:06.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge
> 00:07.0 PCI bridge: Silicon Integrated Systems [SiS] PCI-to-PCI bridge
> 00:0d.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev 05)
> 00:0d.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro
> Host Adapter (rev 22)
> 00:0d.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev 12)
> 00:0d.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
> Adapter (rev 12)
> 00:0d.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev ff)
> 00:0f.0 Audio device: Silicon Integrated Systems [SiS] Azalia Audio Controller
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> 771/671 PCIE VGA Display Adapter (rev 10)
> 02:00.0 Ethernet controller: Atheros Communications Inc. AR242x
> 802.11abg Wireless PCI Express Adapter (rev 01)
> 
> 
> For xorg, I am using VESA video driver. For wifi, I am using ath_pci
> driver. and for audio, I am using
> snd_hda_intel alsa driver.
> 
> I can use "suspend" but I cannot "wakeup" back after that. The screen
> stays blank and I can see
> the CDROM led blinking like trying to detect some media inside.
> 
> I am using Fedora 9's kernel 2.6.26.5-45.i686 and, for specific
> reasons, I cannot upgrade the kernel at all, but I can apply
> any patch if necessary.

Apply diff between 2.6.26 and 2.6.30?

Ask fedora for help?

Try again with minimum drivers?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
