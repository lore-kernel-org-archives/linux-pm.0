From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] power: reset: use restart_notifier mechanism for
 msm-poweroff
Date: Mon, 22 Sep 2014 08:48:59 -0700
Message-ID: <20140922154859.GC5054@roeck-us.net>
References: <1411371774-6834-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411371774-6834-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 22, 2014 at 01:12:54PM +0530, Pramod Gurav wrote:
> This change replaces use of arm_pm_restart with recently introduced
> reset mechanism in Linux kernel called restart_notifier.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Josh Cartwright <joshc@codeaurora.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-pm@vger.kernel.org
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
