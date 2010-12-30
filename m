From: Maksim Rayskiy <maksim.rayskiy@gmail.com>
Subject: [RFC] Deferred disk spinup during system resume
Date: Thu, 30 Dec 2010 11:40:10 -0800
Message-ID: <AANLkTinOqLOJ7JCpHeQNYUEirqAvkSce+eFDCGkWn3jE__8116.28506421602$1293738148$gmane$org@mail.gmail.com>
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
To: linux-scsi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

When resuming from system suspend, scsi disks are being spun up which
takes quite a lot of time (5+ seconds in my case). The spinup is done
synchronously, so this time adds up to overall system resume time.
Ours is an embedded platform and we are using flash-based rootfs, so
there is no immediate need in harddrive after resume. What is much
more important for us is to minimize time-to-full-power. To speed up
resume, we would like to have an option to defer the spinup or run it
in parallel with system resume. I could not find any existing
mechanism to do the trick, but I might have missed something.

Can anybody comment on this?

Thanks,
Maksim.
