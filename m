From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data
 protection
Date: Fri, 5 Feb 2016 08:52:22 +0530
Message-ID: <20160205032222.GB21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1529283.0IedZktI9q@vostro.rjw.lan>
 <20160204050954.GU3469@vireshk>
 <CAJZ5v0hWj4JgCh76Fg48ex3Svv7BUHR=9+RoA728R9aYU+12Pw@mail.gmail.com>
 <20160205025948.GE3068@vireshk>
 <CAJZ5v0iyJSuWkqrL8VuSbX8G5s2X+fYngQqi+eVrfVMkLrkmeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iyJSuWkqrL8VuSbX8G5s2X+fYngQqi+eVrfVMkLrkmeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 04:06, Rafael J. Wysocki wrote:
> And why is this a big problem, actually?  Why do we want the switching
> of governors to be that efficient?

I am not saying its a big problem, just that its kind of a big lock,
which could have been finer.

-- 
viresh
