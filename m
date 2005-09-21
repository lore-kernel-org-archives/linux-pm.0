From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Wed, 21 Sep 2005 14:45:23 +0200
Message-ID: <20050921124523.GB2013@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
	<20050901201714.GA2027@openzaurus.ucw.cz>
	<1127259699.4386.82.camel@gaston>
	<20050921101811.GC25297@atrey.karlin.mff.cuni.cz>
	<1127298751.4386.114.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48414954993652559=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1127298751.4386.114.camel@gaston>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============48414954993652559==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I still do my "userspace freezing", except that it does not freeze the
> > process doing that. (Thats no change from previous design,
> > BTW). System snapshot works single CPU and with interrupts disabled;
> > so it indeed should be atomic. That should mean there are no
> > interesting races, as long as userspace app is not doing anything
> > stupid.
> 
> Which include things like taking page faults etc... are you mlock'ing it
> all ? I really don't see the point though. It's not like we actually
> need a 3rd version of swsusp, and there are plenty of other more
> important things to work on !

Yes, I'm mlocking it.

We do have suspend2, and we do want its features, but we also do not
want to merge it all into kernel. (10 000 LOC). Plus suspend2 already
has its own userland helper for asking user questions.

swsusp3 is likely easier way to go than transforming suspend2 into
something mergeable. [Ouch and BTW it works now :-)]
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============48414954993652559==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48414954993652559==--
