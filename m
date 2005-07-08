From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from
 pci_set_power_state for D3hot->D0
Date: Fri, 08 Jul 2005 12:08:09 -0700 (PDT)
Message-ID: <20050708.120809.116352369.davem@davemloft.net>
References: <20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============098542773989953147=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>
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

--===============098542773989953147==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: "John W. Linville" <linville@tuxdriver.com>
Date: Fri, 8 Jul 2005 14:34:56 -0400

> The cleanest implementation of pci_restore_bars was to call
> pci_update_resource.  Unfortunately, that does not currently exist
> for the sparc64 architecture.  The patch below includes a stub
> implemenation of pci_update_resource for sparc64.

I have no problems with the sparc64 part.

--===============098542773989953147==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============098542773989953147==--
