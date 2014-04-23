From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix checkpatch warnings
Date: Wed, 23 Apr 2014 16:53:36 +0300
Message-ID: <5357C5E0.1070207@semaphore.gr>
References: <5356DB92.1060600@semaphore.gr> <2606012.9SjvfKiI5Z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:53491 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756823AbaDWNxi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Apr 2014 09:53:38 -0400
In-Reply-To: <2606012.9SjvfKiI5Z@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 23/04/2014 01:37 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> On Wednesday, April 23, 2014 12:13:54 AM Stratos Karafotis wrote:
>> Fix the following checkpatch warnings:
>=20
> In addition to comments from Viresh, I have a general one.
>=20
> Some of the checkpatch.pl warnings are not worth fixing at all ->
>=20
>> - WARNING: Prefer pr_err(... to printk(KERN_ERR ...
>> - WARNING: Prefer pr_info(... to printk(KERN_INFO ...
>> - WARNING: Prefer pr_warn(... to printk(KERN_WARNING ...
>> - WARNING: quoted string split across lines
>> - WARNING: line over 80 characters
>=20
> -> and the "line over 80 characters" ones are outright wrong in many =
cases,
> so please don't "fix" them.
>=20

Hi Rafael,

Thanks for your comments!

Could you please clarify if you want me to drop the entire patch or
send it only with the changes about the last warning found ("no spaces
at the start of a line)?

Also, I would like to take the opportunity and ask a question. :)

Reading the code, sometimes, I find some minor formatting issues.
Like the checkpatch warnings or unnecessary parentheses and braces.

=46or example the line bellow:
		if ((freq < policy->min) || (freq > policy->max))

I know that this is not actually an issue and a patch with such changes
is (somehow) a noise for the maintainers. But, should it be "fixed" or =
not?

Thanks for your time,

Stratos


