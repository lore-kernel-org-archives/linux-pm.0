From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime interface
Date: Wed, 16 Jan 2019 12:59:46 +0100
Message-ID: <4866621.FvdCIrMUTQ@aspire.rjw.lan>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org> <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com> <CAJZ5v0i_xyKTtMShut5JEFSE=8GrE4cfb_Yi+eeMPZdRsNvmbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i_xyKTtMShut5JEFSE=8GrE4cfb_Yi+eeMPZdRsNvmbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 7, 2019 3:21:49 PM CET Rafael J. Wysocki wrote:
> On Mon, Jan 7, 2019 at 3:04 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Tvrtko,
> >
> > On Mon, 31 Dec 2018 at 13:32, Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> > >
> > >
> > > On 21/12/2018 13:26, Vincent Guittot wrote:
> > > > On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin
> >
> > [snip]
> >
> > > >>
> > > >> If it is always monotonic, then worst case we report one wrong sample,
> > > >> which I guess is still not ideal since someone could be querying the PMU
> > > >> with quite low frequency.
> > > >>
> > > >> There are tests which probably can hit this, but to run them
> > > >> automatically your patches would need to be rebased on drm-tip and maybe
> > > >> sent to our trybot. I can do that after the holiday break if you are
> > > >> okay with having the series waiting until then.
> > > >
> > > > yes looks good to me
> > >
> > > Looks good to me as well. And our CI agrees with it. So:
> > >
> > > Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> >
> > Thanks for the review and the test
> >
> > >
> > > I assume you will take the patch through some power related tree and we
> > > will eventually pull it back to drm-tip.
> >
> > Rafael,
> > How do you want to proceed with this patch and the 2 others of the serie ?
> 
> I'm going to queue up the whole series for 5.1.

And it has been queued up now, thanks!
