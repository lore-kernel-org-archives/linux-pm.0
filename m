From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 16:26:12 -0400
Message-ID: <87hcln69zv.fsf__10920.0307321318$1190419100$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<200709212215.26978.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709212215.26978.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri\, 21 Sep 2007 22\:15\:25 +0200")
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[snip]

> The ACPI NVS area is explicitly marked as reserved and we don't save it.
> On x86_64 we don't save any memory areas marked as reserved and yet the above
> happens.

I think you have mentioned before, though, that ACPI is first
initialized by the boot kernel, before it is later initialized by
resuming kernel.  This could well be the source of the problem.

In particular, isn't it the case that you also switch the devices to low
power mode before resuming?

-- 
Jeremy Maitin-Shepard
