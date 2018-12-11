From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: *powersave* governor shown despite disabled in configuration
Date: Tue, 11 Dec 2018 07:51:53 +0100
Message-ID: <20181211065152.t2anuhy6t4n2zjrd@isilmar-4.linta.de>
References: <8786b234-eb4d-fb79-d6e0-e71f45ed3120@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8786b234-eb4d-fb79-d6e0-e71f45ed3120@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 04:30:05PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> With Linux 4.14.76, the scaling governor *powersave* is shown as
> being available despite being disabled in the configuration.

Which cpufreq driver do you use? Presumably intel_pstate? That driver
exposes internal policies / "governors" named "performance" and "powersave",
which are unrelated to CONFIG_CPU_FREQ_GOV_POWERSAVE.

Thanks,
	Dominik
