From: Vinson Lee <vlee@twopensource.com>
Subject: [stable request <=3.5] acpi-cpufreq: set current frequency based on
 target P-State
Date: Thu, 19 Dec 2013 18:14:12 -0800
Message-ID: <CAHTgTXW_M6U6oCgek-K45O2PeS71RpjUyZeJ8f5C97odvk09MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Shatil Rafitullah <srafiullah@twopensource.com>, Len Brown <len.brown@intel.com>, Ross Lagerwall <rosslagerwall@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Is commit 8673b83bf2f013379453b4779047bf3c6ae387e4 "acpi-cpufreq: set
current frequency based on target P-State" applicable to kernels
before 3.8?

We found that this patch allows the kernel to control P-states on
3.4.74 on some platforms. However, other platforms were able to change
P-states even without this patch.

Cheers,
Vinson
