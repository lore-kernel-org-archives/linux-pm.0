From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 15:42:53 +0200
Message-ID: <1412948573.13463.42.camel@x200t>
References: <5437E1BD.5020801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:53333 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752664AbaJJNnG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 09:43:06 -0400
In-Reply-To: <5437E1BD.5020801@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

crash+AF8-governor.sh:
+ACMAIQ-/bin/sh
+ACM this is called concurrently via runme.sh
for I in +AGA-seq 1000+AGA
do
        echo ondemand +AHw sudo
tee /sys/devices/system/cpu/cpu+ACo-/cpufreq/scaling+AF8-governor
        echo userspace +AHw sudo
tee /sys/devices/system/cpu/cpu+ACo-/cpufreq/scaling+AF8-governor
done

runme.sh:
+ACMAIQ-/bin/sh
+ACM run 8 concurrent instances
for I in +AGA-seq 8+AGA
do
        ./crash+AF8-governor.sh +ACY
done

Just run runme.sh and crash your system :)




Am Freitag, den 10.10.2014, 09:40 -0400 schrieb Prarit Bhargava:
+AD4 In v2 my system still crashes when concurrently setting the governors
+AD4 +AD4 I wasn't able to get a stack trace.
+AD4 +AD4 
+AD4 +AD4 Robert 
+AD4 +AD4 
+AD4 
+AD4 Send me your test script please.
+AD4 
+AD4 P.
+AD4 

