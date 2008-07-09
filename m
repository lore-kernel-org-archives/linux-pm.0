From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC PATCH 2/4] ACPI: introduce the mechanism
	to	save/restore ACPI NVS memory
Date: Thu, 10 Jul 2008 00:44:58 +0200
Message-ID: <20080709224457.GA5629__38686.8165493526$1215643564$gmane$org@elf.ucw.cz>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com>
	<20080708193558.GC8694@ucw.cz>
	<20080709145850.GA18230@khazad-dum.debian.net>
	<200807092226.12195.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807092226.12195.rjw@sisk.pl>
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
Cc: linux-kernel <linux-kernel@zh-kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> However, speaking of vendors, I'd like us to be able to switch that off using
> an 'acpi_sleep=' option (s4_no_nvs comes to mind) and/or blacklist broken
> BIOSes.

Works for me. (Plus, shutdown mode will not do any ACPI NVS saving, right?)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
