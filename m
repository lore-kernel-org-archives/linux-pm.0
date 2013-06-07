From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq:boost: Add support for software based CPU
 frequency boost
Date: Fri, 7 Jun 2013 20:14:09 +0530
Message-ID: <CAKohponWGBoRQjz3-YNs6iYHn9j5_wKzM94T-U6Du2DqvDEBug@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1370502472-7249-3-git-send-email-l.majewski@samsung.com>
	<CAKohpok3KTfSWDU6PdDd4_VW4Pp+6J80yn5cLrYr5RuBNH-agA@mail.gmail.com>
	<20130606134903.5f69b8fb@amdc308.digital.local>
	<CAKohpo=jCuLwhB+3pC0NLRBDmfPpGr=hRgxTT4rXzSwM4BndaQ@mail.gmail.com>
	<20130607152718.4b458087@amdc308.digital.local>
	<CAKohpok=+UiDQR+i3sJAKLc26f41=uexj1R7=OBUnjyvabAxhg@mail.gmail.com>
	<20130607163426.61e405aa@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130607163426.61e405aa@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 7 June 2013 20:04, Lukasz Majewski <l.majewski@samsung.com> wrote:
> After refactoring the code. I admit, that we shall embed the struct
> cpu_boost fields directly to the coufreq_driver. There is no point to
> create structure with 2 fields.

Great!! I will wait for your next version.
