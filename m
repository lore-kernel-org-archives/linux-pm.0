From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Wake on LAN (s2ram) via Magic Packet
	works only the first time after reboot
Date: Mon, 4 Aug 2008 00:08:00 +0200
Message-ID: <200808040008.01165.rjw__40844.5804765963$1217801218$gmane$org@sisk.pl>
References: <488F1BDF.8060902@eviolis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <488F1BDF.8060902@eviolis.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Josef Schneider <jms@softinfo.homeip.net>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 29 of July 2008, Josef Schneider wrote:
> Hi Guys,
> 
> 
> After many hours of testing the problem can described as follows:
> 
> After boot/reboot the command: "s2ram -f -a 3" works in a correct manner and
> puts the system into S3-State (suspend to ram). After doing a WakeUp via
> MagicWOL the system is awakening and the graphics works properly. Doing a
> second "s2ram -f -a 3" the system seems to go into S3-State but awakes within
> 3-5 seconds without any interaction from outside.
> 
> After a reboot the "s2ram" command works correct, but only for one time. After
> that, same procedure as mentioned above.
> 
> Hardware:
> MB: ASROCK ALIVE NF7G-HDready with BIOS V. 2.10 (newest Version)
> CPU: AMD BE-2400, 2 Cores, 2,3 GHz
> RAM: 1x1 GB DDR2
> HDD: Samsung 320 GB SATA in AHCI Mode
> CD:  DVD-ROM with IDE-Interface
> NIC: Intel Pro 1000 Desktop MT (because onboard NIC doesn't work with WOL)
> 
> Software:
> OS: OpenSUSE 11.0 x86 (32bit-Version) with all Updates until 28th July 2008
> Drivers: Nvidia Graphics Driver installed via 1-Klick install
>  x11-video-nvidiaG01-173.14.09-0.1
>  nvidia-gfxG01-kmp-default-173.14.09_2.6.25.5_1.1-0.1
>  nvidia-gfxG01-kmp-pae-173.14.09_2.6.25.5_1.1-0.1
> 
> 
> More Informations:
> The used Intel Pro 1000 NIC works on a ECS AMD A780GM Motherboard correct with
> s2ram and WakeonLAN. So I used this NIC for testing on the ASROCK-System. On
> both systems the onboard NIC will not work with WakeonLan via Magic Packet.

What's this one?

Also, can you please try 2.6.27-rc2 when it's out?  It contains some important
changes related to wake-up.

Thanks,
Rafael
