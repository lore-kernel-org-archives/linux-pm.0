From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 17:33:58 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203BB0EEAE9__45684.1456740678$1273790259$gmane$org@dlee02.ent.ti.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005132311.26293.rjw@sisk.pl>
	<1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
	<201005132327.16163.rjw@sisk.pl>
	<1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
	<20100513214653.GA21120@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513214653.GA21120@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>, Daniel Walker <dwalker@fifo99.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian@smtp1.linux-foundation.org, Arjan@smtp1.linux-foundation.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Greg KH
> Sent: Thursday, May 13, 2010 4:47 PM

> Also note that such a driver, without wakelocks, would never get tested,
> and so, things start quickly diverging.

Do wakelock enabled drivers require a wakelock aware user space to function properly?  If the driver is added you want to make sure the benefit is there and testable for all userspaces.

Early Android service managers did take/release userspace locks to ensure the handoff worked.

Getting all these drivers is positive.  Getting to some constraint mechanism is positive.  It does need to exist end to end to make a difference at the battery.

Regards,
Richard W.
