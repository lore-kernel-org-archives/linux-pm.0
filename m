From: =?ISO-8859-1?Q?Fran=E7ois?= Boisson
	<user.anti-spam@maison.homelinux.net>
Subject: Re: battery drains after shutdown
Date: Mon, 23 Feb 2015 16:22:40 +0100
Message-ID: <20150223162240.d3b9c917752268fbcf4945c2@maison.homelinux.net>
References: <1423899504.11560.128.camel@rzhang1-mobl4>
	<72477.bryanh@giraffe-data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fbsmtp.dnsalias.org ([82.66.248.156]:47232 "EHLO
	fbsmtp.dnsalias.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbBWP2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 10:28:15 -0500
In-Reply-To: <72477.bryanh@giraffe-data.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bryan Henderson <bryanh@giraffe-data.com>
Cc: rui.zhang@intel.com, user.anti-spam@maison.homelinux.net, linux-pm@vger.kernel.org

Le 15 Feb 2015 23:36:02 +0000
Bryan Henderson <bryanh@giraffe-data.com> a =E9crit:

> I've heard of setting the clock disabling the wakeup, but not setting=
 the
> clock enabling wakeup.  I think you can determine whether this is hap=
pening,
> though, by looking at /proc/driver/rtc contents before and after a
> hwclock --systohc.

root@portos:/home/francois# cat /proc/driver/rtc=20
rtc_time	: 15:17:47
rtc_date	: 2015-02-23
alrm_time	: 17:00:32
alrm_date	: 2015-02-23
alarm_IRQ	: no
alrm_pending	: no
update IRQ enabled	: no
periodic IRQ enabled	: no
periodic IRQ frequency	: 1024
max user IRQ frequency	: 64
24hr		: yes
periodic_IRQ	: no
update_IRQ	: no
HPET_emulated	: yes
BCD		: yes
DST_enable	: no
periodic_freq	: 1024
batt_status	: okay
root@portos:/home/francois# hwclock --systohc
root@portos:/home/francois# cat /proc/driver/rtc=20
rtc_time	: 15:17:29
rtc_date	: 2015-02-23
alrm_time	: 17:00:32
alrm_date	: 2015-02-23
alarm_IRQ	: no
alrm_pending	: no
update IRQ enabled	: no
periodic IRQ enabled	: no
periodic IRQ frequency	: 1024
max user IRQ frequency	: 64
24hr		: yes
periodic_IRQ	: no
update_IRQ	: no
HPET_emulated	: yes
BCD		: yes
DST_enable	: no
periodic_freq	: 1024
batt_status	: okay
root@portos:/home/francois#=20

except the change in the rtc_time, nothing else.
I check acpitool -e, but no change.=20


=46ran=E7ois Boisson
