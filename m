From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Thu, 03 Jan 2013 13:02:26 +0100
Message-ID: <6008147.vspAd29d9L@vostro.rjw.lan>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org> <7569403.CvHy03LdiU@vostro.rjw.lan> <CAKohponGtLNBnWWX1miV3zjO4pJPumbWoPwoQ2+adCE5t2w5Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponGtLNBnWWX1miV3zjO4pJPumbWoPwoQ2+adCE5t2w5Dw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 03, 2013 09:02:22 AM Viresh Kumar wrote:
> On 3 January 2013 06:43, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> BTW, i consider them as fixes and so would make sense to get them in next rc.
> >> What do you think?
> >
> > Yes, if somebody tells me "yes, this fixes a problem for me".  Otherwise,
> > I don't quite see the reason.
> 
> I don't know how much people test HOTPLUG, but there are clear bugs related
> to hotplug of cpus on a multiple cpu system :)

True, but have those bugs been introduced recently (ie. in v3.8-rc1 or later)?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
