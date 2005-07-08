From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Fri, 8 Jul 2005 09:51:04 +0400
Message-ID: <20050708095104.A612@den.park.msu.ru>
References: <20050705224620.B15292@flint.arm.linux.org.uk>
	<20050706033454.A706@den.park.msu.ru>
	<20050708005701.GA13384@tuxdriver.com>
	<20050707.201103.41635951.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32661531222024909=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050707.201103.41635951.davem@davemloft.net>;
	from davem@davemloft.net on Thu, Jul 07, 2005 at 08:11:03PM -0700
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "David S. Miller" <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============32661531222024909==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2005 at 08:11:03PM -0700, David S. Miller wrote:
> > Problem: pci_update_resource doesn't exist for sparc64.
> 
> Yes, the drivers/pci/setup-res.c code isn't compiled in on
> sparc64 because it assumes a totally different model of
> PCI bus probing than we use on sparc64.

Why not just implement sparc64 version of pci_update_resource elsewhere
(perhaps a dummy one, if you don't need PCI PM), rather than force the
rest of the world to duplicate the code?

Ivan.

--===============32661531222024909==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32661531222024909==--
