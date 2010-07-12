From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend][PATCH 0/4] ACPI: Avoid executing _PRW twice
 for all devices
Date: Mon, 12 Jul 2010 14:37:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007121434040.25332__44588.7888585732$1278960093$gmane$org@localhost.localdomain>
References: <201007080041.38627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201007080041.38627.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> [3/4] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
>         cosmetic thing, but worth doing IMO.

FYI, this one had a white-space issue on the line with the "enabled:" 
label -- the patch was missing some tabs and spaces that were in the tree;
but that was the only problem with it.

> Please apply.

done.

thanks,
-Len Brown, Intel Open Source Technology Center
