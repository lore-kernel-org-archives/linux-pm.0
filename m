From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 12:53:27 -0700
Message-ID: <c728abebb17f975089390dd3f87069af@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911193637.GA11901@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org


On Sep 11, 2006, at 12:36 PM, Pavel Machek wrote:

>>> You did echo low > something to change CPU frequency, IIRC.
>> My patch set presents two different interfaces built on top of =

>> PowerOP -
>> cpufreq and sysfs interfaces. So _no_, PowerOP is not all about
>
> Okay, drop sysfs interface, and we may have something that can be
> reviewed.
>

Sysfs is a separate patch that can rejected.  Nothing is stopping =

people from reviewing.


> Actually that's good idea. Submit powerop without doing _any_ kernel
> interface changes, so we can see that it makes sense...


Just to be clear this is the approach we did and are doing.
> Your code should be good enough to survive some flaming. I do not
> think it is, so yes, I think submitting it to lkml is good
> idea. You'll have to do that at some point, anyway.
>
> (And note lkml only flames you when you are doing something wrong.)


Isn't this (linux-pm) the place to discuss power management patches and =

interfaces?  I thought we would get ACK's from the power management =

maintainers and then the patches go into -mm.  Who on lkml needs to be =

in this discussion that is not on this list?

btw, if people on this list are not ready to ACK PowerOP, I would like =

to hear why before we go elsewhere.   It looks like all major issues =

have been addressed by our approach and implementation.

>
> 								Pavel
> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =

> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
