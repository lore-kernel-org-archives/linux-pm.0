From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: PM / Suspend: Print wall time at suspend entry and exit
Date: Tue, 6 Jun 2017 11:05:50 -0700
Message-ID: <e9c40b99-7fa7-71b2-5917-250d638a5162@android.com>
References: <20170605193157.59875-1-salyzyn@android.com>
 <CAJZ5v0iLFw68RxzkgyFF_WhxO-nzr0nWoZjq-uEEU6+UzMB7cQ@mail.gmail.com>
 <20170605211835.GB9035@amd>
 <5931f9cb-016f-4163-4908-6825cf84b9d3@android.com>
 <ca5fb419-386f-9e27-43c4-677be6f0ae4b@android.com>
 <20170605224011.GA26558@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170605224011.GA26558@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 06/05/2017 03:40 PM, Pavel Machek wrote:
>
> Nanoseconds do not really matter here, right?

useconds do matter (syscall takes about 1us). But no matter, since 
Suspended message is only available on platforms that support persistent 
clock, so in those case (more devices than I can count) the messages we 
add here are all we get since they do not have a requirement to be 
supported by the persistent clock.

> And userspace should not really be parsing kernel logs for time
> keeping, right?
Post-mortem, armed with user space logs in CLOCK_REALTIME (a choice that 
most want on Android Logging) and kernel logs, these messages are 
_invaluable_ in order to merge the kernel activities with user space. At 
runtime they help too, as there is some post-mortem activities on user 
space logging daemon startup.
> The devices you are talking about... is any of them running something
> close to mainline kernel, or is planned for merge? I'd like to get a
> phone that is supported by mainline...

Android on hikey development board is running 4.9 kernel + Android 
patches (this is one of 'em), I _expect_ ToT will work. As for _real_ 
phones, you have to take that up with the vendors making the chips.
> 									
> 									Pavel

-- Mark
