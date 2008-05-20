From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/7] ACPI Hibernation: Use ACPI hardware
	signature
Date: Tue, 20 May 2008 21:51:10 +0200
Message-ID: <200805202151.11448.rjw__39694.513710174$1211313292$gmane$org@sisk.pl>
References: <200805200129.19904.rjw@sisk.pl> <200805200131.33913.rjw@sisk.pl>
	<20080520151748.GA2067@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080520151748.GA2067@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 20 of May 2008, Pavel Machek wrote:
> Hi!
> 
> > From: Shaohua Li <shaohua.li@intel.com>
> > 
> > ACPI defines a hardware signature. BIOS calculates the signature
> > according to hardware configure, if hardware changes, the signature
> > will change, in this case, S4 resume should fail.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > Acked-by: Pavel Machek <pavel@suse.cz>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> I guess I'm quite late to the party, but... could we make this use
> acpi_sleep= command line option, and related variable?
> 
> That brings advantage of existing /proc/sys interface, so that s2disk
> could do blacklist in userspace, and easily...

If I have the time.

Thanks,
Rafael
