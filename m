From: Adam Belay <abelay@MIT.EDU>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 13:01:22 -0400
Message-ID: <1160758883.26091.125.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	<1160753187.25218.52.camel@localhost.localdomain>
	<1160753390.3000.494.camel@laptopd505.fenrus.org>
	<1160755562.25218.60.camel@localhost.localdomain>
	<1160757260.26091.115.camel@localhost.localdomain>
	<1160759349.25218.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1160759349.25218.62.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-10-13 at 18:09 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 12:34 -0400, ysgrifennodd Adam Belay:
> > I agree this needs to be fixed.  However, as I previously mentioned,
> > this isn't the right place to attack the problem.  Remember, this wasn't
> > originally a kernel regression.  Rather it's a workaround for a known
> =

> It's a kernel regression. It used to be reliable to read X resource
> addresses at any time.

Not true, reading these registers during a BIST has always been a
problem.

> =

> > Finally, it's worth noting that this issue is really a corner-case, and
> > in most systems it's extremely rare that even incorrect userspace apps
> > would have any issue.
> =

> Except just occasionally and randomly in the field, probably almost
> undebuggable and irreproducable - the very worst conceivable kind of
> bug.
> =


Which is why returning an error code during device transitions is a
reasonable compromise between correctness and practicality.

-Adam
