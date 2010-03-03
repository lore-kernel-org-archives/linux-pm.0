From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH] ACPI / EC: Remove race between EC
 driver and suspend process (rev. 3)
Date: Wed, 03 Mar 2010 16:49:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003031644410.1044__32152.5376676165$1267653041$gmane$org@localhost.localdomain>
References: <201002272140.36891.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201002272140.36891.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

For the record, Rafael, Alexey and I discusseed this a bit further...

We reasoned that this failure is impossible during the Suspend-to-RAM 
path, and the failure is specific to the hibernate reboot kernel handoff
to the resume image.

On a related note, we had trouble justifying the existence
of the current EC .suspend and .resume routines.

thanks,
Len Brown, Intel Open Source Technology Center
