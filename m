From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
Date: Thu, 12 Sep 2013 16:22:30 +0530
Message-ID: <CAKohpo=gF7pVYXrDxBxMOvpu96VOB2V00Y6HACCEz=X-7jWj4A@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
	<52310E43.1090808@intel.com>
	<CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
	<3488595.xbBYlylYai@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3488595.xbBYlylYai@vostro.rjw.lan>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 12 September 2013 16:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, if there's more than one it's even simpler.  You can just pick one. :-)
>
> Like, "for example, <driver name> does the following ... which may cause the
> hardware to misbehave, because ...".

:)

I have written one of my longest changelog ever on the resent of this patch..
Hope that doesn't have any unanswered stuff left :)
