From: Frank Seidel <fseidel@suse.de>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 04 Feb 2009 16:48:58 +0100
Message-ID: <4989B8EA.5000105__22854.5442842462$1233762909$gmane$org@suse.de>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl>
	<alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LRH.2.00.0902041642450.7690@vixen.sonytel.be>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: len.brown@intel.com, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, frank@f-seidel.de, shaohuhua.li@intel.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, kristen.c.accardi@intel.com
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven wrote:
> Actually they should, but the right prefix :-)
> 
> Quoting include/linux/kernel.h:
> ...

Ah, no i see. And i missed the line (from janitors todo) that
this should only be done for line beginnings (and now KERN_CONT
for core/arch..).
Thank you very much that pointer. Will keep it in mind for my
further cleanups of this topic.
Of course i will then also redo the above patch.

Thanks,
Frank
