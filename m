From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Mon, 7 Sep 2015 07:03:16 -0700
Message-ID: <000201d0e975$f2ce82d0$d86b8870$@net>
References: <001401d0e691$302127b0$90637710$@net> <000f01d0e783$6fe75cf0$4fb616d0$@net> <001601d0e7af$01a22140$04e663c0$@net> <15201917.ny03gYuJf6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta12.telus.net ([209.171.16.85]:59638 "EHLO cmta12.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbbIGODW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Sep 2015 10:03:22 -0400
In-Reply-To: <15201917.ny03gYuJf6@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

To wrap this up, I was thinking to file a bug report
on the pm-utils bug system and then to file a bug against
the distribution that I use (Ubuntu Server), linking to the
upstream bug report.

I don't have it working correctly yet, but I was hoping
to suggest a fix with the bug reports.

Something like (still has all my debug stuff also):

hibernate_cpufreq()
{
        ( cd /sys/devices/system/cpu/
        for x in cpu[0-9]*; do
                # if cpufreq is a symlink, it is handled by another cpu. Skip.
                [ -L "$x/cpufreq" ] && continue
                gov="$x/cpufreq/scaling_governor"
                # if we do not have a scaling_governor file, skip.
                [ -f "$gov" ] || continue
                echo "before $x online check"

+               # if the CPU is offline, skip, unless no file, i.e. CPU0.
+               [ $(cat "$x/online") = "1" -o ! -f "$x/online" ] || continue
Or
+               if [ $(cat "$x/online") = "1" ] || [ ! -f "$x/online" ]; then
+                       continue;
+                fi
Or something similar that actually works.

                echo "after $x online check"
                # if our temporary governor is not available, skip.
                grep -q "$TEMPORARY_CPUFREQ_GOVERNOR" \
                        "$x/cpufreq/scaling_available_governors" || continue
                savestate "${x}_governor" < "$gov"
                echo "$x"
                echo "$TEMPORARY_CPUFREQ_GOVERNOR"
                echo "$gov"
                echo "$TEMPORARY_CPUFREQ_GOVERNOR" > "$gov"
        done )
}

With the proposed fix not dependent on CPU0 at all, just the condition that if
the file exists, that the CPU be online, and if it doesn't exist then assume the
CPU is online. As you both pointed out, there is a previous check and skip for
the no governor or no CPU condition or older kernel conditions.


