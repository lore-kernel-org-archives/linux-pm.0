From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Sun, 14 May 2006 10:13:51 +1000
Message-ID: <1147565632.21291.15.camel@localhost.localdomain>
References: <20060512100544.GA29010@elf.ucw.cz>
	<20060512031151.76a9d226.akpm@osdl.org>
	<200605120652.55658.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============88475461671005973=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605120652.55658.david-b@pacbell.net>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============88475461671005973==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-05-12 at 06:52 -0700, David Brownell wrote:
> On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> > 
> > What will be impacted by this?
> 
> Driver suspend/resume testing ... impact is strongly negative.
> 
> Without this interface, there is NO way to test individual drivers for
> correct handling of suspend/resume calls; the only way to test drivers
> is to suspend/resume the whole system, along with all other drivers in
> the system.  Which means that ALL the drivers must work sanely before
> tests for any one of them can succeed ... a losing model when you're
> testing PM on new platforms.
> 
> Which IMO makes removing this a Bad Thing.  It needs to have some
> kind of replacement in place before the "magic numbers" go away.

And that's why Pavel is not proposing to remove it right away... but to
schedule it's removal so that developpers know right now that building a
whole new kernel<->user interface based on that is not the smartest
thing to do.

> (The magic numbers are bad, and should go away -- yes.  Nobody has
> really shown that userspace needs this mechanism for any purpose
> other than driver testing.  Userspace device-specific power management
> tools would need knowledge that's not yet exposed though sysfs.)
> 
> I think both Patrick Mochel and Alan Stern have sent patches at
> various times to let individual drivers provide a list of named
> states they support,  In some cases (like PCI) those lists could
> be delegated to bus-specific code.
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm


--===============88475461671005973==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============88475461671005973==--
