From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 0/2] cpufreq: ondemand: Eliminate the deadband effect
Date: Sun, 13 Jul 2014 19:54:43 +0300
Message-ID: <53C2B9D3.6040500@semaphore.gr>
References: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr> <000001cf9de8$43925230$cab6f690$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:35984 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753903AbaGMQyt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Jul 2014 12:54:49 -0400
In-Reply-To: <000001cf9de8$43925230$cab6f690$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Doug,

On 12/07/2014 06:45 =CE=BC=CE=BC, Doug Smythies wrote:
>=20
> On 2014.07.30 10:00 Stratos Karafotis wrote:
>=20
>> This patchset changes slightly the calculation of target frequency t=
o
>> eliminate the deadband effect (explained in patch 2 changelog) that =
it
>> seems to slow down the CPU in low and medium loads.
>>
>> Patch 1 introduces a new relation (RELATION_C) for the next frequenc=
y
>> selection, which chooses the closest frequency to target.
>>
>> Patch 2 is the actual change to ondemand governor.
>=20
>> You may find graphs with the 'deadband' effect and benchmark results=
:
>> https://docs.google.com/spreadsheets/d/16kDBh5lyc6YvBnoS1hUa1t2O38z0=
xrWvaEj5XtJ8auw/edit#gid=3D2072493052
>=20
> I did the same benchmark tests before (without) and after (with) this=
 patch set on my i7-2600K system.
> I added the results, which are similar to Stratos', under a new "benc=
hmark" tab on the spreadsheet.

Thank you very much for your benchmarks!

Stratos
