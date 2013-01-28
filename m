From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [RFC PATCH 3/3] i915: ignore lid open event when resuming
Date: Mon, 28 Jan 2013 09:31:54 +0100
Message-ID: <CAKMK7uFWqtcnvkExz2_+0Vm+6pSREhRJ1szpHi2_CEmmHL6Nzg@mail.gmail.com>
References: <1359300060-2967-1-git-send-email-rui.zhang@intel.com>
	<1359300060-2967-3-git-send-email-rui.zhang@intel.com>
	<CAKMK7uF4u-3XFogzdQQCBqA2Q61D1s3PhVF7BOT90d88TkqT0g@mail.gmail.com>
	<1359340583.2249.14.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1359340583.2249.14.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, rjw@sisk.pl, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2013 at 3:36 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>> Given that this essentially requires users to manually set this module
>> option to make stuff work I don't like this.
>>
> sorry, I do not understand.
> this patch just disables modeset_on_lid during suspend.

Pardon me, the misunderstanding is on my side - I've mixed up
dev_priv->modeset_on_lid with the corresponding module option.

Is my understanding correct that only with the new SCI pm state this
can happen, since that still allows acpi events to be processed (and
so our lid_notifier being called?

>> I see a few possible options:
>> - plug the races between all the different parts - I've never really
>> understood why acpi sends us events before the resume code has
>> completed ... If that's indeed intentional, we could delay the
>> handling a bit until at least the i915 resume code completed.
>
> IMO, the real question is that, during a suspend/resume cycle, if we
> need to take care of the lid open event or not.
> To me, the answer is no, because when resuming from STR, i915 is not
> aware of such an event, and the i915 resume code works well, right?
> so I do not think it is a problem to ignore the lid event for another
> lightweight suspend state, which is introduced in Patch 1/3 in this
> series.
>
>> - Judging from the diff context you're not on the latest 3.8-rc
>> codebase - we've applied a few fixes to this lid hack recently. Please
>> retest on a kernel with
>>
> the patch is based on 3.8.0-rc3, which already includes the commit
> below.
> And yes, the problem still exists.

Ok, I think I see the issue now. But I suspect that we need some
additional locking to make this solid, since currently
dev_priv->modeset_on_lid updates can race with our lid notifier
handler. Let me think about this a bit more.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
