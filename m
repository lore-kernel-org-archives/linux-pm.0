From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v6 6/9] thermal: cpu_cooling: implement the power
 cooling device API
Date: Tue, 9 Dec 2014 16:06:46 +0530
Message-ID: <CAKohpokBVH2gnqBrDffPMcsYx6BNKFvMWkNM4D3DzU8nxb=-xw@mail.gmail.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
	<1417806260-9264-7-git-send-email-javi.merino@arm.com>
	<CAOh2x==BKyS08th2d4r0Q2UGqhzAwj6sqOgFsH6J0pWup+OU_A@mail.gmail.com>
	<20141208125033.GB2980@e104805>
	<CAKohpokM_8Qm5YH0Xb=n95bP94Qreqpcd1fAyCD2W5u9Pd=ndg@mail.gmail.com>
	<20141208142217.GA1831@e104805>
	<CAKohpomy7=v_qE3B_+hhwdUE8MCJkV7gzmPpUOb==t1BuZAnAA@mail.gmail.com>
	<20141209103249.GB2891@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141209103249.GB2891@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 9 December 2014 at 16:02, Javi Merino <javi.merino@arm.com> wrote:
> Sorry but I don't follow.  __cpufreq_cooling_register() is passed a
> clip_cpus mask, not a single cpu.  How do I get "the cpu for which
> __cpufreq_cooling_register() is called" if not by looping through all
> the cpus in the mask?

Yeah, its np that is passed instead of cpu number. So, that wouldn't
be usable. Also because of the limitations I explained earlier, it makes
sense to iterate over all clip_cpus and finding which one owns OPPs.

--
viresh
