From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
Date: Thu, 16 May 2019 08:07:54 -0700
Message-ID: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
References: <20190516044313.GA17751@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516044313.GA17751@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.

This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
support via external interrupt"), which added a timer to the pwm-fan
handling.

In particular, that timer now needed the same kind of cleanup changes,
and I'd like you guys (particularly Guenther, who was involved on both
sides) to double-check my merge.

The way I solved it was to just make the pwm_fan_pwm_disable()
callback do both the pwm_diable() _and_ the del_timer_sync() on the
new timer. That seemed to be the simplest solution that meshed with
the new devm cleanup model, but while I build-tested the result, I
obviously did no actual use testing. And maybe there's some reason why
that approach is flawed.

Guenther?

                    Linus
