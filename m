From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI code in platform mode hibernation code paths
	(was: Re: [PATCH] swsusp: do not use pm_ops)
Date: Fri, 4 May 2007 01:14:11 +0200
Message-ID: <200705040114.12497.rjw__13223.4697499827$1178233839$gmane$org@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200705022126.47897.rjw@sisk.pl>
	<20070503224807.GD13426@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070503224807.GD13426@elf.ucw.cz>
Content-Disposition: inline
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, 4 May 2007 00:48, Pavel Machek wrote:
> Hi!
> 
> Crazy idea... could we kill hibernate_ops-like struct, and just create
> a device for ACPI, using its suspend()/resume()/whatever callbacks to
> do the ACPI magic?

Hmm, I didn't think about that.  It seems to be viable at first sight.

Still, I think we can first separate hibernation_ops from pm_ops, figure out
what they should be and then try to replace them with a cleaner solution.

> > Okay.  Since we're trying to separate the hibernation code from the
> > suspend code anyway, we can use the opportunity to introduce some new
> > callbacks for the hibernation and/or redefine the existing ones.
> > 
> > The spec suggests that we need the following callbacks:

In fact, I should have added

(0) start() - called before device_suspend(), execute _TTS(S4)

and I'm not sure if the GPEs should be disabled here or in prepare()

In principle this could be done as a device's .resume() call, but that would
have to be the very first device registered (can we do that?).

> > (1) prepare() - called after device_suspend(), execute _PTS and
> > disable GPEs
> 
> sysdev .suspend() method would do the trick.

Yes.

> > (2) cancel() - called at any time after prepare() if there's an error, execute
> >     _WAK and enable run-time GPEs
> 
> sysdev .resume() should do the trick.

But .resume() would be called unconditionally, so there should be a way of
figuring out what to do - looks complicated.
 
> > (3) enter() - called after the image has been saved, execute _GTS and do what's
> >     currently done in pm_enter()
> 
> This one is tricky. It is essentially
> powerdown_but_enter_S4_instead. I guess we can live with if()... as we
> need to special-case reboot in the same place.

Yes.

> > (4) finish() - called after the image has been restored, do what's currently
> >     done in pm_finish()
>
> platform (?) device .resume() method should work.

Hmm, perhaps.

And we need one more (in fact this one should be called finish() and the
previous one wake() or something like that):

(5) finish() - called after device_resume(), but only after the image has been
restored or in case of a hibernation error, execute _TTS(S0).  It looks like
this also should enable the GPEs (or the previous one; that's the information
I'm looking for).

Greetings,
Rafael
