From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Mon, 15 Jul 2013 14:13:49 +0530
Message-ID: <51E3B645.8070705@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <51E3B262.6030005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:49712 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3GOIr0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 04:47:26 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 15 Jul 2013 14:09:39 +0530
In-Reply-To: <51E3B262.6030005@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/15/2013 01:57 PM, Lan Tianyu wrote:
> On 2013=E5=B9=B407=E6=9C=8812=E6=97=A5 06:15, Srivatsa S. Bhat wrote:
>>
>> Hi,
>>
>> Commit a66b2e (cpufreq: Preserve sysfs files across suspend/resume) =
caused
>> some subtle regressions in the cpufreq subsystem during suspend/resu=
me.
>> This patchset is aimed at rectifying those problems, by fixing the r=
egression
>> as well as achieving the original goal of that commit in a proper wa=
y.
>>
>> Patch 1 reverts the above commit, and is CC'ed to stable.
>>
>> Patches 2 - 5 reorganize the code and have no functional impact, and=
 can go
>> in as general cleanups as well. This reorganization builds a base th=
at the
>> rest of the patches will make use of.
>>
>> Patch 6 and 7 add a mechanism to perform light-weight init/tear-down=
 of CPUs
>> in the cpufreq subsystem and finally patch 8 uses it to preserve sys=
fs files
>> across suspend/resume.
>>
>> All the patches apply on current mainline.
>>
>>
>> Robert, Durgadoss, it would be great if you could try it out and see=
 if it works
>> well for your usecase. I tested it locally and cpufreq related files=
 did retain
>> their permissions across suspend/resume. Let me know if it works fin=
e in your
>> setup too.
>>
>> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf to=
 know
>> whether their systems work fine after:
>> a. applying only the first commit (this is what gets backported to s=
table)
>> b. applying all the commits
>=20
> Hi, I tested this patchset on my machine and the issue in bug 59781 h=
as
> been resolved.
>=20
> Tested-by: Tianyu Lan <tianyu.lan@intel.com>
>=20

Awesome! Thanks a lot!

Regards,
Srivatsa S. Bhat

