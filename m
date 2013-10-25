From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 00/34] CPUFreq Cleanup Part III
Date: Fri, 25 Oct 2013 19:25:45 +0530
Message-ID: <CAKohpokJrj_ZbCPUw4ZpfOWgsDvqxLH9j41eQVC7V7Ny4xE8mA@mail.gmail.com>
References: <cover.1382104514.git.viresh.kumar@linaro.org>
	<14730355.7hm7UiW5IU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14730355.7hm7UiW5IU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25 October 2013 18:26, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Having considered that a bit I think that I'd prefer one patch doing all of
> these changes in one go (and with all applicable ACKs collected), one of the
> reasons being that if it is necessary to revert that stuff, whatever the
> reason, it will be much easier to do that with just one commit than with
> 34 of them.

With a similar reason I think the probability is more that a revert might
be required for individual drivers as they may need to switch back to
->target() instead of ->target_index() and so keeping them separate
might be better.

In case we need to revert all patches due to some breakage, we can
always do that in a single commit if required.

What do you say?
