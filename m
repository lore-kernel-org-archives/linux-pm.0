From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] cpufreq, longhaul: Fix double invocation of cpufreq_freq_transition_begin/end
Date: Fri, 25 Apr 2014 14:09:47 +0530
Message-ID: <535A1F53.5040806@linux.vnet.ibm.com>
References: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com> <20140425081804.10258.8324.stgit@srivatsabhat.in.ibm.com> <CAKohpo=0wppEthZzoRGTqurtt=135NWeVTKJ2y=mwy82+O7-zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=0wppEthZzoRGTqurtt=135NWeVTKJ2y=mwy82+O7-zQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Meelis Roos <mroos@linux.ee>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/25/2014 02:07 PM, Viresh Kumar wrote:
> On 25 April 2014 13:48, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> 
>> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> 
>> @@ -269,8 +269,6 @@ static void longhaul_setstate(struct cpufreq_policy *policy,
> 
> This routine has this code as well:
> 
> mult = mults[mults_index & 0x1f];
> if (mult == -1)
>         return;
> speed = calc_speed(mult);
> if ((speed > highest_speed) || (speed < lowest_speed))
>         return;
> 
> And so it might return without changing frequency and that's why I
> left this driver earlier for this change.. So, please return -EINVAL
> from here..
> 

Ok, I'll address this in the next version. Thanks for pointing
this out!

Regards,
Srivatsa S. Bhat
