From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Thu, 25 Feb 2016 08:57:00 +0530
Message-ID: <20160225032700.GA2822@vireshk-i7>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20151007172343.GE4557@linux>
 <4807388.hTIoZIhGRk@vostro.rjw.lan>
 <20151016054226.GQ19018@linux>
 <1456344052.8680.208.camel@linux.intel.com>
 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
 <1456357073.3860.21.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36091 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcBYD1Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2016 22:27:25 -0500
Received: by mail-pf0-f174.google.com with SMTP id e127so24613265pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2016 19:27:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456357073.3860.21.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 24-02-16, 15:37, Srinivas Pandruvada wrote:
> Good I tested again.
>=20
> Hi Viresh,
>=20
> Are we no longer allowed to call
> 	sysfs_create_file in cpufreq_driver.init() callback?
>=20
> The following call crashes because of BUG_ON for !kobj->sd:
> 	sysfs_create_file(&policy->kobj,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
(cpufreq_attr_base_frequency.attr));
>=20
> Before I debug further, I want to check with you.
> This used to work before.

Haven't checked that yet, but you should be using cpufreq_driver.attr f=
or this
kind of stuff, isn't it ?

--=20
viresh
