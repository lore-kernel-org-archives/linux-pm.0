From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC] firmware leaves device in D3hot at boot
Date: Thu, 30 Jun 2005 21:41:00 -0400
Message-ID: <20050701014056.GA13710@tuxdriver.com>
References: <20050623191451.GA20572@tuxdriver.com>
	<20050624022807.GF28077@tuxdriver.com>
	<20050630171010.GD11369@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============044885295061538599=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050630171010.GD11369@kroah.com>
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
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============044885295061538599==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2005 at 10:10:10AM -0700, Greg KH wrote:
> On Thu, Jun 23, 2005 at 10:28:07PM -0400, John W. Linville wrote:
> > On Thu, Jun 23, 2005 at 03:14:52PM -0400, John W. Linville wrote:
> > 
> > > This issue regarding D3hot->D0 state transitions seems like a piece
> > > of minutiae that we should not force individual drivers to address.
> > 
> > After some thought, I'm inclined to think that the patch below is
> > the right one.  It unconditionally saves and restores the PCI config
 
> But how does this solve your problem with the state change?

Please ignore the previous patches.  I've had some good feedback
from Russell King and Adam Belay, and I have reformulated the patch
accordingly.  I will be posting that shortly.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com

--===============044885295061538599==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============044885295061538599==--
