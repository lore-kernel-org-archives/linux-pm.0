From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 2/9] PCI: Introduce
	platform_pci_power_manageable function
Date: Tue, 24 Jun 2008 14:31:26 +0200
Message-ID: <20080624123125.GD5642__30591.3145807155$1214491324$gmane$org@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200147.16040.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806200147.16040.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> +static struct pci_platform_pm_ops *pci_platform_pm;
> +
> +int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
> +{
> +	if (!ops->is_manageable || !ops->set_state || !ops->choose_state)
> +		return -EINVAL;
> +	pci_platform_pm = ops;
> +	return 0;
> +}

BUG_ON? It is programmer error if we see NULLs here, right? (And those
programmers will be exactly those not checking the return value).

Otherwise looks ok to me.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
