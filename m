From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PM: Convert timers to use timer_setup()
Date: Mon, 16 Oct 2017 17:19:48 -0700
Message-ID: <CAGXu5j+S6WR_m0f5snY6NV0gt_OX7FCgi21d2uKYMYtoNMuuHw@mail.gmail.com>
References: <20171016232055.GA100369@beast> <da183173-0b50-9363-3880-cbb64812ecdf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <da183173-0b50-9363-3880-cbb64812ecdf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 16, 2017 at 4:53 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 10/17/2017 1:20 AM, Kees Cook wrote:
>>
>> In preparation for unconditionally passing the struct timer_list pointer
>> to
>> all timer callbacks, switch to using the new timer_setup() and
>> from_timer()
>> to pass the timer pointer explicitly. Removes test of .data field, since
>> that will be going away.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do you want this to be carried in the timers tree, or can you pick it up?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
