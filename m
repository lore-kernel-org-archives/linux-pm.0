From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Wed, 25 May 2016 07:37:59 +0530
Message-ID: <20160525020759.GZ17585@vireshk-i7>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
 <2500818.MtOb9b1ZsB@vostro.rjw.lan>
 <20160524121717.GY17585@vireshk-i7>
 <1494288.rDJLbL32aZ@vostro.rjw.lan>
 <CAJZ5v0iYAEAcf2B=mNULbkDOeUmEX+igNJ0=kLXKXq-G=oGSqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iYAEAcf2B=mNULbkDOeUmEX+igNJ0=kLXKXq-G=oGSqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 25-05-16, 02:48, Rafael J. Wysocki wrote:
> I'm actually considering making the stats code non-modular.
> 
> It won't have a reason to use notifiers then and may be simplified
> quite a bit this way.  As an added benefit, if it doesn't use the
> transition notifier, it won't interfere with fast frequency switching
> in the schedutil governor any more.
> 
> Are there any drawbacks?

I don't think so. Please do that :)

-- 
viresh
