From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 7/7] Documentation:cpufreq:boost: Update BOOST
 documentation
Date: Tue, 16 Jul 2013 13:33:19 +0200
Message-ID: <20130716133319.49ed0838@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-8-git-send-email-l.majewski@samsung.com>
 <CAKohpo=oB_4gGtNn6jvxSCp665pOq6oqeTCCyGzmN_eWqt0Lhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=oB_4gGtNn6jvxSCp665pOq6oqeTCCyGzmN_eWqt0Lhg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Jul 2013 15:31:43 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > -Reading the file is always supported, even if the processor does
> > not -support boosting. In this case the file will be read-only and
> > always -reads as "0". Explicitly changing the permissions and
> > writing to that -file anyway will return EINVAL.
> > +The file is exported only when cpufreq driver supports boosting.
> > +Explicitly changing the permissions and writing to that file
> > anyway will +return EINVAL.
> 
> For acpi-cpufreq reading the file should be always supported. And this
> must be mentioned in doc.

As fair as I've understood our previous discussion (at [*]) we have
agreed about this. We only export boost attribute when it is supported
by cpufreq_driver. Rafael was very clear about exporting boost
attribute:

"Simple: Export it only when supported."

[*]: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
