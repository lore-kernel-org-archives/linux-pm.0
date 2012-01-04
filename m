From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: sysrq-o broken since 2.6.38
Date: Wed, 4 Jan 2012 23:52:59 +0100
Message-ID: <201201042352.59710.rjw@sisk.pl>
References: <20120104053618.GA20879@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120104053618.GA20879@linuxace.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Phil Oester <kernel@linuxace.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 04, 2012, Phil Oester wrote:
> In commit 1eb208ae [PM: Make CONFIG_PM depend on (CONFIG_PM_SLEEP || CONFIG_PM_RUNTIME)],
> sysrq-o option no longer works unless PM_SLEEP or PM_RUNTIME is enabled.  I doubt
> this was an intended consequence of this change.  Could someone confirm?

No, it wasn't.

I'll try to find out what the problem is.

Thanks,
Rafael
