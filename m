From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH wq#for-2.6.39] workqueue: add
	system_freezeable_wq
Date: Tue, 8 Feb 2011 09:58:26 -0800
Message-ID: <20110208175825.GE4476__29993.0198387758$1297187982$gmane$org@core.coreip.homeip.net>
References: <201102080029.57195.rjw@sisk.pl>
	<20110208044712.GA906@core.coreip.homeip.net>
	<201102081020.25646.rjw@sisk.pl>
	<20110208093212.GA6558@htj.dyndns.org>
	<20110208094155.GB6558@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110208094155.GB6558@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 08, 2011 at 10:41:55AM +0100, Tejun Heo wrote:
> From de62c151df9b6568c67977920267392c432f340a Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Tue, 8 Feb 2011 10:39:03 +0100
> 
> Add system wide freezeable workqueue.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Dmitry Torokhov <dtor@mail.ru>

And if, as Alan said, it could be "freezable" that would be great.

-- 
Dmitry
