From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/5] cpufreq: Define cpufreq_set_drv_attr_files() to add
 per CPU sysfs attributes
Date: Thu, 06 Jun 2013 11:16:06 +0200
Message-ID: <20130606111606.38f9a074@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370502472-7249-2-git-send-email-l.majewski@samsung.com>
 <CAKohpokYdwutUX-zkHLs3bKmLg=Fb7WvKcwvfek9Q8k=XXs3bw@mail.gmail.com>
 <20130606105814.3495e3a9@amdc308.digital.local>
 <CAKohpo=fLmDog5KVjijEZNakpjLvrKy=S+nv+GQyCc2brcnO1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27373 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3FFJQP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2013 05:16:15 -0400
In-reply-to: <CAKohpo=fLmDog5KVjijEZNakpjLvrKy=S+nv+GQyCc2brcnO1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

Hi Viresh,

> On 6 June 2013 14:28, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > I'm confused here.
> >
> > So you want to check dev_attr for NULL just after:
> > drv_attr = cpufreq_driver->attr;
> > if (!drv_attr)
> >         goto error;
> >
> > and skip the check at the while loop:
> > while ((drv_attr) && (*drv_attr))
> >
> > to
> >
> > while ((*drv_attr))
> >
> > Am I correct?
> 
> Bingo!!

Ok, no problem :-)

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
