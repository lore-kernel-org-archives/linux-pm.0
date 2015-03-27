From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [RFP] LPC thermal track
Date: Fri, 27 Mar 2015 11:47:45 +0000
Message-ID: <55154361.90302@arm.com>
References: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:63222 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566AbbC0LxK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 27 Mar 2015 07:53:10 -0400
In-Reply-To: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Javi Merino <Javi.Merino@arm.com>, "cyndis@lakka.kapsi.fi" <cyndis@lakka.kapsi.fi>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "wxt@rock-chips.com" <wxt@rock-chips.com>

Hi Eduardo,

Thanks for proposing a thermal micro-conference. It would be good to 
discuss the direction things are heading with regards to thermal in linux.

On 27/03/15 00:02, Eduardo Valentin wrote:
> Hello all,
>
> I've created a proposal for a thermal microconference track on the LPC
> 2015 [1]. The basic idea is to get thermal developers together and
> discuss the thermal role within the Linux environment, from kernel and
> userspace perspective.
>
> A initial proposal for the topics to be discussed are:
> . Closed loop control governors
> . Sensor API
> . Thermal class: split of temperature sensor device and thermal driver
> . Improvements on OF-thermal
> . Devfreq vs. clock cooling
> . Power model based policies
> . User space tools
> . User space governors
>
> If you have interest, or if you have ideas on how to improve the
> framework, reply to this email and add it to the wiki.
>

I'd like to propose -

. Co-ordination among cooling-devices in the system

In workloads that involve multiple devices such as camera+CPUs+image 
singal processor or camera+video encoding, etc. often there are 
dependencies across multiple devices' performance states to achieve 
minimum acceptable performance (24fps HD encode for example). When 
thermally constrained it would help to have some mechanisms to 
co-ordinate their performance control. The power allocator governor 
attempts to solve some of these problems but it would be good to have a 
wider discussion on enabling more scenarios.


> Add your name in the list of participants as well. Also, if you feel
> like giving a talk on the topic, let's add it to the topic list.
>

Done.

Cheers,
Punit

> Currently I am simple checking what would be the level of interest to
> have this topic as a LPC microconference.
>
> BR,
>
> Eduardo Valentin
>
>
> [1] - http://wiki.linuxplumbersconf.org/2015:thermal
>

