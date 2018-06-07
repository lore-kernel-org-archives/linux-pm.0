From: Ravi Chandra Sadineni <ravisadineni@google.com>
Subject: Re: [PATCH] power: Print wakeup_count instead of event_count in the
 sysfs attribute.
Date: Thu, 7 Jun 2018 09:47:24 -0700
Message-ID: <CAOGSYL3ZHZ2Desafp5bmyEnfUW6xdu3CAhKu2=P7X_omb8Cavw@mail.gmail.com>
References: <20180602023215.176521-1-ravisadineni@chromium.org>
 <CAJZ5v0gWeq034sObmHsbJoiBri4a=Av8xroeuW+eqyv_W=cHjQ@mail.gmail.com> <CAOGSYL0ga-H=0a5EEDmOWSZjnmG1Qc=9AxAbM_-ifHDj_FbREg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOGSYL0ga-H=0a5EEDmOWSZjnmG1Qc=9AxAbM_-ifHDj_FbREg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, chenhong3@huawei.com, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor@google.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Todd Broch <tbroch@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rajat Jain <rajatja@google.com>, Benson Leung <bleung@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafeal,

Soft ping. Is this patch good to be merged ?

Thanks,
Ravi


On Sun, Jun 3, 2018 at 10:14 AM, Ravi Chandra Sadineni
<ravisadineni@google.com> wrote:
> Hi Rafael,
>
> On Sun, Jun 3, 2018 at 1:05 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sat, Jun 2, 2018 at 4:32 AM, Ravi Chandra Sadineni
>> <ravisadineni@chromium.org> wrote:
>>> Currently we show event_count instead of wakeup_count as part of per
>>> device wakeup_count sysfs attribute. Change it to wakeup_count to make
>>> it more meaningful.
>>
>> More information, please.
>>
>> In particular, why it is more meaningful.
> Wakeup_count increments only when events_check_enabled is set. This
> bool is set whenever we write current wakeup count to
> /sys/power/wakeup_count from the user land. Also events_check_enabled
> is cleared on every resume. My understanding is that, userland is
> expected to write to this just before suspend. This way
> pm_wakeup_event() when called from irqs will increment the
> wakeup_count only if we are in system wide suspend resume cycle and
> should give a fair approximation of how many times a device might have
> caused a wake from S3/S0iX.  event_count on the other hand will
> increment every time pm_wakeup_event() is called irrespective of
> whether we are in a suspend/resume cycle.  For example when I try
> doing something like this (https://lkml.org/lkml/2018/6/1/890), we see
> the wakeup_count sysfs attribute for the particular device
> incrementing every time there is a irq. If it is important to expose
> event_count via sysfs attribute, should we create another attribute ?
> Also we do expose each of these counters via
> debugfs(/sys/kernel/debug/wake_sources).
>
> Please correct me if I am wrong or missing something. Also if there is
> a better way to do this, please let me know.
>>
>> Thanks,
>> Rafael
