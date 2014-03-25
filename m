From: Vinson Lee <vlee@twopensource.com>
Subject: [stable request <=3.7] acpi-cpufreq: set current frequency based on target P-State
Date: Tue, 25 Mar 2014 15:04:16 -0700
Message-ID: <1395785057-28903-1-git-send-email-vlee@twopensource.com>
References: <20131220081912.GA13684@hobo.Home>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131220081912.GA13684@hobo.Home>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Ross Lagerwall <rosslagerwall@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vinson Lee <vlee@twopensource.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Please backport upstream commit 8673b83bf2f013379453b4779047bf3c6ae387e4 
"acpi-cpufreq: set current frequency based on target P-State" to stable 
kernels 3.7 and earlier. This patch enables the kernel to control 
P-states on several platforms. Without this patch, the kernel was unable 
to control P-states on the same platforms.

The upstream patch cleanly applies to 3.7.

A backported patch is needed with the removal of SYSTEM_AMD_MSR_CAPABLE 
for kernels 3.6 and earlier.

Cheers,
Vinson


Ross Lagerwall (1):
  acpi-cpufreq: set current frequency based on target P-State

 drivers/cpufreq/acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.2
