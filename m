From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH 2/2] PM: Fix Oops from NULL pointer dereference in
 wakeup_source_activate
Date: Thu, 21 Nov 2013 11:02:02 -0700
Message-ID: <528E4A9A.2060908@samsung.com>
References: <cover.1384990612.git.shuah.kh@samsung.com>
 <43b305b56bbbfc82b2684919e2d1ba2bd50fecae.1384990612.git.shuah.kh@samsung.com>
 <528D6972.9010702@samsung.com> <20131120212656.1df4515e@gandalf.local.home>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20131120212656.1df4515e@gandalf.local.home>
Sender: stable-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@rjwysocki.net, gregkh@linuxfoundation.org, anton@enomsg.org, dwmw2@infradead.org, fweisbec@gmail.com, mingo@redhat.com, keun-o.park@windriver.com, paul.gortmaker@windriver.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, stable@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 11/20/2013 07:26 PM, Steven Rostedt wrote:
> On Wed, 20 Nov 2013 19:01:22 -0700
> Shuah Khan <shuah.kh@samsung.com> wrote:
>
>> On 11/20/2013 06:40 PM, Shuah Khan wrote:
>
>>> ---
>>>    include/trace/events/power.h | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
>>> index cda100d..5ba545a 100644
>>> --- a/include/trace/events/power.h
>>> +++ b/include/trace/events/power.h
>>> @@ -110,12 +110,14 @@ DECLARE_EVENT_CLASS(wakeup_source,
>>>    	TP_ARGS(name, state),
>>>
>>>    	TP_STRUCT__entry(
>>> -		__string(       name,           name            )
>>> +		__string(name,  name ? name : "(no name)")
>>>    		__field(        u64,            state           )
>>>    	),
>>>
>>>    	TP_fast_assign(
>>> -		__assign_str(name, name);
>>> +		const char *tname = name ? name : "(no name)";
>>> +
>>> +		__assign_str(name, tname);
>>>    		__entry->state = state;
>>>    	),
>>>
>>>
>>
>> Adding tracing maintainers.
>
> Thanks!
>
> This is one solution, but what about just making the tracing facility a
> bit more robust for everyone. Following what glibc printf() does when
> it is passed a NULL, does this patch fix it too?
>

Why not? I am working to get the code compiling now. Will let you know 
if this works.

-- Shuah


-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
