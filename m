From: =?UTF-8?B?SsO2cmctVm9sa2VyIFBlZXR6?= <jvpeetz@web.de>
Subject: Re: Regression: USB mouse only recognized w/o commit "ACPI / PM:
 Always enable wakeup GPEs ..."
Date: Fri, 24 Oct 2014 09:03:04 +0200
Message-ID: <5449F9A8.2070602@web.de>
References: <54497F14.8080004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54497F14.8080004@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Rafael J. Wysocki wrote on 10/24/2014 00:39:> On 10/24/2014 12:20 AM,
J=C3=B6rg-Volker Peetz wrote:
>> Hi,
>
> Hi,
>
>> on an HP Pavilion dv7 notebook with stable kernel 3.17.1 a USB mouse=
 is only
>> recognized w/o commit f35cec255557d1037ff0d772edfd6e7b1e92cdc0 "ACPI=
 / PM:
>> Always enable wakeup GPES ...", config file attached.
>> Any idea?
>
> There is one known bug in this commit, which should be fixed by:
>
>
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit=
/?h=3Dlinux-next&id=3D67598a1d3140a66f57aa6bcb8d22c4c2b7e910f5
>
>
> If applying that doesn't help, please send a report to
> linux-acpi@vger.kernel.org (and you may CC linux-pm@vger.kernel.org t=
oo).
>
> Rafael

thank you very much, Rafael, the suggested fix helps indeed.

Regards,
jvp.
