From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 6 Sep 2006 12:59:30 +0200
Message-ID: <20060906105930.GI4987@atrey.karlin.mff.cuni.cz>
References: <200609032240.k83MeRhV014303@olwen.urbana.css.mot.com>
	<20060904090626.GJ9991@elf.ucw.cz>
	<20060905164515.GA7597@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060905164515.GA7597@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Gross <mgross@linux.intel.com>
Cc: matthew.a.locke@comcast.net, scott.preece@motorola.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


> > > I think I'm listening to arguments just as much as you guys are! We j=
ust
> > > disagree. What are your criteria for "a clean interface"? Why do you
> > > think that n separate set-parameter() interfaces, with no consistency
> > > relationship between them, are cleaner than one define-op() and one
> > > set-op() interface?
> > =

> > Because we already have cpufreq-set-parameter() interface and
> > enter-suspend-state() interface. We can't really get rid of them.
> >
> This is true.  Yet todays cpufreq interface is not up to the job of
> providing power management for many embedded platforms.

> > If you add set-op() replacing both cpufreq-set-parameter() and
> > enter-suspend-state(), we'll end up with two different interfaces for
> > each interface; that's considered "mess".
> =

> Why can't they coexist?
> =

> Are you arguing that the cpufreq interface be morphed to support power
> op applications?

No. I'm arguing that

* cpufreq interface should be used for changing cpu frequency

* additional interfaces should be created for changing memory clock
etc.

* existing interfaces should be used for turning devices on/off (and
new ones created when old ones do not exist)

* powerop should take a look what userspace wants, and just close
closest point to that.
							Pavel

-- =

Thanks, Sharp!
