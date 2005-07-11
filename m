From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.13-rc2] PCI: Add symbol exports for
	pci_restore_bars
Date: Mon, 11 Jul 2005 13:36:38 -0400
Message-ID: <20050711173635.GF23093@tuxdriver.com>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
	<20050711144844.A16143@tin.liacs.nl>
	<20050711131518.GB23093@tuxdriver.com>
	<20050711131859.GC23093@tuxdriver.com>
	<20050711171830.GA31050@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28870538836301129=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050711171830.GA31050@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, Lennert Buytenhek <buytenh+lkml@liacs.nl>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, herbertb@cs.vu.nl, "David S. Miller" <davem@davemloft.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-pci@atrey.karlin.mff.cuni.cz, byjac@matfyz.cz
List-Id: linux-pm@vger.kernel.org

--===============28870538836301129==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 11, 2005 at 10:18:30AM -0700, Greg KH wrote:
> On Mon, Jul 11, 2005 at 09:19:03AM -0400, John W. Linville wrote:
> > Globalize and add EXPORT_SYMBOL for pci_restore_bars.
> 
> EXPORT_SYMBOL_GPL() perhaps as this is a new function?

Sure...that will please Arjan as well... :-)

Patch to follow...

John
-- 
John W. Linville
linville@tuxdriver.com

--===============28870538836301129==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28870538836301129==--
