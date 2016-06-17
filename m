From: Mason <slash.tmp@free.fr>
Subject: Re: [RFC] Adding PM support to thermal driver
Date: Fri, 17 Jun 2016 13:11:54 +0200
Message-ID: <5763DAFA.6060008@free.fr>
References: <57617ED6.6050305@free.fr> <m2eg7ynmt3.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:61134 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbcFQLMN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 07:12:13 -0400
In-Reply-To: <m2eg7ynmt3.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Frias <sf84@laposte.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 15/06/2016 23:51, Kevin Hilman wrote:

> Mason writes:
> 
>> I need to support suspend-to-RAM in my platform.
>> This platform powers down on suspend, so the contents of device registers are lost.
>> Can you tell me if this patch looks OK for adding S2R support?
> 
> The idea looks right for ensuring a clean resume after context loss.

Thanks for your quick review.

> However, I'm a bit surprised to see an empty ->suspend hook though.
> Is there nothing to do to gracefully shutdown this hardware?  A quick
> glance suggests maybe CMD_OFF should be sent?

We discussed this internally. When Linux asks to be suspended to RAM,
the firmware cuts the power to the entire platform (except RAM obviously,
and a few blocks listening for wakeup events).

So it seems pointless to write code to power individual HW blocks down
that are about to be powered down globally.

(NB: the thermal block dissipates ~50 microwatts, so powering it down
ASAP saves only a negligible amount of energy.)

Regards.

