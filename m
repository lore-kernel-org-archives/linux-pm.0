From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Sat, 22 Mar 2008 16:49:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803221645190.27399-100000__39195.3475228094$1206219183$gmane$org@netrider.rowland.org>
References: <200803221845.13826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803221845.13826.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 22 Mar 2008, Rafael J. Wysocki wrote:

> However, as far as the ACPI NVS area is concerned, this is probably not
> necessary, because the spec wants us to restore the ACPI NVS before calling
> _WAK, which is just after the image kernel gets the control back.  So, in
> theory, the ACPI NVS data could be stored in the image and restored by
> the image kernel from a location known to it (the procedure may be to copy
> the ACPI NVS data into a region of regular RAM before creating the image and
> copy them back into the ACPI NVS area in platform->leave(), for example), but
> I suspect that for this to work we'll have to switch ACPI off in the boot
> kernel, just prior to passing control back to the image kernel.

That sounds by far the simplest solution.  If the boot kernel can tell
(by looking at some header field in the image or any other way) that
the hibernation used S5 instead of S4, then it should just turn off 
ACPI before passing control to the image kernel.  Then the image kernel 
can turn ACPI back on and all should be well.  If you do this, does the 
NVS region still need to be preserved?

Alan Stern
