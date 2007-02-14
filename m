From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question on freeze and aio
Date: Wed, 14 Feb 2007 22:32:10 +0100
Message-ID: <200702142232.13480.rjw@sisk.pl>
References: <20070213101859.GD12996@elf.ucw.cz>
	<Pine.LNX.4.44L0.0702131557400.2741-100000@iolanthe.rowland.org>
	<20070214092510.5468db34.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070214092510.5468db34.rdunlap@xenotime.net>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 14 February 2007 18:25, Randy Dunlap wrote:
> On Tue, 13 Feb 2007 16:01:30 -0500 (EST) Alan Stern wrote:
> =

> > On Tue, 13 Feb 2007, Pavel Machek wrote:
> > =

> > > > No, workqueues are not frozen unless they are explicitly declared as
> > > > freezeable.  Which currently is only done by XFS, AFAIKS.
> > > =

> > > Ok, then we have a bug in swsusp. Can someone locate _which_ workqueue
> > > is used for aio... and make it freezeable?
> > =

> > Here is an untested patch.  Does anybody have a way to test it?
> > =

> > (BTW, should it be spelled "freezeable" or "freezable"?)
> =

> www.dict.org says freezable.

Yeah, but we have always spelled "freezeable".  Google search shows both are
being used.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
