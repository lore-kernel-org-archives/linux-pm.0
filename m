From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 3/3] Sound (HDA Intel): Restore PCI
	configuration space with interrupts off
Date: Sat, 6 Dec 2008 20:45:35 -0800
Message-ID: <200812062045.35689.jbarnes__13283.7145044052$1228625437$gmane$org@virtuousgeek.org>
References: <200812020320.31876.rjw@sisk.pl> <200812061505.33815.rjw@sisk.pl>
	<200812061509.08994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812061509.08994.rjw@sisk.pl>
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
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 6, 2008 6:09 am Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Sound (HDA Intel): Restore PCI configuration space with interrupts
> off
>
> Move the restoration of the standard PCI configuration registers
> in the snd_hda_intel driver to a ->resume_early() callback executed
> with interrupts disabled, since doing that with interrupts enabled
> may lead to problems in some cases.
>
> This patch addresses the regression from 2.6.26 tracked as
> http://bugzilla.kernel.org/show_bug.cgi?id=12121 .

Since I only applied 1 and 2 you'll need to send this one through Takashi.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
