From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 06:44:31 -0700 (PDT)
Message-ID: <806772.17066.qm__9015.8554296524$1275572744$gmane$org@web180305.mail.gq1.yahoo.com>
References: <20100601073548.5ed65352@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601073548.5ed65352@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Florian Mickler <florian@mickler.org>
Cc: Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan@smtp1.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org


> > > If "suspend" is the thing we are used to via
> /sys/power/state then the
> > > race will persist forever except for the suspend blocker workaround,

True, because device wakeups are enabled
by device.driver.suspend() methods, which are
invoked towards the end of the activities
triggered by writing /sys/power/state.

Now, there can be platforms (mostly embedded)
where the drivers adopt a policy that not only
do they keep their devices in as low a power
state as practical at all times, but they also
keep the hardware wakeup mechanisms enabled (they
may be needed to kick the hardware out of those
low power states) ...  That is, suspend() might be
superfluous (a NOP) in those platforms' drivers.

Such platforms might also be (non-ACPI) ones
where idle C-states and S3/STR have the same
power consumption ... but that would be a
platform-specific issue, not a generic thing
which all Linux implementations could rely on.

- Dave
