From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: Fix build for !CONFIG_THERMAL
Date: Wed, 4 Mar 2015 16:02:15 +0000
Message-ID: <20150304160215.GA2919@e104805>
References: <1425470739-16651-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425470739-16651-1-git-send-email-broonie@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Wed, Mar 04, 2015 at 12:05:39PM +0000, Mark Brown wrote:
> Commit ddd4dd8ddf784 (thermal: extend the cooling device API to include
> power information) added stubs for newly introduced functions when
> !CONFIG_THERMAL but did not provide names for the parameters which is
> a syntax error causing build errors in such configurations. Add names to
> fix the issue.
> 
> Also remove an extra semicolon from power_actor_set_power() which also
> breaks the build and declare the functions as static inline to avoid
> both multiple definitions and sparse warnings.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

This is already fixed in Eduardo's tree, but apparently the fix went
in after linux-next merged its branch.  It will be picked when
linux-next merges it again.

Thanks,
Javi
