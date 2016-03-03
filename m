From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] PM / Domains: Propagate start and restore errors during runtime resume
Date: Thu, 03 Mar 2016 22:32:22 +0200
Message-ID: <1981850.MfupToJLYq@avalon>
References: <1456874438-26330-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <7h60x3wbrc.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:47472 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcCCUcX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 15:32:23 -0500
In-Reply-To: <7h60x3wbrc.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Kevin,

Thank you for the review.

On Thursday 03 March 2016 12:24:23 Kevin Hilman wrote:
> Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com> writes:
> > During runtime resume the return values of the start and restore steps
> > are ignored. As a result drivers are not notified of runtime resume
> > failures and can't propagate them up. Fix it by returning an error if
> > either the start or restore step fails, and clean up properly in the
> > error path.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/base/power/domain.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > This fixes an issue I've noticed with my driver's .runtime_resume()
> > handler returning an error that was never propagated out of
> > pm_runtime_get_sync().
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> > A second issue then appeared. The device .runtime_error field is set to
> > the error code returned by my .runtime_resume() handler, but it never
> > reset. Any subsequent try to resume the device fails with -EINVAL. I'm not
> > sure what the right way to solve that is, advices are welcome.
> 
> Probably setting it (back) to zero after each successful runtime_suspend
> or runtime_resume is the right way.  Rafael?

It would if you could try resuming again after a failed attempt, but you'll 
receive an error immediately if you try with .runtime_error set.

-- 
Regards,

Laurent Pinchart

