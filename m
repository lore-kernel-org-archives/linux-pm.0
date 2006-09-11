From: Mark Gross <mgross@linux.intel.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 15:00:07 -0700
Message-ID: <20060911220007.GB12176@linux.intel.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060911200636.GC11901@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 11, 2006 at 10:06:36PM +0200, Pavel Machek wrote:
> On Mon 2006-09-11 12:53:27, Matthew Locke wrote:
> > On Sep 11, 2006, at 12:36 PM, Pavel Machek wrote:
> > =

> > >>>You did echo low > something to change CPU frequency, IIRC.
> > >>My patch set presents two different interfaces built on top of =

> > >>PowerOP -
> > >>cpufreq and sysfs interfaces. So _no_, PowerOP is not all about
> > >
> > >Okay, drop sysfs interface, and we may have something that can be
> > >reviewed.
> > =

> > Sysfs is a separate patch that can rejected.  Nothing is stopping =

> > people from reviewing.
> =

> If you submit patch series with one bad patch, you are very unlikely
> to get feedback for the good patches.
> =

> > >Actually that's good idea. Submit powerop without doing _any_ kernel
> > >interface changes, so we can see that it makes sense...
> > =

> > Just to be clear this is the approach we did and are doing.
> =

> That's not what I remember. Please resubmit, then. And cc lkml this
> time.
> =

> > btw, if people on this list are not ready to ACK PowerOP, I would like =

> > to hear why before we go elsewhere.   It looks like all major issues =

> > have been addressed by our approach and implementation.
> =

> No, I'm not ready to ACK. Actually I'd describe it as "broken piece of
> code noone needs". And IIRC Greg's last question was "what is it good
> for?". Dave Jones was not too pleased with cpufreq/powerop
> integration. Intel people explained you broke centrino
> speedstep. Shall I continue?
> =


Those where directed to the other patch that David Singleton posted.


> 								Pavel
> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
