From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
 restore BAR values in pci_enable_device_bars
Date: Thu, 07 Jul 2005 23:35:30 -0700 (PDT)
Message-ID: <20050707.233530.85417983.davem@davemloft.net>
References: <20050708005701.GA13384@tuxdriver.com>
	<20050707.201103.41635951.davem@davemloft.net>
	<20050708095104.A612@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============78605317999391344=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708095104.A612@den.park.msu.ru>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ink@jurassic.park.msu.ru
Cc: rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============78605317999391344==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Fri, 8 Jul 2005 09:51:04 +0400

> Why not just implement sparc64 version of pci_update_resource elsewhere
> (perhaps a dummy one, if you don't need PCI PM), rather than force the
> rest of the world to duplicate the code?

That's fine, what would be the most minimal implementation?

--===============78605317999391344==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============78605317999391344==--
