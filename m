From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Mon, 25 Jun 2018 11:44:16 +0200
Message-ID: <df526d9f-706c-3875-17c2-06c52fcf1ddf@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
 <fc2ef4e9-7ec8-c644-9495-e33f000531b2@linaro.org>
 <CAJZ5v0gBC_ZzUBJcNEmeAbDLrJA6K9SqohS0GXtUANKc4o+T_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gBC_ZzUBJcNEmeAbDLrJA6K9SqohS0GXtUANKc4o+T_g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25/06/2018 10:20, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Mon, Jun 25, 2018 at 12:40 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Hi Rafael,
>>
>> do you think this patch is acceptable for merging ?
> 
> Well, it needs a bit of work still IMO, but let me comment on the patch itself.
> 
> Also, can you point me to the code using it that you have, please?
> I'd like to try to switch powerclamp over to it.


Sure, here it is:

https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=thermal/idle-inject-v4




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
