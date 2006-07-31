From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 platform support 3/5
Date: Mon, 31 Jul 2006 14:24:42 -0700
Message-ID: <200607311424.43847.david-b@pacbell.net>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
	<200607301858.52096.david-b@pacbell.net>
	<acd2a5930607302359w530cef97oca19179afd1369e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <acd2a5930607302359w530cef97oca19179afd1369e1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: patrick.mochel@intel.com, Matthew Locke <matt@nomadgs.com>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Sunday 30 July 2006 11:59 pm, Vitaly Wool wrote:
> > > Let me try to set it this way.
> > > struct powerop_point is an arch independent piece in the sense that a=
ny
> > > platform
> > > which leverages PorewOP concept should implement struct powerop_point.
> > > struct powerop_point is fundamental component that has to be defined =
by
> > > a platfrom.
> >
> > We're not communicating here ... if the contents are arch-specific,
> > it doesn't matter to the interface except that it exist.  A better
> > way to define it would be:
> >
> >         struct powerop_point {
> >                 struct kobject  kobj;
> >                 void            *arch_hook;
> >                 // presumably there will be method hooks too, like
> >                 int             (*enter_prepare)(struct powerop_point *=
);
> >                 int             (*enter)(struct powerop_point *);
> >                 int             (*enter_complete)(struct powerop_point =
*);
> >         };
> >
> > where that "void *" is the entire arch hook, and the kobj holds the
> > name and represents the /sys/power/... directory for that arch.
> =

> I do agree with David here (oh my, I'm in agreement with David on
> something, it's unbelievable ;)

We're allowed to agree when we're both right.  :)

Nitpick to my explanation:  that kobject would represent the sysfs
directory for that set of operating points, not the arch.

- Dave
