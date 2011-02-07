From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Fix hangup after creating checkpoint on
	Xen.
Date: Mon, 7 Feb 2011 10:35:29 +0100
Message-ID: <201102071035.29922.rjw__2880.42066754333$1297071428$gmane$org@sisk.pl>
References: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207.180718.885783824287845425.kaz@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "SUZUKI, Kazuhiro" <kaz@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 07, 2011, SUZUKI, Kazuhiro wrote:
> Hi,

Hi,

> The following patch series fixes hangup after creating checkpoint on
> Xen. The Linux Xen guest can be saved the state to restore later, and
> also created snapshot like checkpoint via the hypervisor.
> But, when the snapshot is created for the PV guest, it will hangup.
> 
> We added 'PMSG_CANCEL' message and 'cancel' handler in dev_pm_ops
> struct in the pm-linux part.

Please don't do that, unless you can convince me there's no other way to fix
the problem you're trying to address.

In my opinion it's highly unrealistic to assume that device drivers
(or even subsystems) will implement the ->cancel() callback just for the
benefit of Xen.

And if the only subsystem that needs to implement ->cancel() is Xen, then the
issue should be addressed without modifying the device core code, in a different
way.

> In creating checkpoint mode, the resume handler of xenbus should not
> be called. In this case, it is recognized that the suspend was canceled
> in drivers/xen/manage.c and call dpm_resume_end() with PMSG_CANCEL.
> If the 'cancel' handler is defined, it is called instead of resume().
> 
> [1/2] - Fix hangup after creating checkpoint on Xen -- pm-linux part.
> [2/2] - Fix hangup after creating checkpoint on Xen -- Xen part.

Thanks,
Rafael
