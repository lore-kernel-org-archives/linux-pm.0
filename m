From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: suspend/resume governors with PM notifiers
Date: Mon, 18 Nov 2013 16:31:58 +0530
Message-ID: <CAKohpo=UjSqzE+Jg0s3taykHu4VinNUvLLhRm6pUXiyUc5F-3w@mail.gmail.com>
References: <0e476d16e0ae4b001f5dd4f9ac191f899095928a.1384510171.git.viresh.kumar@linaro.org>
	<5974906.WAPp3f3eVY@vostro.rjw.lan>
	<CAKohpo=PoAaYgLNEVkkTC6tzAH=5hKw4VWTsrjt2jQnr7+6Q_w@mail.gmail.com>
	<5229929.5JRiWnF6CT@vostro.rjw.lan>
	<5289A80B.7080808@linaro.org>
	<5289F29B.8050806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5289F29B.8050806@intel.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 18 November 2013 16:27, Lan Tianyu <tianyu.lan@intel.com> wrote:
> How about introducing a resume/suspend callback pointer or list(if there
> are several places that need to deal with cpu resume/suspend) in the
> struct cpu and populate it in the cpufreq_add_dev()?
>
> The suspend/resume() of cpu_subsys needs to check the callback pointer
> and run it if available.

That's almost a new infrastructure then and looks more hackish :)
Apart from that even cpufreq would be a bit hacky as we don't really need
per-cpu callbacks..
