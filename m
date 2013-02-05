From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] cpufreq: cpufreq_driver_lock is hot on large systems
Date: Tue, 05 Feb 2013 11:13:17 +0100
Message-ID: <1535355.NvOsIhbBYp@vostro.rjw.lan>
References: <1360017913-25667-1-git-send-email-nzimmer@sgi.com> <3480441.gCEh0J5edK@vostro.rjw.lan> <CAOh2x=mWc9rBX3O_1NSr23TAWFtRA6BNW3TZ8FhZOMdH_0dmzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=mWc9rBX3O_1NSr23TAWFtRA6BNW3TZ8FhZOMdH_0dmzQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 05, 2013 03:28:30 PM Viresh Kumar wrote:
> On Tue, Feb 5, 2013 at 3:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > I actually don't agree with that, becuase the Nathan's apprach shows the
> > reasoning that leads to the RCU introduction quite clearly.  So if you
> > don't have technical problems with the patchset, I'm going to take it as is.
> 
> Great!!
> 
> Okay.. I don't have any technical problems with it, i reviewed most of it
> carefully. The only pending thing is rebase on linux-next, after that i can
> give my ack for it.

Yes, it would be great if it were rebased and retested.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
