From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: question on freeze and aio
Date: Sat, 10 Feb 2007 09:08:46 +1100
Message-ID: <1171058926.1484.74.camel@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Fri, 2007-02-09 at 17:03 -0500, Alan Stern wrote:
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

Hmm. That applies to Raid, too? I've had some reports of raid i/o being
caught in the BUG_ON() I have to catch I/O that shouldn't be happening,
but haven't gotten around to looking at them yet.

Regards,

Nigel
