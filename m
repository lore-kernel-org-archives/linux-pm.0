From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
Date: Wed, 8 Oct 2014 03:36:41 +0400
Message-ID: <CAMo8BfLX_0-+dqXeGK=rCdopLp1xi=uLyQF0ZMzU4bqKuFumYg@mail.gmail.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
	<1412659726-29957-9-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, linux-pm@vger.kernel.org, Chris Zankel <chris@zankel.net>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 7, 2014 at 9:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> pm_power_off is defined for all architectures. Move it to common code.

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

> Have all architectures call do_kernel_poweroff instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_poweroff from machine_power_off instead.

-- 
Thanks.
-- Max
