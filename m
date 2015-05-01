From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/2 linux-next] cpufreq: pxa: replace typedef
 pxa_freqs_t by structure
Date: Fri, 1 May 2015 20:31:19 +0530
Message-ID: <CAKohpo=tgE95M-DeNub0z-ZBqW3vi_4nMzBtyDXKh13AJP9NbA@mail.gmail.com>
References: <1430469241-30556-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430469241-30556-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 May 2015 at 14:04, Fabian Frederick <fabf@skynet.be> wrote:
> typedef is not really useful here. Replace it by structure
> to improve readability. typedef should only be used in some cases.
> (See Documentation/CodingStyle Chapter 5 for details).
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> Compiled but untested.
>
> V3: -constify arrays(patch 2) (suggested by Joe Perches)
>     -fix typo in changelog (thanks to Viresh Kumar)
> V2: -verbose changelog.
>
>  drivers/cpufreq/pxa2xx-cpufreq.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

For both patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
