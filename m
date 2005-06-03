From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: swsusp issues
Date: Sat, 04 Jun 2005 09:29:56 +1000
Message-ID: <1117841396.31082.196.camel@gaston>
References: <1117764111.31082.119.camel@gaston>
	<20050603111541.GC3867@elf.ucw.cz> <1117839029.31082.180.camel@gaston>
	<20050603232109.GA2132@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86603612602661162=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050603232109.GA2132@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============86603612602661162==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> swsusp/powerdown and swsusp/reboot cases should really only require
> save_processor_state and friends filled by architecture... And at
> least i386 and x86-64 (and possibly ia64) will have basically same
> code for all the stuff except save_processor_state and friends...

Eugh.... No. Maybe you can get away without the arch callbackcs on x86,
but there are a bunch of things that need to be properly saved/restored
even for basic swsusp that don't fit in the driver model. (Besides, you
don't even call device_power_down, so the stuffs that are sysdev's
aren't dealt with properly neither).

> I'm not sure what you want to do with "take the control of main.c". If
> you do device calls in different order, or diverge in something
> visible to drivers, you'll create maintanance nightmare. Is it really
> impossible to handle ppc without adding more callbacks?

I'm pretty sure it's impossible to handle anything correctly. Your x86
implementation may "happen" to work but I'm really not confident about
it.

> [Modulo apm emulation, I see why you need callbacks there, but that
> should not be there or it should be in generic code, anyways].

There are other things that need proper massaging.

> > We could provide an "example" default implementation that does only
> > swsusp that an arch can "drop in" if you want, but archs have to
> > implement the various "inline" callbacks anyway (save_processor_state &
> > friends).
> 
> ...aha, so you know that much code can be shared :-). Yes, "example"
> implementation should work okay. Use "example" implementation, add
> custom save_processor_state, and you should have working
> swsusp/powerdown...

I don't care a bit about sharing code in that area. "How much" amounts
to 3 function calls, so honestly, that is not an issue. I agree with
Patrick here, the toplevel enter_state() function should probably just
be arch code.

BEn.



--===============86603612602661162==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86603612602661162==--
