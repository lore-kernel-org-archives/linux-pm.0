From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] PM / Hibernate: Remove
	arch_prepare_suspend()
Date: Mon, 6 Jun 2011 14:49:41 +0100
Message-ID: <20110606134941.GB15453__15866.8406228118$1307368448$gmane$org@linux-mips.org>
References: <201105211408.28671.rjw@sisk.pl> <201105211410.34491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105211410.34491.rjw@sisk.pl>
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
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 21, 2011 at 02:10:34PM +0200, Rafael J. Wysocki wrote:

> 
> All architectures supporting hibernation define
> arch_prepare_suspend() as an empty function, so remove it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/frv/include/asm/suspend.h       |   20 --------------------
>  arch/mips/include/asm/suspend.h      |    2 --

I don't see what we'd possibly need that hook for so:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
