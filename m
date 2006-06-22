From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Thu, 22 Jun 2006 13:23:11 +1000
Message-ID: <1150946591.947.56.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606210809380.5498@g5.osdl.org>
	<1150935357.16303.51.camel@localhost.localdomain>
	<200606211921.16289.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606211921.16289.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-06-21 at 19:21 -0700, David Brownell wrote:
> On Wednesday 21 June 2006 5:15 pm, Benjamin Herrenschmidt wrote:
> >		Additionally, as I explained earlier, it
> > will make everybody's life MUCH easier (especially USB) if we define
> > that between prepare() and finish(), no hotplug activity takes place
> > (the bus drivers just basically ignore devices being plugged in during
> > that phase, or if they can't completely ignore them, at least just leave
> > a bit somewhere "need to come back on resume look what's going on
> > here").
> =

> In the USB case, you're basically saying that prepare() should freeze
> khubd.  I think you've implied elsewhere that not all kernel tasks
> should be frozen at that time, though.

Yes, but I'm saying that it will just make life easier to everybody if
we define that we don't get new devices in while we are in the
suspend/resume process. Don't you agree ?

Ben.
