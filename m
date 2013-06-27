From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: od_set_powersave_bias: NULL pointer dereference
Date: Thu, 27 Jun 2013 21:53:15 +0530
Message-ID: <CAKohpon6m0vX6_ZDrwUD-OBuD5WAysooJgYHSEXKstud3bh7Kw@mail.gmail.com>
References: <CAKohponCrC93D88Fgg_3LKsLG0KMeCVKsTEoy-N3jsdUQdgWvA@mail.gmail.com>
	<20130625161935.GA10208@jshin-Toonie>
	<CAKohpomSa0FRviZHkkJOeUUxubbzueVb3yyP5G8ASwpRB6wANQ@mail.gmail.com>
	<20130626142852.GA2326@jshin-Toonie>
	<CAKohpom_jHQeR2FKFS3-RkxpPrJvekw8pDb-qnApnzu-VqreBQ@mail.gmail.com>
	<20130626175722.GA20226@jshin-Toonie>
	<CAKohpo=UTmpLmyQs5+xLNnCLMCeZHNQT3USjmK1NTaFJLNQg-Q@mail.gmail.com>
	<20130627145505.GA3076@jshin-Toonie>
	<CAKohpomSNGn1wTzbCxpHN5fu2L6mJ1fnhvt2uLBWLgQE8fS6Rg@mail.gmail.com>
	<CAKohpokQcL0iq6Oyt3zLGGTh4k_PoCpCzHFrgqWUmpUA3-2O3w@mail.gmail.com>
	<20130627162203.GB5324@jshin-Toonie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130627162203.GB5324@jshin-Toonie>
Sender: cpufreq-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: Tim Gardner <tim.gardner@canonical.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27 June 2013 21:52, Jacob Shin <jacob.shin@amd.com> wrote:
> From 133f670aa1dc450fd37ba39081d046bf238c507b Mon Sep 17 00:00:00 2001
> From: Jacob Shin <jacob.shin@amd.com>
> Date: Thu, 27 Jun 2013 10:44:42 -0500
> Subject: [PATCH 1/1] cpufreq: don't leave stale policy pointer in
>  cdbs->cur_policy
>
> Set ->cur_policy to NULL when stopping a governor. Otherwise, the
> ->cur_policy pointer may be stale on systems that
> have_governor_per_policy when a new policy is allocated due to CPU
> hotplug offline/online.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Jacob Shin <jacob.shin@amd.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
