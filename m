From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [Eas-dev] [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Thu, 27 Jul 2017 08:21:46 +0100
Message-ID: <20170727072146.uiuvadgsbpjk5gyb@e106622-lin>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
 <20170727054635.GJ352@vireshk-i7>
 <CAEi0qN=e9sL+ndTerAwcJTwCsmzJiwgtWkSk3Coa0Qzvyzdb2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41992 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdG0HVw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jul 2017 03:21:52 -0400
Content-Disposition: inline
In-Reply-To: <CAEi0qN=e9sL+ndTerAwcJTwCsmzJiwgtWkSk3Coa0Qzvyzdb2Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Joel Fernandes <joelaf@google.com>, eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>

Hi,

On 26/07/17 23:23, Joel Fernandes (Google) wrote:
> Hi Viresh,
> 
> On Wed, Jul 26, 2017 at 10:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-07-17, 22:14, Joel Fernandes (Google) wrote:

[...]

> >
> > But even without that, if you see the routine
> > init_entity_runnable_average() in fair.c, the new tasks are
> > initialized in a way that they are seen as heavy tasks. And so even
> > for the first time they run, freq should normally increase on the
> > target CPU (at least with above application).i
> 
> Ok, but the "heavy" in init_entity_runnable_average means for load,
> not the util_avg. The util_avg is what's used for frequency scaling
> IIUC and is set to 0 in that function no?
> 

True for init_entity_runnable_average(), but for new task post_init_
entity_util_avg() is then also called (from wake_up_new_task()), which
modifies the initial util_avg value (depending on current rq {util,
load}_avg.
