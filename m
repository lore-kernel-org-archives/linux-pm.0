From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 14:43:59 -0700
Message-ID: <200703221444.00905.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221129.28722.david-b@pacbell.net>
	<200703222227.06473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703222227.06473.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 2:27 pm, Rafael J. Wysocki wrote:
> On Thursday, 22 March 2007 19:29, David Brownell wrote:
> > =

> > ... but I guess I don't see why one would want to try to nail down
> > a definition of either "standby" or "STR".
> =

> So that the meaning of "standby" and "STR" is known, more or less.

But "more or less" !=3D "nailed down (so tightly it's not always appicable)"


> If you say "I'd like platforms to implement standby", you should say what
> you mean by "standby", IMHO.

I thought my original note described that, as well as describing how
it differs from STR.

STR shuts down a lot more.  Not necessarily powering down the CPU
(which is what would cause the need for boot/BIOS code to have the
"this is really a resume" cases, and isn't always possible), but at
least being more agressive about powering down clocks and such.

- Dave
