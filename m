From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 0/3] Fix hibernation regression on Toshiba
	Portege R500
Date: Sat, 6 Dec 2008 20:30:55 +0100
Message-ID: <200812062030.57914.elendil__47331.1706133702$1228592136$gmane$org@planet.nl>
References: <200812020320.31876.rjw@sisk.pl> <200812020320.31876.rjw@sisk.pl>
	<200812061505.33815.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-To: <200812061505.33815.rjw@sisk.pl>
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
Cc: tiwai@suse.de, greg@kroah.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> The following three patches address the hibernation/suspend issue
> described in http://bugzilla.kernel.org/show_bug.cgi?id=12121 and in
> the very long thread at http://lkml.org/lkml/2008/12/1/382.

I've just built a kernel with your three patches, and without the earlier
"revert/debug" and "ignore transparent bridge" patches.

It also includes my patch that somewhat improves USB resume and my fix for 
the ohci1394: "irq 19: nobody cared" issue. (Although I understand that 
it's likely we'll get a much more structural improvement for USB than my 
naive patch.)

I'll run my notebook with this kernel for the next few days and let you 
know the results. First suspend/resume cycle was fine and showed, as 
expected, a lot of config restores moved up, including HDA intel and 
pcieport-driver.

It's nice to see something of significance happening before the ricoh-mmc 
controller gets disabled :-P

Cheers,
FJP
