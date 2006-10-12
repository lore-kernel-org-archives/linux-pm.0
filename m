From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Thu, 12 Oct 2006 18:02:03 +0200
Message-ID: <20061012160203.GA27219@isilmar.linta.de>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
	<20061008071649.GB5672@ucw.cz>
	<20061012153821.GA30804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061012153821.GA30804@linux.intel.com>
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
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Thu, Oct 12, 2006 at 08:38:21AM -0700, Mark Gross wrote:
> > > I think that this might be much easier to implement than your PowerOP=
 /
> > > operating points / PM core / PowerOP - cpufreq interaction patches. A=
s a
> > > matter of fact, some parts of your operating points table infrastruct=
ure
> > > may be usable for the concept outlined above. So, what do you think? =
What
> > > does everyone else involved think about this alternative approach?
> > =

> > Looks okay to me. Unlike powerop design, this actually works for
> > everyone.
> =

> Pavel, if you would pay attention better you would notice that at the
> underneath of what Dominic is talking about is a concept of *more knobs*
> for controlling platform power states.  This is what PowerOP is trying
> to bring to the table.  =


Oh no. PowerOP does it top->bottom; I try to do it bototm->top. That's the
difference, and it is a _fundamental_ difference. Yes, both will lead to a
concept of "operating points" on systems which may need it. But still the
way you get there (which is important if you want to keep it flexible, and
you do want to keep it flexible to allow for cpufreq) is different.

> PowerOP is not a policy engine like what Dominic is talking about.  And
> what Dominic is talking about will need to build on something that will
> end up looking so much like power op that it wont be funny.

This I dare to doubt.

Thanks,
	Dominik
