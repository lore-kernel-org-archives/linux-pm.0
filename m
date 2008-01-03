From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Thu, 03 Jan 2008 13:36:35 +0800
Message-ID: <1199338595.1642.3.camel__9520.07493838227$1199338674$gmane$org@sli10-desk.sh.intel.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801021505.39789.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801021505.39789.rjw@sisk.pl>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org


On Wed, 2008-01-02 at 22:05 +0800, Rafael J. Wysocki wrote:
> On Wednesday, 2 of January 2008, Shaohua Li wrote:
> > ACPI defines a hardware signature. BIOS calculates the signature
> > according to hardware configure, if hardware changes, the signature
> will
> > change, in this case, S4 resume should fail.
> 
> The idea is fine, but I'd prefer to do that in a more straightforward
> way.
> Namely, we can just:
> * write the signature into a variable in, for example,
>   acpi_hibernation_prepare() (then, the "old" signature value will be
>   automatically saved in the image)
> * compare it with a the "new" value read from the BIOS in
>   acpi_hibernation_leave() and panic if there's a mismatch
> * add a configuration option to disable this behavior (just in case)
> This way we can avoid modifying the entire generic interface to add
> the feature
> specific to ACPI.
it would be better we do the check in boot kernel. Why is so bad to do
it in generic code? Other platforms can implement it too, like
calculating the signature in OS.

> Still, if you want the boot kernel to check the signature, which will
> be more
> elegant (but please note that on x86-64 the boot kernel need not
> support ACPI
> at all), you can use the (recently introduced) architecture part of
> the image
> header for this purpose, without modifying the generic interface.
Where can I get the code with architecture image header support? appears
can't find it.

Thanks,
Shaohua
