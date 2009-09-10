From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug #13733] 2.6.31-rc2: irq 16: nobody cared
Date: Thu, 10 Sep 2009 23:02:51 +0200
Message-ID: <200909102302.51808.rjw__17570.3953057111$1252619748$gmane$org@sisk.pl>
References: <dhwns-J2-13@gated-at.bofh.it> <dhwxb-O6-7@gated-at.bofh.it>
	<4AA6B5D4.4040802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AA6B5D4.4040802@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Niel Lambrechts <niel.lambrechts@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "linux.kernel" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 September 2009, Niel Lambrechts wrote:
> On 09/06/2009 10:30 PM, Rafael J. Wysocki wrote:
> > The following bug entry is on the current list of known regressions
> > from 2.6.30.  Please verify if it still should be listed and let me know
> > (either way).
> >
> >
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=13733
> > Subject		: 2.6.31-rc2: irq 16: nobody cared
> > Submitter	: Niel Lambrechts<niel.lambrechts@gmail.com>
> > Date		: 2009-07-06 18:32 (63 days old)
> > References	: http://marc.info/?l=linux-kernel&m=124690524027166&w=4
> 
> Hi Rafael,
> 
> This is still present in 2.6.31-rc9-pae.
> 
> To test, I removed ehci_hcd, hibernated/resumed and the problem did not appear.
> But when I first plugged in a USB mouse after the system was up and before
> ehci_hcd was loaded the error occurred again.

Thanks for the update (extending the CC list).

Rafael
