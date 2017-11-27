From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.14 regression - hang on shutdown (VIA longhaul related?)
Date: Mon, 27 Nov 2017 17:21:48 +0100
Message-ID: <CAJZ5v0icc0=QgNdCBv65Gwe1svEUfR8eHZ6QGyzX_ArcbBYNMA@mail.gmail.com>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
 <CAJZ5v0h34pcz5Xpo-Yaj+Jnth7_GZ6G0gydAOR_hCPx-0h2-dw@mail.gmail.com>
 <alpine.LRH.2.21.1711271630290.27709@math.ut.ee> <alpine.LRH.2.21.1711271719260.27709@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.21.1711271719260.27709@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 27, 2017 at 4:19 PM, Meelis Roos <mroos@linux.ee> wrote:
>> > Please try to replace the 10000 in
>> > cpufreq_policy_transition_delay_us() with a greater number (say 20000
>> > or 50000) and see if that helps.
>>
>> With 50000 it has worked 4 reboots out of 4.
>
> With 20000, it also seems to work 3 out of 3 times.

OK, please test it a bit more just to be sure.  If 20000 is
sufficient, we can easily make this change.

Thanks,
Rafael
