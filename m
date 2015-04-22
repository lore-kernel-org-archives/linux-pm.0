From: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: default value of power/wakeup
Date: Wed, 22 Apr 2015 19:46:25 +0800
Message-ID: <CAGnHSEkaEBeHdCGCGpLXtF3tKwT4Ck+7TZBpJoO5gNzvpNde4w@mail.gmail.com>
References: <CAGnHSEmFjAAAkfFTfgtM1yWXsSZBWraoc1mzQRR7v02FubpeWA@mail.gmail.com>
	<Pine.LNX.4.44L0.1504211126530.1518-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1504211126530.1518-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 21 April 2015 at 23:51, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> Anyway, you're suggesting that drivers should never override sysfs
> attribute values.  But there doesn't seem to be any other way to
> implement the kernel's policy that wakeup should be enabled by default
> for all keyboard devices.

I just doubt if there should be any of these kinds of kernel's policy,
especially for non-critical attributes like wakeup. Obviously now udev
is put to a very embarassed position (supposedly it should be the one
managing these policy, but now the fact is the kernel took its job
from it). Also, from the case of my two receivers, we can see that it
also causes unnecessary inconsistency to user experience.

To me it's more of "driver's policy" than the kernel's. If it's not
trying to make people with same hardware capibilities share the same
experience on the same attributes, what's the meaning of these
policies then? Yes of course there might be a (great) chance that it
might make (many) people with certain hardware feel happier, but
objectively does it mean anything? Not to mention that not everyone
likes the policy. (Can anyone even confirm that the majority likes
wakeup to be enabled for keyboards by default?)

IMHO it would be best that any general policies considered important
to be off-loaded to udev (as a udev rule?). Only when there's no
better way (like "communicate directly" with udev?) for the driver to
set necessary specific policies for itself, it goes back to this
not-so-good method.

>  After all, only the driver knows whether or not the device it manages is a keyboard.

I am not sure that I understand what does this mean practically to this issue.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
