From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Thu, 03 Mar 2016 22:44:30 +0200
Message-ID: <1823477.dsnFZIej47@avalon>
References: <1457036214-26136-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <7hwppjuwnq.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hwppjuwnq.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

(CC'ing Ulf)

Thank you for the review.

On Thursday 03 March 2016 12:35:53 Kevin Hilman wrote:
> Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com> writes:
> > The pm_runtime_force_suspend() and pm_runtime_force_resume() helpers are
> > designed to help driver being RPM-centric by offering an easy way to
> > manager runtime PM state during system suspend and resume. The first
> 
> s/manager/manage/
> 
> > function will force the device into runtime suspend at system suspend
> > time, while the second one will perform the reverse operation at system
> > resume time.
> > 
> > However, the pm_runtime_force_resume() really forces resume, regarding
> 
> s/regarding/regardless/
> 
> > of whether the device was running or already suspended before the call
> > to pm_runtime_force_suspend(). This results in devices being runtime
> > resumed at system resume time when they shouldn't.
> 
> Agreed.
> 
> > Fix this by recording whether the device has been forcefully suspended
> > in pm_runtime_force_suspend() and condition resume in
> > pm_runtime_force_resume() to that state.
> > 
> > All current users of pm_runtime_force_resume() call the function
> > uncontionally in their system resume handler (some actually set it as
> > the resume handler), all after calling pm_runtime_force_suspend() at
> > system suspend time. The change in behaviour should thus be safe.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> I agree this is the right approach, but Ulf should ack this too since
> he's looked into all the strange corner case involved and may know of
> something I've missed.

Sure, the more reviewers, the merrier :-)

-- 
Regards,

Laurent Pinchart
