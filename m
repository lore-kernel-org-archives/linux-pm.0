From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with PM_FREEZE
Date: Thu, 29 Sep 2005 21:01:08 +0200
Message-ID: <200509292101.08844.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0509291136210.4928-100000@iolanthe.rowland.org>
	<20050929173158.GJ1990@elf.ucw.cz>
	<20050929182215.0C19FE9E4F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79226743915003106=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050929182215.0C19FE9E4F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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
Cc: David Brownell <david-b@pacbell.net>, ncunningham@cyclades.com, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

--===============79226743915003106==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 29 of September 2005 20:22, David Brownell wrote:
> > > > Pavel is obviously right that the clean solution is to add a pm_message_t 
> > > > argument to resume().
> > > 
> > > I tend to disagree with that.  Changing every resume() method is
> > > not "clean", and it's more obvious to me that the pm_message
> > > semantics are (still) problematic.  Any argument to resume() would
> > > be encouraging fragile "if (came_from(X)) { ... }" style logic.
> >
> > Alan wants to cut few miliseconds from suspend-to-disk. That's okay
> > with me, just add pm_message_t to resume(). If it is okay to use it in
> > specific driver is other question.
> 
> Sorry; changing every driver in the whole tree is in my book
> under "things to avoid unless there's a more significant win".

I think it's avoidable.

Instead of changing every single driver that registers _resume(), we can
introduce another resume template, something like

void resume_from(pm_message_t state)

where we will pass the state which we expect the device to be in before
resume.  Then we can call:
- resume_from() if the driver registers it, or
- resume() if the driver registers it, etc.
(ie. resume() can only be called if resume_from() is not registered).

Just an idea.

Greetings,
Rafael

--===============79226743915003106==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79226743915003106==--
