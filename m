From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] PM / Suspend: Add more suspend notifier
	events
Date: Fri, 18 Mar 2011 18:01:47 +0000
Message-ID: <AANLkTimrBwyiO7nsCfDNC-g4Xu4-6+4NXHbj8_Mr2fr4@mail.gmail.com>
References: <20110318174620.2D0B99D401D@zog.reactivated.net>
	<201103181851.00988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103181851.00988.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org, dilinger@queued.net
List-Id: linux-pm@vger.kernel.org

2011/3/18 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday, March 18, 2011, Daniel Drake wrote:
>> Without becoming a full platform_suspend_ops implementation, the core
>> olpc driver needs to be called during late suspend to apply a wakeup mask
>> that will have been set by individual drivers' suspend routines.
>>
>> Add a notifier here, and a symmetric one to happen during resume.
>
> Why not to use a struct syscore_ops instead?

That looks like exactly what we need. Thanks.

In my mail I wrote that we need interrupts enabled, but on looking
further I don't think we do. So syscore_ops should take care of it.
I'll let you know if it doesn't.

Daniel
