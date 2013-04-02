From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: [PATCH v6 2/2] cpufreq: covert the cpufreq_data_lock to a
	spinlock
Date: Mon, 1 Apr 2013 19:56:18 -0500
Message-ID: <20130402005618.GA12199@gulag1.americas.sgi.com>
References: <5159C147.70800@sgi.com> <1364847069-2887-1-git-send-email-nzimmer@sgi.com> <1364847069-2887-3-git-send-email-nzimmer@sgi.com> <1479737.lmOfIzUVqh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479737.lmOfIzUVqh@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nathan Zimmer <nzimmer@sgi.com>, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 01, 2013 at 10:41:27PM +0200, Rafael J. Wysocki wrote:
> On Monday, April 01, 2013 03:11:09 PM Nathan Zimmer wrote:
> > This eliminates the rest of the contention found in __cpufreq_cpu_get.
> > I am not seeing a way to use the rcu so we will have to make due with a
> > rwlock for now.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
> 
> I've already applied this one.
> 
> Can you please check if the version in my tree is OK?
> 
> Rafael
> 

Nope, the previous version was too different, probably best to just replace it.
> 
