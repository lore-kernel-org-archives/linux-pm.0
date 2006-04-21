From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 17:40:44 +0200
Message-ID: <20060421154044.GA29233@isilmar.linta.de>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<20060420132542.GA2668@ucw.cz>
	<200604210827.33274.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============064173261240363377=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604210827.33274.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============064173261240363377==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2006 at 08:27:32AM -0700, David Brownell wrote:
> > > The only issue I see with numbers is that they imply order,
> > > and it may be that some operating points might not have
> > > such a strict order.
> 
> In my observation, "strict order" would be the exception not
> the rule.  There are often three or four orthogonal factors,
> and they don't naturally fit any two-dimensional linear order.

We need to distinguish two aspects here -- the "whole system states", which
in fact create a multi-dimensional problem, and one specific attribute of
one specific device. The performance level of one specific networking device,
for example. Or its sleep state. Or, if you can describe sub-aspects of a
networking device, the performance level or the sleep state of that
sub-device. So each strict-order parameter has its own file (that's why
the RFC mentioned three files for CPUs in the ACPI-model, for performance,
idle and throttling; different CPUs in different, especially embedded
surroundings may require additional files).

> > Yes, inventing good names may be tricky in some cases, but in other
> > cases names are very natural (arm has sleep, deep sleep and big sleep,
> > iirc).... And we can always fall back to state0..state5.
> 
> Well, OMAP is one implementation that uses ARM, and it certainly has
> "deep sleep" and "big sleep".  But other ARM based SOCs provide very
> different power abstractions (consider "slow clock mode", "idle",
> "frozen", "standby", "stop", "sleep") and may use the same names to
> indicate different things.  System state names are system specific.

Well, the big problem with names and anything "system specific" is that it
makes _abstractions_ harder. It makes userspace's life harder, as it needs
to know what "idle" means on a specific system, instead.

> If ACPI wants to use names like "ACPI_S0".."ACPI_S5", that's fine;
> but Linux should not inflict such an approach on systems that don't
> use ACPI.  Developers might find it handy to contrast one SOC's
> "deep sleep" to "ACPI_S3" (or to "deep sleep" on another SOC), but
> it won't be an exact match; square peg, round hole.

Here you're talking about "system states" instead of "device states" again.

	Dominik

--===============064173261240363377==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============064173261240363377==--
