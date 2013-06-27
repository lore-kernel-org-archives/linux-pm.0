From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2 V3] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Thu, 27 Jun 2013 16:20:44 +0800
Message-ID: <51CBF5DC.5020806@intel.com>
References: <1372316934-27225-1-git-send-email-tianyu.lan@intel.com> <CAKohponGDfjP6bFtXohb=h+_csmT49UJ=Dko_e4mUrkDBVN02g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56361 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab3F0I1s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Jun 2013 04:27:48 -0400
In-Reply-To: <CAKohponGDfjP6bFtXohb=h+_csmT49UJ=Dko_e4mUrkDBVN02g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8827=E6=97=A5 16:25, Viresh Kumar wrote:
> On 27 June 2013 12:38, Lan Tianyu <tianyu.lan@intel.com> wrote:
>> Commit aa77a52 and fcf8058 changes the content of "related_cpus" and=
 user
>> space can't get cpus which are in the same hardware coordination cpu=
 domain
>> (These info are provided by ACPI AML method _PSD) via "related_cpus"=
=2E This
>> change affects some users of original "related_cpus".
>>
>> This patch is to add a new sysfs attribute "freqdomian_cpus" for acp=
i-cpufreq
>> driver which exposes all cpus in the same domain regardless of hardw=
are or
>> software coordination to make up the info loss of previous change.
>>
>> Reference:https://bugzilla.kernel.org/show_bug.cgi?id=3D58761
>> Reported-by: Jean-Philippe Halimi <jean-philippe.halimi@exascale-com=
puting.eu>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20

Thanks.

--=20
Best regards
Tianyu Lan
