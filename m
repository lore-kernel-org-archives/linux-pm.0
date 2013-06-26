From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 1/7] cpufreq: Store cpufreq policies in a list
Date: Wed, 26 Jun 2013 13:04:07 +0200
Message-ID: <20130626130407.021c05cb@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-2-git-send-email-l.majewski@samsung.com>
 <CAKohpomStuSGyQHnk9jNLpije=SAkb4zHg40zHDgLRCUQeZC1A@mail.gmail.com>
 <20130626125411.5dc935bf@amdc308.digital.local>
 <CAKohpom1yJOAVZ1XE+Q+dtrZM1N6Zqd7DjURSA_f2fhQ1OiCJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpom1yJOAVZ1XE+Q+dtrZM1N6Zqd7DjURSA_f2fhQ1OiCJA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Jun 2013 16:26:30 +0530, Viresh Kumar wrote:
> On 26 June 2013 16:24, Lukasz Majewski <l.majewski@samsung.com> wrote:
> >> > ---
> >
> > So here <---> I will put change log for v5.
> 
> correct.

OK.

> 
> >> >         ret = cpufreq_add_dev_interface(cpu, policy, dev);
> >> >         if (ret)
> >
> > I will add list_del(&cpufreq_policy_list);
> > here.
> 
> May not be sufficient. You must do it once at the end of this routine.

Then I will add this code below:

err_out_kobj_put:
	list_del(&cpufreq_policy_list);
	[rest of error path]

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
