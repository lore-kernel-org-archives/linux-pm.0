From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci:
	restore BAR values in pci_enable_device_bars
Date: Fri, 8 Jul 2005 12:20:43 +0400
Message-ID: <20050708122043.A8779@jurassic.park.msu.ru>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42249762373949373=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708.003333.28789082.davem@davemloft.net>;
	from davem@davemloft.net on Fri, Jul 08, 2005 at 12:33:33AM -0700
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

--===============42249762373949373==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 08, 2005 at 12:33:33AM -0700, David S. Miller wrote:
> Do PCI devices ever come out of reset in a PM state, and thus
> would execute John's new code as a side effect?

PCI spec requires that all devices must enter D0 state from
power on reset, so this code shouldn't be executed unless you
have some really buggy PM firmware (which is unlikely :-).

Ivan.

--===============42249762373949373==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42249762373949373==--
