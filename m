From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: APM depends on PM_SLEEP?
Date: Wed, 20 Feb 2008 01:17:58 +0100
Message-ID: <200802200117.58533.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802191209260.5385@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0802191209260.5385@axis700.grange>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 19 of February 2008, Guennadi Liakhovetski wrote:
> Hi

Hi,

> Could anyone explain me why APM depends on PM_SLEEP?

Because it refers to the code in drivers/base/power/main.c that depends on
PM_SLEEP.

> Isn't it a valid configuration, when I don't want to sleep / suspend, but
> need APM to, say, turn my machine off using
> APM_REAL_MODE_POWER_OFF, or if I need APM_DISPLAY_BLANK?

Yes, in theory, but that would require some more fine-grained #ifdeffing or
something similar.

Thanks,
Rafael
