From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 RESEND] cpufreq: pxa: convert to clock API
Date: Thu, 11 Jan 2018 14:05:19 +0530
Message-ID: <20180111083519.GG3626@vireshk-i7>
References: <20171014215102.10424-1-robert.jarzmik@free.fr>
 <87mv1kbyth.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87mv1kbyth.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Rafael J Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11-01-18, 09:10, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > As the clock settings have been introduced into the clock pxa drivers,
> > which are now available to change the CPU clock by themselves, remove
> > the clock handling from this driver, and rely on pxa clock drivers.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > This is a resend of a formerly acked patch as all dependencies have
> > hit upstream, see :
> > 	https://www.spinics.net/lists/arm-kernel/msg540181.html
> > ---
> >  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
> >  1 file changed, 39 insertions(+), 152 deletions(-)
> 
> Hi Rafael,
> 
> Would you consider taking this patch in ? It was submitted and acked a long ago,
> and as the above mail says, the dependencies have hit mainline for quite some
> time now.

Check linux-next.

d9278077385f cpufreq: pxa: convert to clock API

-- 
viresh
