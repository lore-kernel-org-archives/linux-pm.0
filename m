From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH 1/5] cpufreq: handle SW coordinated CPUs
Date: Wed, 30 Jan 2013 12:42:33 +0100
Message-ID: <20130130114233.GD32315@balto.lan>
References: <1356620142-8680-1-git-send-email-fabio.baltieri@linaro.org>
 <1356620142-8680-2-git-send-email-fabio.baltieri@linaro.org>
 <CAOh2x==SG32h-BbrnLN8gwiYNz7bS-REVcmXN67fdYPqFVmCiA@mail.gmail.com>
 <20130130091453.GA32315@balto.lan>
 <20130130110429.GC32315@balto.lan>
 <CAKohpo=_oim1FN+Cu+kMKLRpH1c+6-wuQACEdpVS8yHoANHhcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpo=_oim1FN+Cu+kMKLRpH1c+6-wuQACEdpVS8yHoANHhcA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Rickard Andersson <rickard.andersson@stericsson.com>, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 30, 2013 at 04:47:58PM +0530, Viresh Kumar wrote:
> On 30 January 2013 16:34, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> > Small sidenote, actually what I'm going to drop here i *cdbs, as I need
> > cpu for schedule_delayed_work_on and can't use cdbs->cpu for that as
> > it's the master's one.
> 
> I can't find code which would do j_cdbs->cpu = j and so j_cdbs->cpu is
> un-initialized. So, if that's true, you can initialize that and drop
> cpu param too.

Right, it looks like cdbs->cpu is not really needed anymore.  Anyway I'm
quite happy with how it came out passing cpu number, code is a bit more
compact, so I'm sending that version and than we can discuss if recycle
cdbs->cpu or just drop it.

Fabio

-- 
Fabio Baltieri
