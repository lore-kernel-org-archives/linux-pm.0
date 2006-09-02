From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 2 Sep 2006 21:30:59 +0200
Message-ID: <200609022130.59256.rjw@sisk.pl>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A94E18@de01exm64.ds.mot.com>
	<1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
	<b324b5ad0609021105u7fcab8c3w6d21bfca9caa93d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b324b5ad0609021105u7fcab8c3w6d21bfca9caa93d1@mail.gmail.com>
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
To: David Singleton <daviado@gmail.com>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday 02 September 2006 20:05, David Singleton wrote:
> On 8/29/06, Matthew Locke <matthew.a.locke@comcast.net> wrote:
> >
> > On Aug 29, 2006, at 10:49 AM, Preece Scott-PREECE wrote:
> >
> > >
> > >> From: linux-pm-bounces@lists.osdl.org
> > >> [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel Machek
> > >> Sent: Tuesday, August 29, 2006 11:35 AM
> > >> To: David Singleton
> > >> Cc: linux-pm@lists.osdl.org
> > >> Subject: Re: [linux-pm] So, what's the status on the recent
> > >> patches here?
> > >>
> > >> Hi!
> > >>>>>         point, by name. There is a new
> > >>>> /sys/power/operating_points directory
> > >>>>>         that shows all the operating points the
> > >>>> system supports. An
> > >>>>>         exampled from my centrino laptop shows:
> > >>>>>
> > >>>>>         /sys/power/operating_points/high
> > >>>>>         /sys/power/operating_points/highest
> > >>>>>         /sys/power/operating_points/low
> > >>>>>         /sys/power/operating_points/lowest
> > >>>>>         /sys/power/operating_points/medium
> > >>>>>         /sys/power/operating_points/mem
> > >>>>>         /sys/power/operating_points/standby
> > >>>>
> > >>>> What makes you think that mixing operating and sleep
> > >> states is good
> > >>>> idea?
> > >>>
> > >>> They are all power states managed by the kernel and in the
> > >> operating
> > >>> point concept they are all operating points the system supports.
> > >>
> > >> That does not make mixing them right.
> > > ---
> > >
> > > Could you say why you think they shouldn't be mixed? Absent argument =
to
> > > the contrary,
> > > making it a single continuum seems appealing. Why have separate
> > > policies?
> >
> > I know this questions is directed at Pavel but I have similar concerns.
> >    I agree that making sleep states into operating points is appealing.
> > However,  if the implementation is just going to special case the sleep
> > state operating points then they should be handled separately.  As
> > Pavel points out, you can see from Dave's implementation that the
> > operating point definition doesn't quite work for both.   Voltage and
> > frequency don't have meaning for the sleep points.
> =

> Actually what I was trying, unsuccessfully, to explain was that
> suspend states are valid, supported operating states the
> system can be in for power management.    And that they are the
> same as an operating point for a processor frequency.

That depends on the definition, but I think of suspend states as the ones
that require processes to be frozen before they can be entered.  IMHO it is
quite clear that such states cannot be handled in the same way as those
that do not require the freezing of processes, so they are not the same.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
