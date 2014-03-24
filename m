From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] thermal: Fix KELVIN_TO_CELSIUS macro
Date: Sun, 23 Mar 2014 21:25:32 -0700
Message-ID: <1395635132.13968.40.camel@joe-AO722>
References: <1395634496-25040-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395634496-25040-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 2014-03-23 at 21:14 -0700, Guenter Roeck wrote:
> It is always a good idea to use paranthesis around macro parameters
> to avoid undesired side effects.
> 
> In this specific case, KELVIN_TO_CELSIUS() is used in
> drivers/platform/x86/asus-wmi.c with parameter "value & 0xFFFF",
> which due to operator evaluation order causes more or less random
> results.

Maybe it's better to use a statement expression to avoid
multiple calculations of t

Maybe;

#define KELVIN_TO_CELSIUS(t)				\
({							\
	long _t = (long)(t) - 2732;			\
	_t >= 0 ? (_t + 5) / 10 : (_t - 5) / 10;	\
})
