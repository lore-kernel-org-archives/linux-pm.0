From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Can't enable/switch to 'schedutil' governor with kernel 4.7.2 ?
Date: Tue, 23 Aug 2016 14:23:40 -0700
Message-ID: <000f01d1fd84$9fd127d0$df737770$@net>
References: <1471969523.3010993.703762385.6A0277B5@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:53618 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756123AbcHWVZK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Aug 2016 17:25:10 -0400
In-Reply-To: <1471969523.3010993.703762385.6A0277B5@webmail.messagingengine.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lists@ssl-mail.com
Cc: linux-pm@vger.kernel.org

On 2016.08.23 09:25 lists@ssl-mail.com wrote:

> Can't enable/switch to 'schedutil' governor
> I'm running 
>	uname -rm
>		4.7.2-1.g34ba8d6-default x86_64
>
> I'm trying to set/use the 'schedutil' governor.

...[cut]...

Please try not using cpupower or any other utility.
Please try using the primitive commands directly.

For example:

To see what you are currently using:

cat /sys/devices/system/cpu/cpufreq/policy*/scaling_governor

To see what is available:

cat /sys/devices/system/cpu/cpufreq/policy*/scaling_available_governors

To set a new governor (as su):

for file in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor; do echo "schedutil" > $file; done

Then check by using the first command again.

Example from my computer with a stock kernel 4.8-rc3:

$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
ondemand
ondemand
ondemand
ondemand
ondemand
ondemand
ondemand
ondemand

$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_available_governors
ondemand performance
ondemand performance
ondemand performance
ondemand performance
ondemand performance
ondemand performance
ondemand performance
ondemand performance

In my case several of governors are modules and so do not
appear in the list, even though they actually are available.

$ sudo su
# for file in /sys/devices/system/cpu/cpufreq/policy*/scaling_governor; do echo "schedutil" > $file; done
# exit

$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
schedutil
schedutil
schedutil
schedutil
schedutil
schedutil
schedutil
schedutil

Since the schedutil module has now been loaded, it now appears in the list:

$ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_available_governors
schedutil ondemand performance
schedutil ondemand performance
schedutil ondemand performance
schedutil ondemand performance
schedutil ondemand performance
schedutil ondemand performance
schedutil ondemand performance
schedutil ondemand performance

... Doug


