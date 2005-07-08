From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Fri, 8 Jul 2005 11:03:58 +0400
Message-ID: <20050708110358.A8491@jurassic.park.msu.ru>
References: <20050708005701.GA13384@tuxdriver.com>
	<20050707.201103.41635951.davem@davemloft.net>
	<20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============38422898047030896=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050707.233530.85417983.davem@davemloft.net>;
	from davem@davemloft.net on Thu, Jul 07, 2005 at 11:35:30PM -0700
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

--===============38422898047030896==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2005 at 11:35:30PM -0700, David S. Miller wrote:
> That's fine, what would be the most minimal implementation?

#define pci_update_resource(dev, res, n)	BUG()

No, I'm serious - I don't believe that generic implementation of
pcibios_resource_to_bus() in the proposed patch does the right thing
on sparc64 anyway.

Ivan.

--===============38422898047030896==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============38422898047030896==--
