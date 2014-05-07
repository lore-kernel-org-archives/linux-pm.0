From: Romain Francoise <romain@orebokech.com>
Subject: Re: Performance regression in v3.14
Date: Wed, 07 May 2014 10:36:51 +0200
Message-ID: <87tx92rnmk.fsf@kima.orebokech.com>
References: <20140506163559.GA5308@localhost>
	<CAKohpokYEvazxm0-JJXPzq-4OgLXmROfaCMcgHDZwugChOxtsQ@mail.gmail.com>
	<20140507073536.GA1973@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140507073536.GA1973@localhost> (Johan Hovold's message of
	"Wed, 7 May 2014 09:35:36 +0200")
Sender: cpufreq-owner@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Johan Hovold <jhovold@gmail.com> writes:

> So I guess that idle-active difference is normal for acpi-cpufreq and
> that the problem only arises in or with the intel_pstate driver.

I've also noticed some performance issues with intel_pstate in powersave
mode, in my case playing fullscreen video was very choppy. Switching to
the performance governor fixed things as well. Looking at turbostat, the
cores remain close to their minimal frequency pretty much all the time
in powersave.

Maybe 91a4cd4f3d8169d ("intel_pstate: Remove periodic P state boost")
which went in v3.14 is the culprit?

(I would also be curious to know what the driver authors recommend for
typical laptop usage, performance or powersave, since it defaults to
performance.)
