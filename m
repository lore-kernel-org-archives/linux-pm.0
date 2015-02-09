From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: selective wakeups
Date: Mon, 09 Feb 2015 10:48:23 +0100
Message-ID: <54D88267.9060801@collabora.com>
References: <54D09AC7.5080503@collabora.com> <1423040716.19176.6.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39253 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760198AbbBIJs3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 04:48:29 -0500
In-Reply-To: <1423040716.19176.6.camel@linux-0dmf.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Derek Basehore <dbasehore@google.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On 02/04/2015 10:05 AM, Oliver Neukum wrote:
> On Tue, 2015-02-03 at 10:54 +0100, Tomeu Vizoso wrote:
>> I'm looking at how to support wakeup sources that resume a subset
>> of the suspended devices. The goal is for the machine to be able to
>> wakeup the CPU but not the display or sound card when the wakeup
>> source isn't user-initiated, such as RTC or a network card (we can
>> call it automatic resume).
> 
> Why the limitation? To stay in example, why wake the sound card if
> you have no sound to play even if the user initiated the wake up?

The point is to not wake it up if it isn't an user-initiated wake up. If
it is, the existing behaviour is fine.

> Though in practice the problem with such attempts in the past was 
> that it is very hard, in fact almost impossible, to find out what 
> resumed a system.

Yeah, I know it's not generally doable, but as Derek said, some HW
allows for it.

> Secondly, you cannot assume that there's always a single cause for
> resuming.

Are you thinking of the case in which the user opens the lid while we
are waking up because of a RTC alarm? Userspace would realize the lid is
open and would resume the screen.

Regards,

Tomeu

> Regards Oliver
> 
> 

