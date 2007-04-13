From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 07:18:50 +1000
Message-ID: <1176499130.5764.94.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl> <20070413205837.GG28264@elf.ucw.cz>
	<1176498368.7052.117.camel@johannes.berg>
	<20070413211232.GJ28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413211232.GJ28264@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-04-13 at 23:12 +0200, Pavel Machek wrote:
> Hi!
> =

> > > That it is same old hack it used to be. There's nothing magic about
> > > decrementer, and I do not think it is _neccessary_ to touch it just
> > > before cli. Just disable it from sysdev handler or something.
> > =

> > No, you cannot disable it from sysdev handler because you have to be
> > able to take interrupts. Can we *please* move on to some more productive
> > discussion?
> =

> So what happens if you disable it as a platform device? There has to
> be better solution than this. What is so special about decrementer?

That you are dead since once it's disabled, kernel timers etc... stop
working.

> We were able to handle MTRR registers on PC. Timer setup fit into the
> model too...

I don't care what you do on x86. If I tell you I need to take control at
that point, then I need. Beside I really can't understand why you are so
dead set against an arch hook there. It's not like this will do anything
to you... it can't propagate to drivers, it's purely arch stuff, so
what ? =


Ben.
