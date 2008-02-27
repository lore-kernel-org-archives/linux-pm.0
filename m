From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real"
	device nodes
Date: Tue, 26 Feb 2008 18:19:31 -0800
Message-ID: <200802261819.31755.david-b__10597.8441461504$1204078974$gmane$org@pacbell.net>
References: <200802222154.25204.david-b@pacbell.net>
	<200802252317.43717.david-b@pacbell.net>
	<20080226131058.GA8234@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080226131058.GA8234@khazad-dum.debian.net>
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
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 February 2008, Henrique de Moraes Holschuh wrote:
> On Mon, 25 Feb 2008, David Brownell wrote:
> > int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
> >                                    const char *name);
> > 
> > Perhaps you disabled those warnings.  (And FWIW, I don't see any
> > reasonable way to handle such faults, so ignoring them is thus
> > the right "solution".)
> 
> You issue a printk warning the user, and try to continue.

That's not "handling" in any useful sense though.  There's no
question about "try" to continue, by the way ... from inside
the kernel this information is completely non-essential.

- Dave
