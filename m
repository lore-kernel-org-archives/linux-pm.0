From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: set value of CPUFREQ_BOOST_FREQ to 0xABABABAB
Date: Fri, 28 Mar 2014 14:25:04 +0530
Message-ID: <CAKohponR2YZJYAeCMCpXaQ7oztGdgiG8PKNvt9sgvKQM3VCD9g@mail.gmail.com>
References: <78187ea173460c871eef31432ec2a80ec657fe30.1395643393.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <78187ea173460c871eef31432ec2a80ec657fe30.1395643393.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 24 March 2014 12:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Ideally, .driver_data field of struct cpufreq_frequency_table must not be used
> by core at all. But during a recent change if its value is same as
> CPUFREQ_BOOST_FREQ macro, then it is treated specially by core.
>
> The value of this macro was set to ~2 earlier, i.e. 0xFFFFFFFD. In case some
> driver is using this field for its own data and sets this field to -3, then with
> two's complement that value will also become 0xFFFFFFFD.
>
> To fix this issue, lets change value of this flag to a very uncommon value which
> shouldn't be used by any driver unless they want to use BOOST feature.
>
> Along with this update comments to make this more clear.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Please discard this patch now as I have sent a replacement patch.
