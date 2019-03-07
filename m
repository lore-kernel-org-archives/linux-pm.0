From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/6+] cpufreq: Use struct kobj_attribute instead of
 struct global_attr
Date: Thu, 7 Mar 2019 13:21:15 +0100
Message-ID: <20190307122115.GB21325@kroah.com>
References: <81e2be4499ef1a3c315c4c406f25ea12ea197ae5.1551957754.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81e2be4499ef1a3c315c4c406f25ea12ea197ae5.1551957754.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "4 . 6+" <stable@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 07, 2019 at 04:52:52PM +0530, Viresh Kumar wrote:
> commit 625c85a62cb7d3c79f6e16de3cfa972033658250 upstream.
> 
> The cpufreq_global_kobject is created using kobject_create_and_add()
> helper, which assigns the kobj_type as dynamic_kobj_ktype and show/store
> routines are set to kobj_attr_show() and kobj_attr_store().
> 
> These routines pass struct kobj_attribute as an argument to the
> show/store callbacks. But all the cpufreq files created using the
> cpufreq_global_kobject expect the argument to be of type struct
> attribute. Things work fine currently as no one accesses the "attr"
> argument. We may not see issues even if the argument is used, as struct
> kobj_attribute has struct attribute as its first element and so they
> will both get same address.
> 
> But this is logically incorrect and we should rather use struct
> kobj_attribute instead of struct global_attr in the cpufreq core and
> drivers and the show/store callbacks should take struct kobj_attribute
> as argument instead.
> 
> This bug is caught using CFI CLANG builds in android kernel which
> catches mismatch in function prototypes for such callbacks.
> 
> Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
> Reported-by: Donghee Han <dh.han@samsung.com>
> Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> This needs to be applied from v4.6 to v4.9 (including both).

Does not apply to the 4.9.y stable queue :(

Are you sure you backported this correctly?  No need to care about 4.6.

greg k-h
