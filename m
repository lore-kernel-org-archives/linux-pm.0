From: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Wed, 21 Nov 2012 10:56:36 +0900
Message-ID: <4316169.5QXVzv7peZ@percival>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com> <1353149747-31871-2-git-send-email-acourbot@nvidia.com> <50AB9832.90709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50AB9832.90709-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomi,

On Tuesday 20 November 2012 22:48:18 Tomi Valkeinen wrote:
> I guess there's a reason, but the above looks a bit inconsistent. For
> gpio you define the gpio resource inside the step. For power and pwm the
> resource is defined before the steps. Why wouldn't "pwm = <&pwm 2
> 5000000>;" work in step2?

That's mostly a framework issue. Most frameworks do not export a function that 
allow to dereference a phandle - they expect resources to be declared right 
under the device node and accessed by name through foo_get(device, name). So 
using phandles in power sequences would require to export these additional 
functions and also opens the door to some inconsistencies - for instance, your 
PWM phandle could be referenced a second time in the sequence with a different 
period - how do you know that these are actually referring the same PWM 
device?

> > +When a power sequence is run, its steps is executed one after the other
> > until +one step fails or the end of the sequence is reached.
> 
> The document doesn't give any hint of what the driver should do if
> running the power sequence fails. Run the "opposite" power sequence?
> Will that work for all resources? I'm mainly thinking of a case where
> each enable of the resource should be matched by a disable, i.e. you
> can't call disable if no enable was called.

We discussed that issue already (around v5 I think) and the conclusion was 
that it should be up to the driver. When we simply enable/disable resources it 
is easy to revert, but in the future non-boolean properties will likely be 
introduced, and these cannot easily be reverted. Moreover some drivers might 
have more complex recovery needs. This deserves more discussion I think, as 
I'd like to have some "generic" recovery mechanism that covers most of the 
cases.

Alex.
