From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: System suspend states and device driver suspend() callback
Date: Fri, 16 Aug 2013 12:57:57 +0200
Message-ID: <520E05B5.3050507@broadcom.com>
References: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:3169 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189Ab3HPK6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2013 06:58:11 -0400
In-Reply-To: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 08/16/2013 10:06 AM, Li Yang wrote:
> Hi Guys,
>
> Is there a standard way for the device drivers to know if the system
> is going to =E2=80=9Cstandby=E2=80=9D mode or =E2=80=9Cmem=E2=80=9D m=
ode when the suspend() callbacks
> are called?

what about implementing struct device_driver::suspend?

This is for driver level suspend operation, so not per-device.

> Regards,
>
> Leo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


