From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v4 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 14:30:29 -0700
Message-ID: <2b5d9884-fe61-a7a4-567c-01ae61d2fff4@android.com>
References: <20170719194511.28899-1-salyzyn@android.com>
 <20170719212241.kla3d3j6vgaxy4ba@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719212241.kla3d3j6vgaxy4ba@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, linux-rtc@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Richard Cochran <richardcochran@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 07/19/2017 02:22 PM, Alexandre Belloni wrote:
> Hi,
>
> On 19/07/2017 at 12:44:41 -0700, Mark Salyzyn wrote:
>> Primary purpose of rtc_show_time is to provide a marker used for
>> post-mortem Battery and Power analysis.  These markers occur at
>> major discontinuities of time, and thus optionally add a timestamp
>> to aid the analysis.  This function is to be called at a higher
>> level, and were added because of a lack of current kernel logging
>> data.
>>
> I really think you should drop rtc from the config, function and file
> names because this doesn't have any relationship with any RTC stuff.

Agreed and Thanks. In another response, this function has more in common 
with a pr_info_show_time() than I previously have accepted. Most of the 
rtc part goes away if I follow that thread/idea Leaving the following:
> I can just see that you are (ab)using rtc_time64_to_tm because there is
> no struct tm or gmtime() in the kernel.
Yes, since we put that part into a separate patch, that can be 
punted/accepted on its own, using rtc-lib is a simple concept. The 
commit message for that patch should have had your line of sentiment in 
it! (even (ab)using message :-) )

-- Mark
