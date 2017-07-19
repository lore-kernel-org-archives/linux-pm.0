From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2 3/4] PM: Print wall time at suspend & hibernate entry
 and exit
Date: Wed, 19 Jul 2017 14:23:31 -0700
Message-ID: <507dec5d-3beb-4dd8-0d5f-90f22fccccd2@android.com>
References: <20170719194600.29210-1-salyzyn@android.com>
 <CAJZ5v0iVwUy5fdvYu=6HEwLPpw7g6owbFuwNpUJcb_iJ3LCFMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iVwUy5fdvYu=6HEwLPpw7g6owbFuwNpUJcb_iJ3LCFMA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/19/2017 01:40 PM, Rafael J. Wysocki wrote:
> On Wed, Jul 19, 2017 at 9:45 PM, Mark Salyzyn <salyzyn@android.com> wrote:
>> Permits power state and battery life diagnosis.
>>
>> Since one is not guaranteed to have a persistent hardware clock to
>> report Suspended for in milliseconds, we report at a higher level
>> at just the entry and exit points for suspend and hibernate.
>>
>> Feature activated by CONFIG_RTC_SHOW_TIME_*
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>
>> v2:
>> - merge suspend and hibernate into a single patch
> So now I guess you realize that this conflicts with
> https://patchwork.kernel.org/patch/9850217/ and it actually would make
> sense for it to go on top of that?
>
> Thanks,
> Rafael

I see. It would make sense to merge the concepts a bit since the prints 
are at the same locations.

Optimization idea: rtc_show_time() in my patch series should be able to 
support varargs, never be _disabled_ (CONFIG_RTC_SHOW_TIME_NONE idea is 
dropped) and the function would be a drop-in replacement for pr_info, 
but add the specified timestamp before the newline. Change it's name to 
pr_info_show_time() instead to reflect this adjustment.

I would also prefer that the base messages in patch/980217 be "PM: 
suspend entry" and "PM: suspend exit", only because I believe 1.6billion 
Linux devices would not need to be retooled, and besides these messages 
are shorter/sweeter.

Anyone disagree with some more over-engineering (pr_info_show_time() and 
varargs)

-- Mark
