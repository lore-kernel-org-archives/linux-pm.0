From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 1/7] cpufreq: Store cpufreq policies in a list
Date: Wed, 26 Jun 2013 14:15:48 +0200
Message-ID: <20130626141548.31cda5ed@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-2-git-send-email-l.majewski@samsung.com>
 <CAKohpomStuSGyQHnk9jNLpije=SAkb4zHg40zHDgLRCUQeZC1A@mail.gmail.com>
 <20130626125411.5dc935bf@amdc308.digital.local>
 <CAKohpom1yJOAVZ1XE+Q+dtrZM1N6Zqd7DjURSA_f2fhQ1OiCJA@mail.gmail.com>
 <20130626130407.021c05cb@amdc308.digital.local>
 <CAKohpo=aaJyhZ1U2W=DUyi8wGH=rLCL47SBSO7TgsxHXamdotA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpo=aaJyhZ1U2W=DUyi8wGH=rLCL47SBSO7TgsxHXamdotA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Jun 2013 16:38:15 +0530, Viresh Kumar wrote:

> On 26 June 2013 16:34, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > err_out_kobj_put:
> >         list_del(&cpufreq_policy_list);
> >         [rest of error path]
> 
> I couldn't find err_out_kobj_put in existing code :)
> 
> BTW, just add to the list only once everything passed.

Ok, we can do it like that :-)

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
