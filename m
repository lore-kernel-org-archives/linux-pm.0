From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Wed, 25 Feb 2015 17:10:14 +0100
Message-ID: <54EDF3E6.6040409@free-electrons.com>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com> <20150224183616.GD3448@developer.amazonguestwifi.org> <CAOjnSCaH5NtcYGdfQ+=XY9ZJtjYEEgLWKCGUeFXBsM1f+va-LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36149 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751068AbbBYQKW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 11:10:22 -0500
In-Reply-To: <CAOjnSCaH5NtcYGdfQ+=XY9ZJtjYEEgLWKCGUeFXBsM1f+va-LA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tyler Hall <tylerwhall@gmail.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

Hi Tyler, Eduardo,

On 24/02/2015 20:56, Tyler Hall wrote:
> Eduardo,
> 
> On Tue, Feb 24, 2015 at 1:36 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
>> The fix seams reasonable. Although, it remains the question what is
>> applicability to other Armada chips? Besides, shouldn't we simply use it
>> by default? Also, do you plan to send updates in the DTS files?
> 
> As far as I can tell, Armada 370 is already using the equivalent of
> this register I'd like to use in Armada XP. I'm not sure about the
> other mvebu platforms. I couldn't just change the device tree for XP
> to instantiate the 370 sensor, however, as they have different
> initialization routines. Possibly Eziquiel can comment on the
> significance of the differences between armadaxp_init_sensor() and
> armada370_init_sensor().
> 
> I would like to change the default going forward, but I don't think it
> can be changed on platforms using an older DTB.

Here you introduced a new kind of thermal sensor, at least from the point
of view of the device tree. You used a new compatible string associated to
a different register.

By using it by default do you mean removing marvell,armadaxp-thermal
and adding armadaxp-filtered-thermal instead ?

Does that new thermal sensors only improve the stability or does it
also modify the value?

In the second case it will more or less break the user space expectation.

> 
> I had planned to submit the dts change separately. It's not clear to
> me how that's supposed to be handled if they might go through
> different trees.

For this, there is no problem be handled in a different tree. At the end
we will need both the a new dts and a new driver to use it, so the fact that
the dts or the driver patch is merged in mainline first is not important.


Thanks,

Gregory


> 
> Thanks,
> Tyler
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
