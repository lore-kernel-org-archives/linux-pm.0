From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 01/12] PM / devfreq: Init user limits from OPP limits,
 not viceversa
Date: Fri, 15 Jun 2018 14:25:42 -0700
Message-ID: <20180615212542.GP88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-2-mka@chromium.org>
 <20180615210619.GA249892@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615210619.GA249892@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 15, 2018 at 02:06:21PM -0700, Brian Norris wrote:
> Hi,
> 
> On Thu, Jun 14, 2018 at 12:47:01PM -0700, Matthias Kaehlcke wrote:
> > Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
> > the devfreq device") introduced the initialization of the user
> > limits min/max_freq from the lowest/highest available OPPs. Later
> > commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
> > frequency") added scaling_min/max_freq, which actually represent
> > the frequencies of the lowest/highest available OPP. scaling_min/
> > max_freq are initialized with the values from min/max_freq, which
> > is totally correct in the context, but a bit awkward to read.
> > 
> > Swap the initialization and assign scaling_min/max_freq with the
> > OPP freqs and then the user limts min/max_freq with scaling_min/
> > max_freq.
> > 
> > Needless to say that this change is a NOP, intended to improve
> > readability.
> > ---
> 
> BTW, putting the '---' here means that stuff below it usually gets
> dropped when applied (e.g., with git-am). So it'll drop your
> Signed-off-by and Reviewed-by. Not a huge problem if the maintainers
> look out for that.

It wasn't intended and is related with my current workflow: To keep
easily track of deltas in my tree and have the changelog ready when
sending the patches I currently keep the changelog in the commit
message and manually move it below '---' when doing 'git send-email'.

Seems I got it wrong in this case :(

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!
