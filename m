From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: apm emulation driver broken ?
Date: Sat, 17 Nov 2007 09:53:46 +0100
Message-ID: <473EAC1A.1000205__25180.0463804559$1195289710$gmane$org@gmail.com>
References: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
	<200711161720.50313.rjw@sisk.pl>
	<cda58cb80711160929i4dbac6b7xb9d1bcc9223ddd7b@mail.gmail.com>
	<200711162220.56494.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711162220.56494.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> However, using PF_NOFREEZE to prevent this from happening doesn't seem to be
> a good idea.
> 

Indeed but...

> I'd probably use wait_event_freezable() (defined in
> include/linux/freezer.h) for that.

...I would just revert this bits from now to make sure this driver
work again for v2.6.24.
 
> It tries to send them fake signals and waits for them to freeze.  If
> they don't freeze within the timeout, it fails and clears their
> TIF_FREEZE bits.

But send_fake_signal() seems to wake up task in INTERRUPTIBLE state
only. Looking at signal_wake_up(), it basically do:

	wake_up_state(t, TASK_INTERRUPTIBLE);

What am I missing ?

		Franck
