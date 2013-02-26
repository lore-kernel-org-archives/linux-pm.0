From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] time : pass broadcast device parameter
Date: Tue, 26 Feb 2013 14:15:33 +0530
Message-ID: <CAKohpomqooF6DzzzdUFByA0wDxQ3RuPne15a9Vy1sScKjZfeyA@mail.gmail.com>
References: <5123C299.3080005@linaro.org>
	<1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fweisbec@gmail.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22 February 2013 03:31, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> The broadcast timer could be passed as parameter to the function
> instead of using again tick_broadcast_device.evtdev which was
> previously used in the caller function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I know you are going for another round with this patchset and was just
trying v1.

I did my tests on ARM Vexpress - TC2, big.LITTLE Arch.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
