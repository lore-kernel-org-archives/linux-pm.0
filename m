From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2] cpufreq: s5pv210: drop check for CONFIG_PM_VERBOSE
Date: Fri, 23 May 2014 20:44:12 +0530
Message-ID: <CAK9yfHxXBpHnAWz3m2HujAoa4DGD=qUqKX=ZVD4UG-iowvcc=g@mail.gmail.com>
References: <1400702036.30334.6.camel@x220>
	<CAK9yfHz2kdfkf+o7fKMRu=nMXxbcHJ227bjpvA=WXt6ptH3QRA@mail.gmail.com>
	<1400740894.21254.8.camel@x220>
	<CAK9yfHzf-Z3AQ4+-sF7xqqUw4dN8aULkCNvLQnmusp_ZiOg+Rw@mail.gmail.com>
	<1400857500.31526.52.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1400857500.31526.52.camel@x220>
Sender: cpufreq-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Paul,

On 23 May 2014 20:35, Paul Bolle <pebolle@tiscali.nl> wrote:
> A pr_err() was added in v3.1. It was guarded by a check for
> CONFIG_PM_VERBOSE. The Kconfig symbol PM_VERBOSE was removed in v3.0. So
> this pr_err() has never been used. Drop that check and clean up the
> message a bit.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
