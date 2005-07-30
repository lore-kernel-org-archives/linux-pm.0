From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: simpler calculation of number of pages
	in PBE list
Date: Sat, 30 Jul 2005 15:13:56 +0200
Message-ID: <20050730131356.GE1830@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org>
	<200507301516.32003.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============044709697217943711=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200507301516.32003.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============044709697217943711==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > 	px >= n + x
> > 
> > or
> > 
> > 	(p-1)x >= n
> > 
> > or
> > 
> > 	x >= n / (p-1).
> > 
> > The obvious solution is
> > 
> > 	x = ceiling(n / (p-1)),
> > 
> > so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> > Michal's patch computes.
> 
> Nice. :-)
> 
> Could we perhaps add your proof to the Michal's patch as a comment,
> for reference?

No, thanks. It only proves that it is equivalent to old code, but says
nothing about quality of code, and we really do not want to keep old
code around.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

--===============044709697217943711==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============044709697217943711==--
