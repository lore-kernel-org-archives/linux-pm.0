From: "SUZUKI, Kazuhiro" <kaz@jp.fujitsu.com>
Subject: [PATCH 0/2] Fix hangup after creating checkpoint on Xen.
Date: Mon, 07 Feb 2011 18:07:18 +0900 (JST)
Message-ID: <20110207.180718.885783824287845425.kaz__22193.4784706265$1297097671$gmane$org@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, linux-pm@lists.linux-foundation.org
Cc: xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

Hi,

The following patch series fixes hangup after creating checkpoint on
Xen. The Linux Xen guest can be saved the state to restore later, and
also created snapshot like checkpoint via the hypervisor.
But, when the snapshot is created for the PV guest, it will hangup.

We added 'PMSG_CANCEL' message and 'cancel' handler in dev_pm_ops
struct in the pm-linux part.

In creating checkpoint mode, the resume handler of xenbus should not
be called. In this case, it is recognized that the suspend was canceled
in drivers/xen/manage.c and call dpm_resume_end() with PMSG_CANCEL.
If the 'cancel' handler is defined, it is called instead of resume().

[1/2] - Fix hangup after creating checkpoint on Xen -- pm-linux part.
[2/2] - Fix hangup after creating checkpoint on Xen -- Xen part.

Please review.

Thanks,
KAZ
