From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/8] cpufreq: Store cpufreq policies in a list
Date: Mon, 29 Jul 2013 12:33:43 +0530
Message-ID: <CAKohpomCHufjzatndpB0MEHn_jOREUZ5dcaQa0BegLAwOjP-1w@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-1-git-send-email-l.majewski@samsung.com>
	<1374770011-22171-2-git-send-email-l.majewski@samsung.com>
	<CAKohpoktwZUvs2ap7wk1tudVsiKjbhFkoM5=+AaFZP=+73fEyg@mail.gmail.com>
	<20130726125827.72f9ef18@amdc308.digital.local>
	<CAKohpokqHsHZP0AkPBbmGP=ekLPQrnLCc5j6BsfM6KY01uzG1w@mail.gmail.com>
	<20130726144612.5939419c@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130726144612.5939419c@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On 26 July 2013 18:16, Lukasz Majewski <l.majewski@samsung.com> wrote:
> So instead of reading policies from per_cpu variables for all online
> cpus, you think of using the list explicitly.
>
> Good idea, but can we first finish the boost patches? Such change can
> be applied on top of boost patch series as well.

Its not a problem where we do it. But making sure that we do it :)
If you need to resend this patchset, then that list can be used at the
place I just highlighted.. Change isn't big and so shouldn't be a problem.

Otherwise it might get missed by both of us.
