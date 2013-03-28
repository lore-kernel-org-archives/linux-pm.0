From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: intel_pstate_timer_func divide by zero oops
Date: Thu, 28 Mar 2013 08:35:53 -0700
Message-ID: <51546359.8000002@gmail.com>
References: <alpine.LFD.2.03.1303272103380.8412@gmail.com> <5153B03E.2050201@gmail.com> <CAOULuOa1O5LxwDh6peSGBRR9PyeEtXuhyiaFVvKnFNiqrb4bfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOULuOa1O5LxwDh6peSGBRR9PyeEtXuhyiaFVvKnFNiqrb4bfQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 03/27/2013 08:13 PM, Parag Warudkar wrote:
> On Wed, Mar 27, 2013 at 10:51 PM, Dirk Brandewie
> <dirk.brandewie@gmail.com> wrote:
>>
>> Is there any way to capture the beginning of this trace?
>
> I tried but since the oops scrolls fast followed by a hard freeze, I
> wasn't able to capture it completely.
> May be I can try netconsole and see if that helps.
>
>>
>> pid_param_set() is on the stack which means that something is changing
>> the debugfs parameters or the stack is FUBAR.
>>
> I somehow doubt the stack is messed up as the call traces are always identical.
> (pid_param_set() seems to be in first trace as well.)
>

I agree that the two oops are likely the same but unless something is crawling
through debugfs writing random values to the files there pid_param_set()
should not be on any stack anywhere.

There was a similar bug reported by fedora:
https://bugzilla.redhat.com/show_bug.cgi?id=920289

This bug has not showed up again since rc3 can you try the current rc to see if
you still see the problem?

>>
>> I don't see how duration_us can be zero unless somehow I am getting
>> back-to-back
>> timer callbacks which seems unlikely since the timer is not re-armed until
>> the timer function is about to return and the driver has done all its work
>> for the sample period
>
> Do the two oops with common call stack suggest back to back callbacks?
>
> I will add some debugging checks tomorrow to see what is going on. But
> sounds like a minimal fix would be to guard against callbacks in quick
> succession?
> i.e. return from sample if ktime_us_delta(now, cpu->prev_sample) is zero?
>
> Thanks,
> Parag
>

