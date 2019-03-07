From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4.10] cpufreq: Use struct kobj_attribute instead of
 struct global_attr
Date: Thu, 7 Mar 2019 19:30:40 +0530
Message-ID: <20190307140040.bq5aehafseme5e5m@vireshk-i7>
References: <a77cd87e1c27367cee2cbdf10d775ad59af9e554.1551957712.git.viresh.kumar@linaro.org>
 <20190307122011.GA21325@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307122011.GA21325@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "4 . 10" <stable@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 07-03-19, 13:20, Greg KH wrote:
> On Thu, Mar 07, 2019 at 04:52:20PM +0530, Viresh Kumar wrote:
> > commit 625c85a62cb7d3c79f6e16de3cfa972033658250 upstream.
> > 
> > The cpufreq_global_kobject is created using kobject_create_and_add()
> > helper, which assigns the kobj_type as dynamic_kobj_ktype and show/store
> > routines are set to kobj_attr_show() and kobj_attr_store().
> > 
> > These routines pass struct kobj_attribute as an argument to the
> > show/store callbacks. But all the cpufreq files created using the
> > cpufreq_global_kobject expect the argument to be of type struct
> > attribute. Things work fine currently as no one accesses the "attr"
> > argument. We may not see issues even if the argument is used, as struct
> > kobj_attribute has struct attribute as its first element and so they
> > will both get same address.
> > 
> > But this is logically incorrect and we should rather use struct
> > kobj_attribute instead of struct global_attr in the cpufreq core and
> > drivers and the show/store callbacks should take struct kobj_attribute
> > as argument instead.
> > 
> > This bug is caught using CFI CLANG builds in android kernel which
> > catches mismatch in function prototypes for such callbacks.
> > 
> > Cc: 4.10 <stable@vger.kernel.org> # 4.10
> 
> Why 4.10?  that's a long-dead kernel version :(

I just backported it on all kernels without looking for which stables
are supported. Just ignore it :)

-- 
viresh
