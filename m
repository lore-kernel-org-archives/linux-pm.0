From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Fri, 26 May 2006 21:50:22 +0200
Message-ID: <200605262150.23006.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
	<20060502161208.GC9337@linux.intel.com>
	<200605252006.06866.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605252006.06866.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Friday 26 May 2006 05:06, David Brownell wrote:
> On Tuesday 02 May 2006 9:12 am, Patrick Mochel wrote:
> > On Thu, Apr 27, 2006 at 12:41:28PM -0700, David Brownell wrote:
> > =

> > > There does seem to be agreement that the current FREEZE invocation is=
 not
> > > sufficient.  I'm looking at a slightly different solution now ... one=
 which
> > > unfortunately involves changing drivers, but can indeed allow swsusp =
resume
> > > paths to do the right thing (instead of what it does now).
> > =

> > It's Ok if it involves a drive change, so long as its an optional chang=
e, which
> > means that it shouldn't affect the interface very much (i.e. the callin=
g =

> > convention). That's why it'd be good to augment and/or modify pm_messag=
e_t
> > to implement the changes, so we wouldn't have to change every single dr=
iver
> > again.. =

> =

> I'll post more patches after I sort out some oddness -- why is swsusp_sus=
pend()
> leaving preempt_count() =3D=3D 1, code I was nowhere near? -- but the pat=
ch appended
> here shows what I'm pursuing.  Same calling convention, new PRETHAW messa=
ge
> that "pm-naive" drivers (most of them!) can handle just like FREEZE.

Frankly I thought you'd add a new member to pm_message_t, to be ignored by =
the
drivers that didn't care.

That said I also see the point in what you're doing. :-)

Greetings,
Rafael
