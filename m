From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 11:08:40 +0200
Message-ID: <200906111108.40785.oliver__45577.6300783784$1244711344$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org>
	<200906101029.27529.rjw@sisk.pl>
	<aec7e5c30906102218j2f8f38dbt5d05a3928ca46c15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906102218j2f8f38dbt5d05a3928ca46c15@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 11. Juni 2009 07:18:46 schrieb Magnus Damm:
> 3) When all devices in the power domain are suspended the bus code can
> turn off the power. The reason why I'd like to only autosuspend when

So you are saying that you have power dependencies independent
of the device tree?

> all devices are idle is simply that we don't get any power savings
> from the per device autosuspend() callbacks, only from turning off
> power to the entire per-domain. So bindly autosuspending and
> autoresuming devices is just pure overhead unless we know we can do it
> for all devices in the domain.

Why can't you do this within the framework? You simply suspend when
all a domain's devices have been autosuspended.
I suppose we could have a helper.

int pm_autosuspend_in_domain(struct device *dev)
{
	int err;

	mutex_lock(dev->power_domain);
	if (! --dev->power_domain.active_devices)
		err = dev->power_domain->power_down(dev->power_domain);
	else
		err = 0;
	mutex_unlock(dev->power_domain);

	return err;
}

	Regards
		Oliver
