From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 0/4] ACPI: Avoid executing _PRW twice
	for all devices
Date: Mon, 12 Jul 2010 21:35:40 +0200
Message-ID: <201007122135.40204.rjw__31816.5568788119$1278965421$gmane$org@sisk.pl>
References: <201007080041.38627.rjw@sisk.pl>
	<alpine.LFD.2.00.1007121434040.25332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1007121434040.25332@localhost.localdomain>
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
Cc: Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 12, 2010, Len Brown wrote:
> 
> > [3/4] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
> >         cosmetic thing, but worth doing IMO.
> 
> FYI, this one had a white-space issue on the line with the "enabled:" 
> label -- the patch was missing some tabs and spaces that were in the tree;
> but that was the only problem with it.
> 
> > Please apply.

Thanks!

Rafael
