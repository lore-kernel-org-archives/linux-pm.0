From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 15:22:13 +0100
Message-ID: <20070322142213.GF7693@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703221444.52065.oneukum@suse.de>
	<20070322135653.GA7693@elf.ucw.cz>
	<200703221518.35286.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221518.35286.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm <linux-pm@lists.osdl.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2007-03-22 15:18:34, Oliver Neukum wrote:
> Am Donnerstag, 22. M=E4rz 2007 14:56 schrieb Pavel Machek:
> > > > Generic entry points are for _system_ suspend, and if you try to ab=
use
> > > > them for runtime PM, you'll have to audit/change all the drivers.
> > > =

> > > Is this your position regarding USB autosuspend, too? Should we use
> > > other methods than suspend/resume?
> > =

> > Well, you should have audited USB drivers when enabling autosuspend...
> > But I believe you did that so you are pretty much okay.
> =

> We audited them. Respectively, are auditing them.

Ok. (It would be nice to document 'USB suspend/resume routines are
called during runtime, too' somewhere.

> > (With autosuspend, you can get situation when request from userland
> > comes in even when device is suspended; some devices will need
> > fixing).
> =

> Currently, such requests are ignored. Is there any problem with that?

You should probably autowake such device, no?

So USB stick sits unused for 10minutes and autosuspend. I want to read
the USB stick. Stick needs to autowakeup, me thinks.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
