From: Mark Gross <mgross@linux.intel.com>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Thu, 12 Oct 2006 08:38:21 -0700
Message-ID: <20061012153821.GA30804@linux.intel.com>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<20061008071649.GB5672@ucw.cz>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061008071649.GB5672@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Sun, Oct 08, 2006 at 07:16:49AM +0000, Pavel Machek wrote:
> Hi!
> =

> > F) So, how would this work for OMAP1?
> > =

> > Let's limit it, to keep it somewhat simple, to the values contained in =
your
> > "struct pm_core_point" for OMAP:
> > =

> > 	int cpu_vltg; /* voltage in mV */
> > 	int dpll;     /* in KHz */
> > 	int cpu;      /* CPU frequency in KHz */
> > 	int tc;       /* in KHz */
> > 	int per;      /* in KHz */
> > 	int dsp;      /* in KHz */
> > 	int dspmmu;   /* in KHz */
> > 	int lcd;      /* in KHz */
> > =

> > and let's also add a
> > =

> > 	int i_am_special;
> =

> Hehe, nice idea.
> =

> > I think that this might be much easier to implement than your PowerOP /
> > operating points / PM core / PowerOP - cpufreq interaction patches. As a
> > matter of fact, some parts of your operating points table infrastructure
> > may be usable for the concept outlined above. So, what do you think? Wh=
at
> > does everyone else involved think about this alternative approach?
> =

> Looks okay to me. Unlike powerop design, this actually works for
> everyone.

Pavel, if you would pay attention better you would notice that at the
underneath of what Dominic is talking about is a concept of *more knobs*
for controlling platform power states.  This is what PowerOP is trying
to bring to the table.  =


PowerOP is not a policy engine like what Dominic is talking about.  And
what Dominic is talking about will need to build on something that will
end up looking so much like power op that it wont be funny.

I don't know how to make it more clear to you, and I hope there isn't
something personal going on between you and the PowerOP guys that is
holding back moving forward on the evolution of a PM framework such as
what Dominic is starting to talk about.

Thanks,

--mgross
