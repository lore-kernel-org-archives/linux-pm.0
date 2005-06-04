From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp issues
Date: Sat, 4 Jun 2005 08:13:40 +0200
Message-ID: <20050604061340.GB2132@elf.ucw.cz>
References: <1117764111.31082.119.camel@gaston>
	<20050603111541.GC3867@elf.ucw.cz>
	<1117839029.31082.180.camel@gaston>
	<20050603232109.GA2132@elf.ucw.cz>
	<1117841396.31082.196.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76591949013999649=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117841396.31082.196.camel@gaston>
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

--===============76591949013999649==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > swsusp/powerdown and swsusp/reboot cases should really only require
> > save_processor_state and friends filled by architecture... And at
> > least i386 and x86-64 (and possibly ia64) will have basically same
> > code for all the stuff except save_processor_state and friends...
> 
> Eugh.... No. Maybe you can get away without the arch callbackcs on x86,
> but there are a bunch of things that need to be properly saved/restored
> even for basic swsusp that don't fit in the driver model. (Besides, you
> don't even call device_power_down, so the stuffs that are sysdev's
> aren't dealt with properly neither).

Well, we might want to fix not calling device_power_down... 

> > > We could provide an "example" default implementation that does only
> > > swsusp that an arch can "drop in" if you want, but archs have to
> > > implement the various "inline" callbacks anyway (save_processor_state &
> > > friends).
> > 
> > ...aha, so you know that much code can be shared :-). Yes, "example"
> > implementation should work okay. Use "example" implementation, add
> > custom save_processor_state, and you should have working
> > swsusp/powerdown...
> 
> I don't care a bit about sharing code in that area. "How much" amounts
> to 3 function calls, so honestly, that is not an issue. I agree with
> Patrick here, the toplevel enter_state() function should probably just
> be arch code.

Well, if we are talking about single function (enter_state) being
moved to arch code... that should be okay. It is really simple
function.

							Pavel	 

--===============76591949013999649==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76591949013999649==--
