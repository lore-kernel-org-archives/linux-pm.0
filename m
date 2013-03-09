From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
Date: Sat, 9 Mar 2013 11:06:55 +0800
Message-ID: <CAKohpomVitj=mMmT3Z_QPgxzDyXkKN6xYReyJxO1Nc3ei=zCww@mail.gmail.com>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
	<Pine.LNX.4.64.1303072248560.20470@axis700.grange>
	<CAKohpo=-_uzTi6QR4MnXPd5yAZFTcw-3ZZL-TAVY+drV-bDjNw@mail.gmail.com>
	<Pine.LNX.4.64.1303080706310.24111@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1303080706310.24111@axis700.grange>
Sender: cpufreq-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, devicetree-discuss@lists.ozlabs.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On 8 March 2013 14:11, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Also in your driver you're doing
>
>                 cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>                 ...
>                 cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>
> So, theoretically you could install such notifiers to adjust CPU voltages
> (using regulators too). But adding regulator calls directly to the driver
> would make it consistent with cpufreq-cpu0.c.

Yes

>  so, if this doesn't violate
> any concepts, I think, it would be good to add those when suitable systems
> appear.

That's what i thought :)
