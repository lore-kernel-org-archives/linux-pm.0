From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v3 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 07:52:03 -0700
Message-ID: <99742846-b47b-4ee5-c971-e26e8a5f935b@android.com>
References: <20170718221607.132539-1-salyzyn@android.com>
 <CALAqxLWK+_vnG_bpp4dPguNDTt1=JG6GANJm6b=V8gF1UGi1VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLWK+_vnG_bpp4dPguNDTt1=JG6GANJm6b=V8gF1UGi1VQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Mark Salyzyn <salyzyn@google.com>, Thierry Strudel <tstrudel@google.com>, Thomas Gleixner <tglx@linutronix.de>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 07/18/2017 05:00 PM, John Stultz wrote:
> On Tue, Jul 18, 2017 at 3:15 PM, Mark Salyzyn <salyzyn@android.com> wrote:
>> Go directly to the rtc for persistent wall clock time and print.
> So, first,  the above doesn't seem accurate to me. You're using
> getnstimeofday64() which doesn't touch the RTC.

I admit I got that backwards. I copied and pasted a line, that was 
supposed to read "We can not go" ... The point was that persistent or 
RTC clock is _not_ always available,
so we have to print suspend times when the timeofday clock is available 
at the points before suspend, and after suspend is complete.

The "Suspended for" message (in ms, we want us at least) albeit helpful, 
is performed at the bottom, and can only be reported if there is a 
persistent clock available. On most Android devices, it is not available.

I will post update, a better description in the primary patch, dropping 
the intro, printing in <epoch>.<ns> format. I asked in another thread if 
it would be OK to preserve the Legacy of RTC time format printing with 
another CONFIG parameter since we have 5 years of tooling that depends 
on that format.

-- Mark
