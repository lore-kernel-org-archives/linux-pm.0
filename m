From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
 restore BAR values in pci_enable_device_bars
Date: Thu, 07 Jul 2005 20:11:03 -0700 (PDT)
Message-ID: <20050707.201103.41635951.davem@davemloft.net>
References: <20050705224620.B15292@flint.arm.linux.org.uk>
	<20050706033454.A706@den.park.msu.ru>
	<20050708005701.GA13384@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81200950298836316=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708005701.GA13384@tuxdriver.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linville@tuxdriver.com
Cc: rmk+lkml@arm.linux.org.uk, ink@jurassic.park.msu.ru, grundler@parisc-linux.org, matthew@wil.cx, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============81200950298836316==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: "John W. Linville" <linville@tuxdriver.com>
Date: Thu, 7 Jul 2005 20:57:04 -0400

> Problem: pci_update_resource doesn't exist for sparc64.

Yes, the drivers/pci/setup-res.c code isn't compiled in on
sparc64 because it assumes a totally different model of
PCI bus probing than we use on sparc64.

On sparc64, we check out if the boot firmware has assigned
the PCI resources for the device, and if so we just leave
things alone.  We also make sure that the firmware device
tree properties mostly match what the PCI config space registers
say and we spit out a warning message if not.

--===============81200950298836316==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81200950298836316==--
