From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: Re: [stable request <=3.5] acpi-cpufreq: set current frequency based
 on target P-State
Date: Fri, 20 Dec 2013 10:19:12 +0200
Message-ID: <20131220081912.GA13684@hobo.Home>
References: <CAHTgTXW_M6U6oCgek-K45O2PeS71RpjUyZeJ8f5C97odvk09MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHTgTXW_M6U6oCgek-K45O2PeS71RpjUyZeJ8f5C97odvk09MA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Shatil Rafitullah <srafiullah@twopensource.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 06:14:12PM -0800, Vinson Lee wrote:
> Hi.
> 
> Is commit 8673b83bf2f013379453b4779047bf3c6ae387e4 "acpi-cpufreq: set
> current frequency based on target P-State" applicable to kernels
> before 3.8?
> 
> We found that this patch allows the kernel to control P-states on
> 3.4.74 on some platforms. However, other platforms were able to change
> P-states even without this patch.
> 

Well, it fixes a regression introduced in 3.8 which affected setting
turbo frequencies (I'm not sure if the 3.8 patch was backported).
However, there may be other situations where the target frequency is
different from the reported frequency which 8673b83bf2f0 could well fix.

Cheers
-- 
Ross Lagerwall
