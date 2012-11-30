From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/5] mfd: db8500: Update cpufreq device name
Date: Fri, 30 Nov 2012 13:44:54 +0100
Message-ID: <20121130124454.GR3176@sortiz-mobl>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
 <1354098464-6665-3-git-send-email-ulf.hansson@stericsson.com>
 <20121130105031.GK3176@sortiz-mobl>
 <CAPDyKFrjd8mtfG2fVOr5CseAK7UEr=W6Ok8FYwP1DsgBtk4RNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrjd8mtfG2fVOr5CseAK7UEr=W6Ok8FYwP1DsgBtk4RNQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On Fri, Nov 30, 2012 at 12:54:29PM +0100, Ulf Hansson wrote:
> On 30 November 2012 11:50, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > Hi Ulf,
> >
> > On Wed, Nov 28, 2012 at 11:27:41AM +0100, Ulf Hansson wrote:
> >> From: Lee Jones <lee.jones@linaro.org>
> >>
> >> Since the cpufreq driver for ux500 has been renamed from
> >> cpufreq-db8500 to cpufreq-dbx500, we need to change the
> >> device name here as well.
> >>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Samuel Ortiz <sameo@linux.intel.com>
> >> ---
> >>  drivers/mfd/db8500-prcmu.c |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > This one doesn't apply to my tree, it would make more sense to push this one
> > through Mike's tree.
> 
> Yes, you are right! My earlier clock patches which was affecting
> cpufreq and mfd was merged through Mikes tree.
> I will suggest this complete patchset shall go though Mikes tree.
> 
> Do I have your ack for the mfd patch?
Yes:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
