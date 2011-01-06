From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] PM: fix oops in suspend/hibernate code
Date: Thu, 06 Jan 2011 16:01:12 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101061554130.17728__37275.1018302099$1294348021$gmane$org@x980>
References: <201101060028.43342.rjw@sisk.pl> <201101061657.39723.rjw@sisk.pl>
	<4D25E943.804@gmail.com> <201101061738.14581.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201101061738.14581.rjw@sisk.pl>
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
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> ... My theory is that we have mapped the
> same area already using ioremap_cache() and now we're trying to map it again
> using ioremap_nocache(), hence the conflict.  I need to confirm this.

On my test box.

BIOS-e820: 0000000077626000 - 0000000077632000 (ACPI NVS)

yet there are at least two tables (FACS and SSDT)
that live in that region, and there are several
run-time AML memory opregions residing in that range too.
So the region has already been mapped by acpi_os_map_memory()
(now using ioremap_cache()) before suspend_nvs_save() runs.

Is there a reason that suspend_nvs_save()
requires a non-cached mapping?

cheers,
Len Brown, Intel Open Source Technology Center
