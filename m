From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] Intel pstate driver update
Date: Wed, 08 May 2013 13:56:16 +0200
Message-ID: <3678383.f41mhRL7NJ@vostro.rjw.lan>
References: <1367940030-19311-1-git-send-email-dirk.j.brandewie@gmail.com> <4686510.A1KmKYg1tS@vostro.rjw.lan> <51899AA7.4030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51899AA7.4030106@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 07, 2013 05:21:59 PM Dirk Brandewie wrote:
> On 05/07/2013 05:07 PM, Rafael J. Wysocki wrote:
> > On Tuesday, May 07, 2013 08:20:24 AM dirk.brandewie@gmail.com wrote:
> >> From: dirk <dirk.brandewie@gmail.com>
> >>
> > All queued up for a post-3.10-rc1 push as 3.10 material, but I have a couple
> > of comments.
> >
> > First, the patches didn't apply for me cleanly.  I needed to fix up one of
> > them manually to make it apply and patch [5/6] didn't appear to be necessary
> > at all (it made changes that had been made previously).  Please check the
> > bleeding-edge branch of my tree to see if the code is what you wanted and
> > let me know (either way).
> >
> Srinivas's commit d1b6848 collided with my 5/6 patch. my patches were based off 
> of v3.9. Which branch of yours should I base my submissions on?

Usually, linux-next is a safe bet.

> linux-pm/bleeding-edge is correct.

Good.

> > Second, can you please CC your cpufreq submissions to linux-pm@vger.kernel.org?
> > That will allow me to use Patchwork for managing them, which is much more
> > convenient than plain email.
> >
> 
> No problem

Thanks!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
