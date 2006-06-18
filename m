From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 10:16:50 -0700
Message-ID: <200606181016.51419.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606161135280.5498@g5.osdl.org>
	<1150499049.23600.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150499049.23600.72.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 16 June 2006 4:04 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2006-06-16 at 11:45 -0700, Linus Torvalds wrote:

> That's why having a simple parameter to suspend() indicating wether you
> want a full suspend or just a freeze works well in most cases: The
> driver author doesn't have to think too much about it and can default to
> suspend (suboptimal but works). I think it makes things easier on the
> driver side of things.

Right.

> > My point is, this has nothing to do with _suspending_ the device.
> =

> No, but it's about suspending the _driver_. My point is that suspending
> the device and suspending the driver are 2 different things. STR
> involves both, STD involves only the driver. However, because of the
> dependency on parent devices, they always have to be done at the same
> time.

I'll call that, and  raise you.  It's about quiescing (and in some
cases suspending) an entire _stack_ of drivers and collaborating tasks.
That stack can easily cross subsystem boundaries...

- Dave
