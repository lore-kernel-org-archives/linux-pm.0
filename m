From: Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] Allow userspace control of runtime disabling/enabling of
 driver probing
Date: Wed, 4 Jan 2017 12:31:45 -0600
Message-ID: <CAPeXnHue8hKFiMsddMTN7Hb5RWBGXWUgy2-kpXNLwBfOdf0QVA@mail.gmail.com>
References: <20170103225831.GA113525@beast> <20170104093236.GB31677@kroah.com> <CAPeXnHudW-YDmoK8NrFzQgAq4WuRDgFNC5-0GaG0+jVkq+3meQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPeXnHudW-YDmoK8NrFzQgAq4WuRDgFNC5-0GaG0+jVkq+3meQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Madalin Bucur <madalin.bucur@nxp.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Petr Tesarik <ptesarik@suse.com>, linux-pm@vger.kernel.org, kernel-hardening@lists.openwall.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 4, 2017 at 12:10 PM, Matthew Garrett <mjg59@coreos.com> wrote:
>
> The USB authentication feature was intended for handling wireless USB
> devices - it can be reused for this, but the code isn't generic enough
> to apply to other bus types. The two interact in exactly the way you'd
> expect, ie they don't. If you use both, then you need to handle both.

And as an example of why the USB authorisation feature isn't
sufficient - the interface configuration isn't picked until after
you've authorised the device, which means you can't necessarily tell
the difference between a keyboard and an ethernet adapter until after
you've authorised it. That defeats the object, but it can't be changed
without breaking the wireless USB case.
