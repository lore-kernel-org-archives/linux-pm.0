From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix checkpatch warnings
Date: Wed, 30 Apr 2014 22:16:14 +0200
Message-ID: <2559921.qEXZdngR08@vostro.rjw.lan>
References: <5356DB92.1060600@semaphore.gr> <4780344.RfsAca3Qz3@vostro.rjw.lan> <CAKohponkTeEqdgqJ6+caQcKd5yoMNhFvkZib1UueqNBCmO=pmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponkTeEqdgqJ6+caQcKd5yoMNhFvkZib1UueqNBCmO=pmA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 30, 2014 09:34:03 AM Viresh Kumar wrote:
> On 30 April 2014 04:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > It should be cleaned up generally, so if you have the time and you're willing
> > to do such things, please do them.
> >
> > That said things like lines in excess of 80 characters may stay as they are.
> 
> I have tried this sort of stuff earlier, but there is one issue that stands
> up again and again. When you update neighboring lines of lines
> crossing 80 columns, we do get warnings for lines which aren't actually
> updated by us (from checkpatch.pl). So, probably we need to fix
> checkpatch then..

That has been my opinion pretty much forever.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
