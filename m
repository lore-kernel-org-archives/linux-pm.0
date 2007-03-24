From: Oliver Neukum <oliver@neukum.org>
Subject: Re: charging batteries from USB [was: Re: Alternative
	Concept]
Date: Sat, 24 Mar 2007 11:20:23 +0100
Message-ID: <200703241120.24230.oliver@neukum.org>
References: <44ECFF94.3030506@gmail.com> <4604835F.1040100@gmail.com>
	<200703231935.24846.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703231935.24846.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

Am Samstag, 24. M=E4rz 2007 03:35 schrieb David Brownell:
> On Friday 23 March 2007 6:48 pm, Dmitry Krivoschekov wrote:
> =

> > I clearly understand these distinct issues, I read Oliver's
> > comments for "switching off autosuspend through sysfs" patch,
> > where he said "This is needed for devices which recharge
> > their batteries of the bus" (but nothing regarding improper
> > behavior of some devices)
> =

> Sometimes people have been known to focus too much on
> secondary issues.  ;)

I did write a patch to introduce a black list for such devices ;-)

Seriously. The kernel can learn to deal with broken devices on its own.
It's a question of black listing or introducing workarounds. Cumbersome
but doable. The question of whether to charge a battery in a device or
conserve the laptop's batteries is not solvable in the kernel. How would
you decide?

	Regards
		Oliver
