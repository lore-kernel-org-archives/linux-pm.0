From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
 and hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 02:27:12 +0300
Message-ID: <47EADBD0.6040400__16939.6178484478$1206574141$gmane$org@suse.de>
References: <200803262353.30566.rjw@sisk.pl> <200803270003.51570.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803270003.51570.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> This is the 4th revision of the patch.
> + * struct pm_noirq_ops - device PM callbacks executed with interrupts disabled
> + *
> + * The following callbacks included in 'struct pm_noirq_ops' are executed with
> + * the nonboot CPUs switched off and with interrupts disabled on the only
> + * functional CPU.  They also are executed with the PM core list of devices
> + * locked, so they must NOT unregister any devices.
> + *
> + * @suspend_noirq: Complete the operations of ->suspend() by carrying out any
> + *	actions required for suspending the device that need interrupts to be
> + *	disabled
IMHO, no need to add _noirq in both struct and struct members.
pm_noirq->suspend_noirq does not look good...
