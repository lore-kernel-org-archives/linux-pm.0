From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real"
	device nodes
Date: Tue, 26 Feb 2008 10:10:58 -0300
Message-ID: <20080226131058.GA8234__9495.46737033433$1204041602$gmane$org@khazad-dum.debian.net>
References: <200802222154.25204.david-b@pacbell.net>
	<200802252245.43282.david-b@pacbell.net>
	<1203977422.10256.91.camel@acpi-hp-zz.sh.intel.com>
	<200802252317.43717.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802252317.43717.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Feb 2008, David Brownell wrote:
> int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
>                                    const char *name);
> 
> Perhaps you disabled those warnings.  (And FWIW, I don't see any
> reasonable way to handle such faults, so ignoring them is thus
> the right "solution".)

You issue a printk warning the user, and try to continue.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
