From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 1/5] ACPI / containers : add support for ACPI0010
 processor container
Date: Fri, 08 May 2015 16:32:33 +0100
Message-ID: <554CD711.3090903@arm.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com> <1430922690-6966-2-git-send-email-sudeep.holla@arm.com> <554C78C2.706@linaro.org> <2334052.J3vzukF2MM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53340 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbEHPcg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 May 2015 11:32:36 -0400
In-Reply-To: <2334052.J3vzukF2MM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ahs3@redhat.com" <ahs3@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>



On 08/05/15 15:06, Rafael J. Wysocki wrote:
> On Friday, May 08, 2015 04:50:10 PM Hanjun Guo wrote:
>> Hi Sudeep,
>>
>> On 2015=E5=B9=B405=E6=9C=8806=E6=97=A5 22:31, Sudeep Holla wrote:
>>> ACPI 6.0 adds support for optional processor container device which=
 may
>>> contain child objects that are either processor devices or other pr=
ocessor
>>> containers. This allows representing hierarchical processor topolog=
ies.
>>>
>>> It is declared using the _HID of ACPI0010. It may also have _CID of
>>> PNP0A05, which represents a generic container device.
>>
>> Container device helps support hotplug of nodes, CPUs, and memory,
>> does this container device ACPI0010 used for the same purpose?
>
> That's correct and the patch isn't.
>

Thanks Rafael for the clarification.

Just curious if the firmware adds _CID of PNP0A05 to support OS that
don't parse processor containers, will the current code not create
containers using _CID ?

Regards,
Sudeep
