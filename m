From: Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] Allow userspace control of runtime disabling/enabling of
 driver probing
Date: Wed, 4 Jan 2017 16:05:59 -0600
Message-ID: <CAPeXnHtKsaE_R_HFwoVRqeVRg70OGm8T=8ThbPQ8sLCVOhSddw@mail.gmail.com>
References: <20170103225831.GA113525@beast> <20170104093236.GB31677@kroah.com>
 <CAPeXnHudW-YDmoK8NrFzQgAq4WuRDgFNC5-0GaG0+jVkq+3meQ@mail.gmail.com>
 <CAPeXnHue8hKFiMsddMTN7Hb5RWBGXWUgy2-kpXNLwBfOdf0QVA@mail.gmail.com>
 <20170104194707.GD25268@kroah.com> <CAPeXnHs1=jCGtSgOO859bp2chMWBX1L6VaKn65RKoLaTbVq_0A@mail.gmail.com>
 <20170104204704.GA17642@kroah.com> <CAPeXnHsd_W4zKBDrn5jpLSi_VjzW+2O6znqs4zGeJhOt5USRYQ@mail.gmail.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-5880-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <CAPeXnHsd_W4zKBDrn5jpLSi_VjzW+2O6znqs4zGeJhOt5USRYQ@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Madalin Bucur <madalin.bucur@nxp.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Petr Tesarik <ptesarik@suse.com>, linux-pm@vger.kernel.org, kernel-hardening@lists.openwall.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 4, 2017 at 3:53 PM, Matthew Garrett <mjg59@coreos.com> wrote:
> usb_choose_configuration() hasn't been called at this point, so no -
> we don't create any device entries, so there's no way for userspace to
> know anything (there isn't even a uevent on device plug). And even if
> you could scrape the info, you still have no way of knowing what
> configuration the kernel will choose if the device has multiple.

Ah, I had things slightly misconfigured (accidentally deauthorised the
hub itself, so unsurprising that children wouldn't show up) - you do
get an event for the device itself, but you still have no means of
identifying how the endpoints will show up without parsing the binary
descriptors and then hoping that you have the same heuristics as the
kernel.
