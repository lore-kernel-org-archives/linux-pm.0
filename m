From: Greg KH <greg@kroah.com>
Subject: Re: [stable] 2.6.38-rc5-git6: Reported regressions
	2.6.36 -> 2.6.37
Date: Tue, 22 Feb 2011 12:07:24 -0800
Message-ID: <20110222200724.GB11679__25246.436140924$1298408046$gmane$org@kroah.com>
References: <JwKd6rET8XO.A._ZC.gbuYNB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <JwKd6rET8XO.A._ZC.gbuYNB@chimera>
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 21, 2011 at 11:29:26PM +0100, Rafael J. Wysocki wrote:
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=24582
> Subject		: Kernel Oops at tty_buffer_request_room when using pppd program (2.6.37-rc4)
> Submitter	: baoyb <baoyb@avit.org.cn>
> Date		: 2010-12-08 13:55 (76 days old)
> Message-ID	: <EF6DDE218DB34702B1FA84D6CD7EA771@baoyb>
> References	: http://marc.info/?l=linux-kernel&m=129181763525738&w=2
> Handled-By	: Jiri Slaby <jslaby@suse.cz>
> Patch		: https://bugzilla.kernel.org/attachment.cgi?id=47872

This is queued up already for sending to Linus soon.

thanks,

greg k-h
