From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: integrator: fixed coding style issues
Date: Thu, 16 Jul 2015 02:33:09 +0200
Message-ID: <1924056.YpXRCYzJ7k@vostro.rjw.lan>
References: <1436553735-17622-1-git-send-email-cristian97.ardelean@gmail.com> <20150713023146.GC10415@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713023146.GC10415@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Cristian Ardelean <cristian97.ardelean@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 13, 2015 08:01:46 AM Viresh Kumar wrote:
> On 10-07-15, 14:42, Cristian Ardelean wrote:
> > Fixed coding style issues found by checkpatch.pl tool. Changed
> > space indentation to tab, removed unneccesary braces, removed
> > space between MODULE macros and parentheses.
> > 
> > REMARKS: failed to 'make' this file with error message
> > 'fatal error: asm/mach-types.h: No such file or directory'.
> > 
> > Signed-off-by: Cristian Ardelean <cristian97.ardelean@gmail.com>
> > ---
> >  drivers/cpufreq/integrator-cpufreq.c |   18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
