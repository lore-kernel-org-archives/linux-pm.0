From: Frank Seidel <fseidel@suse.de>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 04 Feb 2009 16:31:11 +0100
Message-ID: <4989B4BF.6060509__40128.9332229227$1233761723$gmane$org@suse.de>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902041628.03675.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, frank@f-seidel.de, shaohuhua.li@intel.com, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, kristen.c.accardi@intel.com
List-Id: linux-pm@vger.kernel.org

Frans Pop wrote:
> This patch looks broken to me, at least for some of your changes.
> For example, in the bit quoted above all printks together make up
> *one single* message, which means that only the _first_ of the
> printks should have the KERN_* prefix. printks that are continuations
> should not have the prefix.

Are you absolutely sure about that? The janitors todo lets me guess
they should aswell me prefixed.
Otherwise yes, then some of the changes wouldn't be needed.

Thanks,
Frank
