From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/12] cpufreq: More governor code reorganization
Date: Thu, 18 Feb 2016 02:17:50 +0100
Message-ID: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series continues the governor code reorganization I've been doing
for the last couple of weeks.

Again, it doesn't change the way the code works fundamentally, but some
minor changes in behavior may be noticeable.

[1/12] closes a race condition for dbs_data updates.

[2/12] moves the io_is_busy tunable to struct dbs_data.

[3/12] adds a ->start callback for governors to initialize governor-specific
       stuff and avoid the ugly governor == GOV_SOMETHING checks in the common
       code.

[4/12] drops unnecessary things from struct dbs_governor (and related stuff).

[5/12] drops an unnecessary ondemand operation callback.

[6/12] fixes the way some governor tunable sysfs attributes update CPU load info.

[7/12] fixes the way in which powersave bias updates are handled in ondemand.

[8/12] moves some data items from per-CPU structures to per-policy ones.

[9/12] rearranges the per-CPU structures (moves them to the common code which
       is the only user of them now and drops several related things that
       aren't necessary any more).

[10/12] moves the definitions of "tuners" structures to governors.

[11/12] makes dbs_data_mutex static.

[12/12] reduces the dbs_data_mutex usage area and renames it.

Patches on top of the current linux-next branch of linux-pm.git, lightly tested
on Toshiba Portege R500 with the ACPI driver.

Thanks,
Rafael
