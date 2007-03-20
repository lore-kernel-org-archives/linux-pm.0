From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] add firmware disk state and clean up
Date: Tue, 20 Mar 2007 16:31:13 -0700
Message-ID: <200703201631.14245.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<200703201559.33065.david-b@pacbell.net>
	<20070320220946.GL3545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320220946.GL3545@elf.ucw.cz>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Ben Dooks <ben@simtec.co.uk>, Johannes Berg <johannes@sipsolutions.net>, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 3:09 pm, Pavel Machek wrote:
> Hi!
> =

> > > +static int at91_pm_valid(suspend_state_t state)
> > > +{
> > > +	return state =3D=3D PM_SUSPEND_MEM;
> > > +}
> > >  =

> > >  static struct pm_ops at91_pm_ops =3D{
> > >  	.valid		=3D at91_pm_valid_state,
         ^^^^^

> > >  	.prepare	=3D at91_pm_prepare,
> > >  	.enter		=3D at91_pm_enter,
> > > +	.valid		=3D at91_pm_valid,
         ^^^^^

> > >  };
> > >  =

> > >  static int __init at91_pm_init(void)
> > =

> > Clearly bogus.  The STR support isn't upstream yet, true, but
> =

> No... look again. =


No, YOU look again.  If that compiles, it's a GCC bug.


> This tries to disable suspend-to-disk on ARM, so =

> that only suspend-to-RAM is enabled. I'd not call it bogus.
> =

> The series is needed to stop pm from reporting "platform" on ARM;
> "platform" only makes sense on ACPI systems.
> =

> 								Pavel
