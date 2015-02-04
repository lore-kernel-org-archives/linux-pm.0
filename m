From: Oliver Neukum <oliver@neukum.org>
Subject: Re: selective wakeups
Date: Wed, 04 Feb 2015 10:05:16 +0100
Message-ID: <1423040716.19176.6.camel@linux-0dmf.site>
References: <54D09AC7.5080503@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:33678 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbbBDJUD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 04:20:03 -0500
In-Reply-To: <54D09AC7.5080503@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Derek Basehore <dbasehore@google.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Tue, 2015-02-03 at 10:54 +0100, Tomeu Vizoso wrote:
> I'm looking at how to support wakeup sources that resume a subset of
> the
> suspended devices. The goal is for the machine to be able to wakeup
> the
> CPU but not the display or sound card when the wakeup source isn't
> user-initiated, such as RTC or a network card (we can call it
> automatic
> resume).

Why the limitation? To stay in example, why wake the sound card
if you have no sound to play even if the user initiated the wake up?
Though in practice the problem with such attempts in the past was
that it is very hard, in fact almost impossible, to find out what
resumed a system. Secondly, you cannot assume that there's always
a single cause for resuming.

	Regards
		Oliver


