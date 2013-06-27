From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Thu, 27 Jun 2013 13:07:09 +0200
Message-ID: <20130627130709.698dd18a@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-3-git-send-email-l.majewski@samsung.com>
 <CAKohpon7GLGvrkFQdWpco5f9P7S8L-2-ETMu2-3dFEDwOgL1RQ@mail.gmail.com>
 <20130626145412.1e9bfa63@amdc308.digital.local>
 <CAKohpo==702FnSwhrPi6L1VzLbxO5LT3VDQCru9cwKjgmbppxA@mail.gmail.com>
 <20130627114852.2889eea6@amdc308.digital.local>
 <CAKohpon8iRUiPHJqyLSweqGhAjaZBn2f6TQk+Ow0-DvHofHt1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpon8iRUiPHJqyLSweqGhAjaZBn2f6TQk+Ow0-DvHofHt1Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Jun 2013 15:55:26 +0530, Viresh Kumar wrote:
> On 27 June 2013 15:18, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Thu, 27 Jun 2013 14:32:57 +0530, Viresh Kumar wrote:
> 
> > I thought about this idea, but at cpufreq_boost_trigger_state_sw()
> > I iterate through all available policies and call
> > cpufreq_frequency_table_cpuinfo()[*] on them. In this routine [*] I
> > use cpufreq_boost_enabled() [**] route to search for maximal (boost)
> > frequency.
> > The [**] reads boost_enabled flag, which shall be updated before.
> > When this search fails, then I restore the old value of
> > boost_enabled.
> 
> Ok.

OK
> 
> >> >> > +               else
> >> >> > +                       ret =
> >> >> > cpufreq_boost_trigger_state_sw();
> >>
> >> then why not enable_boost_sw() here? that would be more
> >> relevant.
> >
> > Could you be more specific here?
> 
> I meant rename cpufreq_boost_trigger_state_sw() to
> enable_boost_sw() :)

No problem:
- For SW there will be 
	cpufreq_boost_trigger_state_sw() renamed to enable_boost_sw()

- For HW:
	cpufreq_driver->enable_boost(state) renamed to
		cpufreq_driver->enable_boost_hw(); 

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
