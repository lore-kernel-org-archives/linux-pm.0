From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/4] PCI PM: Make more PCI PM core
	functionality available to drivers
Date: Tue, 22 Jul 2008 14:26:42 -0700
Message-ID: <200807221426.42725.jbarnes__7079.58252537555$1216762180$gmane$org@virtuousgeek.org>
References: <200807191436.40726.rjw@sisk.pl> <200807191439.25371.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807191439.25371.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, July 19, 2008 5:39 am Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make more PCI PM core functionality available to drivers
>
> * Export pci_pme_capable() so that it can be called directly by
>   drivers (for example, tg3 needs that).
>
> * Move the state choosing part of pci_prepare_to_sleep() to a
>   separate function, pci_target_state(), that can be called directly
>   by drivers (for example, tg3 needs that).
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to for-linus.  I had to fix things up in light of the kdoc fixes Randy 
sent, but I think I got them right.

Thanks,
Jesse
