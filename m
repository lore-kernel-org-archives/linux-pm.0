From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Tue, 10 Jun 2014 22:17:40 +0200
Message-ID: <5753346.hxK14sqO5y@vostro.rjw.lan>
References: <5396208F.6070400@semaphore.gr> <1447217.dTmMAkaUnF@vostro.rjw.lan> <53973FD4.7090904@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53973FD4.7090904@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: dirk.j.brandewie@intel.com, Stratos Karafotis <stratosk@semaphore.gr>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 10, 2014 10:26:44 AM Dirk Brandewie wrote:
> On 06/10/2014 08:31 AM, Rafael J. Wysocki wrote:
> > On Tuesday, June 10, 2014 08:12:48 AM Dirk Brandewie wrote:
> >> On 06/09/2014 02:01 PM, Stratos Karafotis wrote:
> >>> Remove unnecessary blank lines.
> >>> Remove unnecessary parentheses.
> >>> Remove unnecessary braces.
> >>> Put the code in one line where possible.
> >>> Add blank lines after variable declarations.
> >>> Alignment to open parenthesis.
> >>>
> >>
> >> I don't have an issue with this patch in general but I would rather
> >> the cleanup be done when there is a functional change in the given
> >> hunk of code otherwise you are setting up a fence for stable/backporters
> >> of functional changes in the future.
> >
> > I actually prefer separate cleanups so as to avoid doing multiple things
> > in one patch.
> >
> > Rafael
> >
> I don't have strong feelings either way I was just trying to be kind
> to the maintainers of distro kernels.

And mixing fixes with cleanups in one patch doesn't do any good to them.

Trust me, I used to work for a distro. :-)

Rafael
