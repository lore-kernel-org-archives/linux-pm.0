From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tegra: don't error target() when suspended
Date: Thu, 21 Nov 2013 09:14:28 +0530
Message-ID: <CAKohpomJiGbxk9BTJWcGRiid3TwV7d4i5BkSwSd8JxphSRZwUA@mail.gmail.com>
References: <1384981582-30697-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1384981582-30697-1-git-send-email-swarren@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 21 November 2013 02:36, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> d4019f0a92ab "cpufreq: move freq change notifications to cpufreq core"
> added code to the cpufreq core to print an error if a cpufreq driver's
> .target() function returned an error. This exposed the fact that Tegra's
> cpufreq driver returns an error when it is ignoring requests due to the
> system being suspended.
>
> Modify Tegra's .target() function not to return an error in this case;
> this prevents the error prints. The argument is that since the suspend
> hook can't and doesn't inform the cpufreq core when its requests will
> be ignored, there's no way for the cpufreq core to squelch them, so it's
> not an error for the requests to keep coming. This change make the Tegra
> driver consistent with how the Exynos handles the same situation. Note
> that s5pv210-cpufreq.c probably suffers from this same issue though.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks..

> ---
> This is a fix for 3.13.
>
> Commit d4019f0a92ab also failed to update the Tegra pm_notifier hook to
> emit cpufreq notifications. That hook calls the target() implementation
> directly, which used to emit the notifications. However, now that the
> notifications are made outside of target(), they no longer occur when
> target() is called directly. I'm not sure if this is an issue or not?

Hmm.. Yes and no.. Frequency after this point will not be in sync with
cpufreq core, but at the same time after resume cpufreq core will check
this out and get the correct frequency..
