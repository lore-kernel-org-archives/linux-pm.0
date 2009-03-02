From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/4] PM: Change suspend code ordering
Date: Mon, 2 Mar 2009 12:48:00 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903021246250.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903012321.40328.rjw@sisk.pl>
	<200903012325.53084.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903012325.53084.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 1 Mar 2009, Rafael J. Wysocki wrote:
>
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Change the ordering of the suspend core code so that the platform
> "prepare" callback is executed and the nonboot CPUs are disabled
> after calling device drivers' "late suspend" methods.

Ok, ack on this whole series, looks fine.

I'd like to see a 5/4 though:

> This change will allow us to rework the PCI PM core so that the power
> state of devices is changed in the "late" phase of suspend (and
> analogously in the "early" phase of resume)

.. doing this. Right now we have that hacky "avoid ACPI by doing a special 
limited form of pci_set_power_state() and pci_enable() in the 
early_resume. I'd love to see the actual PCI code cleanup too.

			Linus
