From: Victor Porton <porton@ex-code.com>
Subject: Cannot resume after standby
Date: Sat, 25 Feb 2006 20:40:22 +0500 (YEKT)
Message-ID: <E1FD1Ww-0000O5-00@porton.narod.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75604161787086821=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============75604161787086821==
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit

A computer cannot be resumed after standby (or suspend to mem).

Linux kernel 2.6.15.4.

When I do standby it starts to blink the green light on the box.
The monitor remains on and shows power management software output.

Pressing any keys on PS/2 keyboard (including the Wake key) or
pressing power button on the box have no effect.

The only recourse is to press Reset to reboot the system.

My BIOS is configured to power on any keyboard key press and this
works when computer is powered off, but as I've told above doesn't
work when is is in Linux standby.

I suspect that the kernel suspend code wrongly powers down the
PS/2 keyboard... And so I have no way to resume.

Any way to fix it? (Cc: porton@ex-code.com)

* mainboard ASRock PVM800/M/ASR (VIA PM800 chipset; mATX 800 MHz);
* CPU Intel Celeron 310D 2.13 GHz 256 Kb 533 Box;
 
Chipsets: North Bridge:
    VIA P4M800 CE, FSB @ 800/533/400 MHz,
    with Intel Hyper-Threading Technology ready
South Bridge:
    VIA VT8237R, supports USB 2.0, ATA 133, SATA 1.5Gb/s
 
BIOS: AMI BIOS
      Supports "Plug and Play"
      ACPI 1.1 compliance wake up events
      Supports jumperfree
      SMBIOS 2.3.1 support
      CPU frequency stepless control

-- 
Victor Porton (porton@ex-code.com) - http://porton.ex-code.com

--===============75604161787086821==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75604161787086821==--
