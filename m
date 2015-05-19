From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] PM / sleep: Make suspend-to-idle-specific code depend
 on CONFIG_SUSPEND
Date: Tue, 19 May 2015 16:36:29 +0200
Message-ID: <555B4A6D.1050001@linaro.org>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan> <2270439.0UMhzsTGM1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2270439.0UMhzsTGM1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 05/16/2015 01:38 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since idle_should_freeze() is defined to always return 'false'
> for CONFIG_SUSPEND unset, all of the code depending on it in
> cpuidle_idle_call() is not necessary in that case.
>
> Make that code depend on CONFIG_SUSPEND too to avoid building it
> when it is not going to be used.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
