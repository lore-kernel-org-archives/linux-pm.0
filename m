From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Allow userspace control of runtime disabling/enabling of
 driver probing
Date: Wed, 4 Jan 2017 00:34:04 +0100
Message-ID: <CAJZ5v0gwEh+rq=J-Jp2Usv42xiqKfLA4L0rZ0o9cANdnt3D7EQ@mail.gmail.com>
References: <20170103225831.GA113525@beast>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-5858-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: rjwysocki@gmail.com
In-Reply-To: <20170103225831.GA113525@beast>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@coreos.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Madalin Bucur <madalin.bucur@nxp.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Petr Tesarik <ptesarik@suse.com>, Linux PM <linux-pm@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 3, 2017 at 11:58 PM, Kees Cook <keescook@chromium.org> wrote:
> From: Matthew Garrett <mjg59@coreos.com>
>
> Various attacks are made possible due to the large attack surface of
> kernel drivers and the easy availability of hotpluggable hardware that can
> be programmed to mimic arbitrary devices. This allows attackers to find a
> single vulnerable driver and then produce a device that can exploit it by
> plugging into a hotpluggable bus (such as PCI or USB). This violates user
> assumptions about unattended systems being secure as long as the screen
> is locked.
>
> The kernel already has support for deferring driver binding in order
> to avoid problems over suspend/resume. By exposing this to userspace we
> can disable probing when the screen is locked and simply reenable it on
> unlock.
>
> This is not a complete solution - since this still permits device
> creation and simply blocks driver binding, it won't stop userspace
> drivers from attaching to devices and it won't protect against any kernel
> vulnerabilities in the core bus code. However, it should be sufficient to
> block attacks like Poisontap (https://samy.pl/poisontap/).

It also looks like this may be worked around by tricking the user to
unlock the screen while the malicious device is still attached to the
system.

If that really is the case, I wonder if it's worth the extra complexity.

Thanks,
Rafael
