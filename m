From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Wed, 10 Sep 2014 16:19:25 +0530
Message-ID: <CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 10 September 2014 15:11, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 138336b..fa35601 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -218,7 +218,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
>
>  struct cpufreq_driver {
>         char                    name[CPUFREQ_NAME_LEN];
> -       u8                      flags;
> +       unsigned int            flags;
>
>         /* needed by all drivers */
>         int     (*init)         (struct cpufreq_policy *policy);
> @@ -308,10 +308,13 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK        (1 << 5)
>
> +#define CPUFREQ_DRIVER_FLAGS_MASK (0xFFFF0000)

The flags field is used today to pass on information to cpufreq core and
I believe it better stays that way only. Also all these changes might later
be reverted and so we better don't change usage of variables..

Instead of this add a "void *driver_data" field in this structure and fill that
with your structure. This can be later used for other purposes as well..

Also this will just add few more bytes to the cpufreq-driver structure which
wouldn't have many instances in a compiled kernel, and so space isn't a
problem..

Otherwise things looked good to me in your complete series..
