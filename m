From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp issues
Date: Sat, 4 Jun 2005 01:21:09 +0200
Message-ID: <20050603232109.GA2132@elf.ucw.cz>
References: <1117764111.31082.119.camel@gaston>
	<20050603111541.GC3867@elf.ucw.cz>
	<1117839029.31082.180.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============037817742843619939=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117839029.31082.180.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============037817742843619939==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

[Hmm, you seem to be awake at *exactly* wrong moments. I just decided
I really need some sleep 10 minutes ago.]

> > PM_DISK_REBOOT is very usefull for testing (and I believe generic; you
> > could do that on ppc too). PM_DISK_SHUTDOWN is usefull for using
> > normal powerdown paths in case something is wrong with disk-specific
> > powerdown. We should move away from it, but please try not to kill it.
> 
> Well, I have a problem with these because they don't call the arch
> prepare/finish callbacks.
> 
> Anyway, I discussed with Patrick yesterday and we came to the conclusion
> that the best is in fact to just kill the current mecanism which was
> done upside down. Kill pm_ops completely and instead of having a slim
> "core" that uses callbacks all over, have the arch contain the main
> state enter function and have the stuff in kernel/power/* be "library"
> functions to be called by the arch code.
> 
> The idea here is then to have the arch provide main.c with an array of
> "name",function pairs (name beeing the name in /sys/power/state and
> function is what to call when the user echo's that name
> to /sys/power/state). The rest would be entirely under arch control, and
> that would remove most of the current cruft.

swsusp/powerdown and swsusp/reboot cases should really only require
save_processor_state and friends filled by architecture... And at
least i386 and x86-64 (and possibly ia64) will have basically same
code for all the stuff except save_processor_state and friends...

I'm not sure what you want to do with "take the control of main.c". If
you do device calls in different order, or diverge in something
visible to drivers, you'll create maintanance nightmare. Is it really
impossible to handle ppc without adding more callbacks?

[Modulo apm emulation, I see why you need callbacks there, but that
should not be there or it should be in generic code, anyways].

> We could provide an "example" default implementation that does only
> swsusp that an arch can "drop in" if you want, but archs have to
> implement the various "inline" callbacks anyway (save_processor_state &
> friends).

...aha, so you know that much code can be shared :-). Yes, "example"
implementation should work okay. Use "example" implementation, add
custom save_processor_state, and you should have working
swsusp/powerdown...

							Pavel

--===============037817742843619939==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============037817742843619939==--
