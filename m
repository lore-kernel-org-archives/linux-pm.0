From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Domains: Propagate start and restore errors during
 runtime resume
Date: Thu, 3 Mar 2016 21:34:04 +0100
Message-ID: <CAJZ5v0hL3ZF_bmyCePmM0RUsNpJF67NjFwLRUC5Y6Sjaf=evsw@mail.gmail.com>
References: <1456874438-26330-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<7h60x3wbrc.fsf@baylibre.com>
	<CAJZ5v0jLr0vbQHrpgEGs2N1VvusZ7nh4di39F8mKDoXmemL+oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35681 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcCCUeG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 15:34:06 -0500
In-Reply-To: <CAJZ5v0jLr0vbQHrpgEGs2N1VvusZ7nh4di39F8mKDoXmemL+oQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Mar 3, 2016 at 9:32 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Mar 3, 2016 at 9:24 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com> writes:
>>
>>> During runtime resume the return values of the start and restore steps
>>> are ignored. As a result drivers are not notified of runtime resume
>>> failures and can't propagate them up. Fix it by returning an error if
>>> either the start or restore step fails, and clean up properly in the
>>> error path.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>>  drivers/base/power/domain.c | 20 ++++++++++++++++++--
>>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> This fixes an issue I've noticed with my driver's .runtime_resume() handler
>>> returning an error that was never propagated out of pm_runtime_get_sync().
>>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>>
>>> A second issue then appeared. The device .runtime_error field is set to the
>>> error code returned by my .runtime_resume() handler, but it never reset. Any
>>> subsequent try to resume the device fails with -EINVAL. I'm not sure what the
>>> right way to solve that is, advices are welcome.
>>
>> Probably setting it (back) to zero after each successful runtime_suspend
>> or runtime_resume is the right way.  Rafael?
>
> That follows the assumption that runtime PM usually won't be reliable
> after an error, so runtime_error has to be cleared explicitly via
> pm_runtime_set_status().

Sorry, that won't work.

Anyway, the idea is that the error has to be cleared manually after a failure.
