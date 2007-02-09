From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question on freeze and aio
Date: Fri, 9 Feb 2007 23:09:11 +0100
Message-ID: <200702092309.11530.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
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

On Friday, 9 February 2007 23:03, Alan Stern wrote:
> On Sat, 10 Feb 2007, Nigel Cunningham wrote:
> =

> > Hi.
> > =

> > On Fri, 2007-02-09 at 17:04 +0100, Oliver Neukum wrote:
> > > Hi,
> > > =

> > > can there be running aio requests if all tasks are frozen?
> > =

> > Since tasks are frozen, no new aio requests would be submitted. We do a
> > sync to ssek to complete existing requests; I haven't looked to see
> > whether that would need extending to flush aio as well, but don't think
> > that would be the case. Given everyone else's silence, so far, you might
> > be better to ask the author(s) of the aio code.
> =

> I believe Nigel is basically correct.  However sync will only flush aio =

> for block devices.  Other types of aio will remain active.
> =

> aio callbacks are interrupt-driven and execute in a workqueue (see
> fs/aio.c), and as far as I can tell that workqueue doesn't freeze.  =

> Unless some general facility freezes all workqueues...

No, workqueues are not frozen unless they are explicitly declared as
freezeable.  Which currently is only done by XFS, AFAIKS.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
