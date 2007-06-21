From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 00:10:26 -0700
Message-ID: <200706210010.27531.david-b@pacbell.net>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<200706201332.25486.rjw@sisk.pl>
	<200706202151.15056.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706202151.15056.lenb@kernel.org>
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
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 June 2007, Len Brown wrote:

> I support the proposal that pm_message_t include the target state
> in addition to the phase of entering that state.
> The reasoning is simple, device drivers that receive a pm_message_t
> will do different things depending on the target state.

They should do that based on attributes of the target state,
not any particular notion (e.g. from ACPI) of what the states
may be ...


> The example at hand is ACPI devices that need to know how deep a D-state
> to go into based on the S-state, and this in-turn depends on if they
> are enabled as wakeup devices or not.

None of that needs to involve growing pm_message_t (yeech!),
or even knowing that this system's PM infrastructure uses ACPI.

The ACPI bits need to know about ACPI target state, agreed, but
such stuff can (and should!) be interfaces that normal drivers
never see.

In fact, that's why pci_choose_state() exists.  Its implementation
has always sucked, sure, but not the notion that ACPI can answer
the question following APCI rules, while other PCI platforms can
answer the question using other (non-ACPI) rules.  And likewise
for other device types, including SOC devices.

- Dave
