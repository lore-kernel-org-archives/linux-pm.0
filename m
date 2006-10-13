From: Martin Mares <mj@ucw.cz>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 11:31:49 +0200
Message-ID: <mj+md-20061013.093014.26714.atrey@ucw.cz>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
	<1160701263.4792.179.camel@localhost.localdomain>
	<1160729427.26091.98.camel@localhost.localdomain>
	<1160731004.4792.245.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1160731004.4792.245.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Hi!

> For example, currently, if I power off the ethernet of my mac, or the
> firewire chip (which are powered off if the module isn't loaded), lspci
> will get the device id and vendor id right ... but won't get the class
> code.

Ehm, you aren't using any recent pciutils, are you? ;-)

				Have a nice fortnight
-- =

Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Lottery -- a tax on people who can't do math.
