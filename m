From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 7/7] Documentation:cpufreq:boost: Update BOOST documentation
Date: Tue, 16 Jul 2013 15:31:43 +0530
Message-ID: <CAKohpo=oB_4gGtNn6jvxSCp665pOq6oqeTCCyGzmN_eWqt0Lhg@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-8-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1372927830-2949-8-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> -Reading the file is always supported, even if the processor does not
> -support boosting. In this case the file will be read-only and always
> -reads as "0". Explicitly changing the permissions and writing to that
> -file anyway will return EINVAL.
> +The file is exported only when cpufreq driver supports boosting.
> +Explicitly changing the permissions and writing to that file anyway will
> +return EINVAL.

For acpi-cpufreq reading the file should be always supported. And this
must be mentioned in doc.
