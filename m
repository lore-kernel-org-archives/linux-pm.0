From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 Resend 0/2] CPUFreq Cleanup Part IV
Date: Wed, 30 Oct 2013 22:53:51 +0100
Message-ID: <3389791.QB3z2L4pXG@vostro.rjw.lan>
References: <cover.1383052613.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1383052613.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 29, 2013 06:56:05 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> Thanks for applying all earlier patches for v3.13. There are only few left after
> this patchset, i.e. only set with these changes: "create cpufreq_generic_get()
> routine"..
> 
> This patchset moves cpufreq-notifications to core and make ->target_index()
> routines really light weight and gets rid of a lot of redundant code.
> 
> It is already reviewed/Acked/Tested by few people and so should be stable
> enough.
> 
> See if you can still get these for 3.13..
> 
> Viresh Kumar (2):
>   cpufreq: distinguish drivers that do asynchronous notifications
>   cpufreq: move freq change notifications to cpufreq core

[2/2] doesn't apply for me cleanly on top of the big/little changes.

Care to rebase on top of the new bleeding-edge I've just pushed?

Rafael

