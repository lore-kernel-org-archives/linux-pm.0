From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6.14-rc1] pci: only call pci_restore_bars
	at boot
Date: Wed, 14 Sep 2005 22:22:24 +0400
Message-ID: <20050914222224.A22319@jurassic.park.msu.ru>
References: <09142005095242.32027@bilbo.tuxdriver.com>
	<43283CDC.3070603@pobox.com>
	<20050914.092650.99910742.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59467388964987711=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050914.092650.99910742.davem@davemloft.net>;
	from davem@davemloft.net on Wed, Sep 14, 2005 at 09:26:50AM -0700
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
Cc: akpm@osdl.org, kaos@sgi.com, rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com
List-Id: linux-pm@vger.kernel.org

--===============59467388964987711==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2005 at 09:26:50AM -0700, David S. Miller wrote:
> Why in the world can a PCI device not handle it's BARs being
> rewritten, especially if we're just rewriting the same exact
> values it had when we probed it beforehand?

Definitely. I wonder whether pci_resource_to_bus() works
correctly on this platform.

Ivan.

--===============59467388964987711==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59467388964987711==--
