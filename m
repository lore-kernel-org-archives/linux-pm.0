From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Thu, 27 Jul 2017 20:44:03 -0700
Message-ID: <CAEi0qNnz3PhETrq4YSxLZCa0jdfApSw8K9dgJN276rWG7qbwyg@mail.gmail.com>
References: <cover.1501060871.git.viresh.kumar@linaro.org> <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
 <20170727054635.GJ352@vireshk-i7> <CAEi0qN=e9sL+ndTerAwcJTwCsmzJiwgtWkSk3Coa0Qzvyzdb2Q@mail.gmail.com>
 <20170727072146.uiuvadgsbpjk5gyb@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727072146.uiuvadgsbpjk5gyb@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Joel Fernandes <joelaf@google.com>, eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <smuckle.linux@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 27, 2017 at 12:21 AM, Juri Lelli <juri.lelli@arm.com> wrote:
[..]
>> >
>> > But even without that, if you see the routine
>> > init_entity_runnable_average() in fair.c, the new tasks are
>> > initialized in a way that they are seen as heavy tasks. And so even
>> > for the first time they run, freq should normally increase on the
>> > target CPU (at least with above application).i
>>
>> Ok, but the "heavy" in init_entity_runnable_average means for load,
>> not the util_avg. The util_avg is what's used for frequency scaling
>> IIUC and is set to 0 in that function no?
>>
>
> True for init_entity_runnable_average(), but for new task post_init_
> entity_util_avg() is then also called (from wake_up_new_task()), which
> modifies the initial util_avg value (depending on current rq {util,
> load}_avg.

Got it. That makes sense, thank you!

-Joel
