From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH v3] power: reset: use restart_notifier mechanism for
 msm-poweroff
Date: Tue, 23 Sep 2014 12:55:56 -0500
Message-ID: <20140923175556.GG868@joshc.qualcomm.com>
References: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com>
 <542112FD.7080302@smartplayin.com>
 <2C40727B-BF1E-46AC-9189-6B35E358220E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2C40727B-BF1E-46AC-9189-6B35E358220E@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 23, 2014 at 12:48:42PM -0500, Kumar Gala wrote:
> 
> On Sep 23, 2014, at 1:28 AM, Pramod Gurav <pramod.gurav@smartplayin.com> wrote:
> 
> > +linux-arm-msm
> > On Tuesday 23 September 2014 11:38 AM, Pramod Gurav wrote:
> >> This change replaces use of arm_pm_restart with recently introduced
> >> reset mechanism in Linux kernel called restart_notifier.
> 
> Can you update the commit message to include details about the priority level we are setting it to.
> 
> Probably something like Josh had:
> 
> Choose priority 128, as according to documentation, this mechanism "is
> sufficient to restart the entire system?.
> 
> Hmm, what happens if we have ps_hold restart and msm-poweroff enabled.
> Which one should have priority?

I would hope we would avoid a situation where both this driver is
probed, and the pinctrl-msm driver has registered a restart handler?

That is, we wouldn't ever mix the pinctrl-msm ps_hold mechanism (for
MSM8660/MSM8960/APQ8064, etc) and msm-poweroff (APQ8074 and later).  Is
this a case you're worried about?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
