From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] drivers: cpufreq: kirkwood: fix coccicheck warnings
Date: Fri, 22 Mar 2013 08:14:03 +0530
Message-ID: <CAOh2x=kh7C-5S0KYy7OQRhoZRzk6rgSPBYcVjd9RN5ck41Mx4w@mail.gmail.com>
References: <1363911022-7786-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363911022-7786-1-git-send-email-silviupopescu1990@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: cpufreq@vger.kernel.org, rjw@sisk.pl, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2013 at 5:40 AM, Silviu-Mihai Popescu
<silviupopescu1990@gmail.com> wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
>
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
>
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>  drivers/cpufreq/kirkwood-cpufreq.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
