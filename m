From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add SIMPLE_PM_OPS: make switching to
	dev_pm_ops less	error-prone
Date: Tue, 4 Aug 2009 21:55:33 -0700
Message-ID: <20090805045533.C3574526EA5__8571.00724610991$1249448306$gmane$org@mailhub.coreip.homeip.net>
References: <20090803163304.GF5002@laptop> <200908032123.17069.rjw@sisk.pl>
	<20090804093542.GA5854@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090804093542.GA5854@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Albin Tonnerre <albin.tonnerre@free-electrons.com>
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 04, 2009 at 11:36:12AM +0200, Albin Tonnerre wrote:
> In a number of cases, the .suspend, .freeze, .poweroff and .resume,
> .thaw, .restore functions are identical. However, they all need to be
> assigned to avoid regressionsm as the previous code called .suspend
> resp. .resume in all those cases. SIMPLE_PM_OPS allows to deal with
> this case.
> 

I'd much rather have conversions done with a bit more analysis now that
our framework is more flexible and we can have specialized routines for
hibernation and suspend.

Maybe we should try changing from run-time to build time warning so that
users are not overly concerned with it?

Thanks.

-- 
Dmitry
