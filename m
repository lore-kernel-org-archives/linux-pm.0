From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/4] PM / devfreq: Add function to set max/min frequency
Date: Sat, 4 Jul 2015 11:44:08 +0900
Message-ID: <CAJ0PZbQgW3hPuk-PXWqUrVfYhM1MWHDrRDOQE9vGxkS1Wb=AGQ@mail.gmail.com>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com> <1435928310-15938-2-git-send-email-javi.merino@arm.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37832 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbbGDCoX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 22:44:23 -0400
Received: by igblr2 with SMTP id lr2so85927929igb.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 19:44:23 -0700 (PDT)
In-Reply-To: <1435928310-15938-2-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Jul 3, 2015 at 9:58 PM, Javi Merino <javi.merino@arm.com> wrote=
:
> From: =C3=98rjan Eide <orjan.eide@arm.com>
>
> Factor out the logic to set minimum and maximum frequency for the dev=
ice
> so that it can be used by other parts of the kernel.
>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: =C3=98rjan Eide <orjan.eide@arm.com>

Dear Javi,



Is there reasons to name the function "devfreq_qos_set_[min|max]"? not
"devfreq_set_[min|max]"? The functions may be used by non-PM-qos
components as well (e.g., thermal).


And I like the idea of using devfreq devices as cooling devices. :)


Cheers,
MyungJoo.


ps. I will be on a trip starting hours later for 8 days and then in a
military training for 3 days. Please expect that my responses during
the next 11-12 days will be very slow.



--=20
MyungJoo Ham, Ph.D.
=46rontier CS Lab, S/W Center, Samsung Electronics
