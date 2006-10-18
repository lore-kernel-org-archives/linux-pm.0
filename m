From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Block on access to temporarily
	unavailable	pci device
Date: Wed, 18 Oct 2006 17:42:13 +0100
Message-ID: <1161189733.9363.85.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
	<1161187503.9363.75.camel@localhost.localdomain>
	<20061018160926.GS22289@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061018160926.GS22289@parisc-linux.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Ar Mer, 2006-10-18 am 10:09 -0600, ysgrifennodd Matthew Wilcox:
> On Wed, Oct 18, 2006 at 05:05:02PM +0100, Alan Cox wrote:
> > If the user specified O_NDELAY then -EWOULDBLOCK not wait
> =

> sysfs doesn't give us the struct file, so we can't tell.

I'm all for fixing sysfs on that point so that it can behave sensibly.
