From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/2] cpufreq: ondemand: add AMD specific powersave bias
Date: Mon, 01 Apr 2013 22:43:46 +0200
Message-ID: <2270081.ZoKm6VRJar@vostro.rjw.lan>
References: <1364495057-14939-1-git-send-email-jacob.shin@amd.com> <CAKohpokHs3pxnYx3QraEYhxqGs8KdTiomPpcbEDNgChaZDWK4A@mail.gmail.com> <20130401193839.GA15738@jshin-Toonie>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130401193839.GA15738@jshin-Toonie>
Sender: cpufreq-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 01, 2013 02:38:39 PM Jacob Shin wrote:
> On Fri, Mar 29, 2013 at 08:18:54AM +0530, Viresh Kumar wrote:
> > On 28 March 2013 23:54, Jacob Shin <jacob.shin@amd.com> wrote:
> > > This patchset adds AMD specific powersave bias function to the ondemand
> > > governor; which can be used to help ondemand governor make more power conscious
> > > frequency change decisions based on feedback from hardware (availble on AMD
> > > Family 16h and above).
> > >
> > > Hardware feedback tells software how "sensitive" to frequency changes the
> > > workloads are. CPU-bound workloads will be more sensitive -- they will
> > > perform better as frequency increases. Memory/IO-bound workloads will be less
> > > sensitive -- they will not necessarily perform better as frequnecy increases.
> > >
> > > This patchset was compared against ondemand governor without powersave bias
> > > and did not show any performance degradation on CPU-bound workloads such as
> > > kernbench and unixbench. While saving power on Memory-bound workloads such as
> > > stream.
> > >
> > > This applies to linux-pm's linux-next branch, on top of Viresh's 'Implement
> > > per policy instance of governor' V4 patchset:
> > >
> > > https://lkml.org/lkml/2013/3/27/348
> > >
> > > V2:
> > > * Added proper include files to amd_freq_sensitivity.c
> > > * Only register powersave_bias_target function pointer and not the entire
> > >   od_ops.
> > >
> > > Jacob Shin (2):
> > >   cpufreq: ondemand: allow custom powersave_bias_target function to be
> > >     registered
> > >   cpufreq: AMD "frequency sensitivity feedback" powersave bias for
> > >     ondemand governor
> > >
> > >  arch/x86/include/uapi/asm/msr-index.h  |    1 +
> > >  drivers/cpufreq/Kconfig.x86            |   10 +++
> > >  drivers/cpufreq/Makefile               |    1 +
> > >  drivers/cpufreq/amd_freq_sensitivity.c |  147 ++++++++++++++++++++++++++++++++
> > >  drivers/cpufreq/cpufreq_governor.h     |    3 +
> > >  drivers/cpufreq/cpufreq_ondemand.c     |   22 ++++-
> > >  6 files changed, 181 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/cpufreq/amd_freq_sensitivity.c
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> Hi Rafael,
> 
> If this looks okay to you,
> please commit to linux-next when you get the chance.

OK, I wonder what Boris thinks about it, though.

Boris, could you please have a look at this and let me know what you think?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
