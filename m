From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: s3c2440: Remove hardware.h inclusion
Date: Mon, 06 Jan 2014 02:08:52 +0100
Message-ID: <6157857.sv6vFzUCxp@vostro.rjw.lan>
References: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org> <CAKohpo=7Z5F+jKSzYEdb9VYzbwgJN_V1ZvxFkYkMToqNeMWfWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=7Z5F+jKSzYEdb9VYzbwgJN_V1ZvxFkYkMToqNeMWfWg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Patch Tracking <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Friday, January 03, 2014 03:41:39 PM Viresh Kumar wrote:
> On 3 January 2014 14:57, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > The contents of this header file are not referenced in the driver.
> > Remove its inclusion.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/cpufreq/s3c2440-cpufreq.c |    2 --
> >  1 file changed, 2 deletions(-)
> 
> For all three patches:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

All three queued up for 3.14, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
