From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Why are the file perns of /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
 much more rigide ?
Date: Tue, 1 Apr 2014 09:53:20 +0530
Message-ID: <CAOh2x=kSuDxpuBgHGwcRwykPthB1GZ_UVBvxe2s-M-nD7z3ciQ@mail.gmail.com>
References: <5339BF43.4060908@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:49576 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaDAEXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Apr 2014 00:23:21 -0400
In-Reply-To: <5339BF43.4060908@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, Apr 1, 2014 at 12:47 AM, Toralf F=F6rster <toralf.foerster@gmx.=
de> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> all other files in that directory are 644 , but that file has 400 ?
>
> Kernel is v3.14

https://bugzilla.kernel.org/show_bug.cgi?id=3D65611
