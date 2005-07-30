From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] swsusp: simpler calculation of number of
	pages in PBE list
Date: Sat, 30 Jul 2005 10:37:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0507301035400.31323-100000@netrider.rowland.org>
References: <200507301532.59576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2187663757678755=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200507301532.59576.rjw@sisk.pl>
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
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============2187663757678755==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:

> Hi,
> 
> On Saturday, 30 of July 2005 15:13, Pavel Machek wrote:
> > Hi!
> > 
> > > > 	px >= n + x
> > > > 
> > > > or
> > > > 
> > > > 	(p-1)x >= n
> > > > 
> > > > or
> > > > 
> > > > 	x >= n / (p-1).
> > > > 
> > > > The obvious solution is
> > > > 
> > > > 	x = ceiling(n / (p-1)),
> > > > 
> > > > so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> > > > Michal's patch computes.
> > > 
> > > Nice. :-)
> > > 
> > > Could we perhaps add your proof to the Michal's patch as a comment,
> > > for reference?
> > 
> > No, thanks. It only proves that it is equivalent to old code, but says
> > nothing about quality of code, and we really do not want to keep old
> > code around.
> 
> IMHO it rather says that the formula is OK and would save some time to
> people reading the code for the _first_ time and trying to understand it,
> but you decide. :-)

It's up to you whether or not to include the proof as a comment -- you 
have my permission and my sign-off:

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern


--===============2187663757678755==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2187663757678755==--
