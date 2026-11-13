Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576447;
	b=oUnyY+WAArQPAucfQVsiQhxBmU7+N8ZEzCoNPWjcz4MrASXVJ8Oa6sjifWLPhpmFPnil
	 tP9tMjgjC7wNkVgxxmo629QmATE1wfCL+TBdvqp6/k6S/GoIyi7voVUXxjmbzrLLga2U9
	 GJic33YG5dN/KeOYyrPr9bwVcpUXk2eUNwFcOH+VGn39zu96PVW/QmRAqudP1fjADu1Mb
	 7MARSAMHlt4/LAjN9RCVDPnaFw99cGAgu3yvupt1+QQ/sP61D1zmeVmIDwxJcWHWtbcsb
	 d1+n8NcVWtSUYRKPsHz7PVYFgCEc3ceYYqc4XDjN6PckvqnX3vxUXS1+4gCBej2WPNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=8fRGrgdpcOLrAC+A5MTGioC4BdpuyuY8kAtSNqNWojg=;
	b=GhC37iCpAz/74JFVfHehRYHViAiBiH6fuvRMv/HvfNoZLRobwXNmbCWkgEHdNk+BMyKz
	 wVCDiZboBEmwi9crx/Jr91mvkSNLZuspSavcZOCZnAbBGvZoE8Fzm3+9EvJzZwG3ndMbo
	 Tvca+b9+hquvtOM1Iz4mldG8lbNC2Kwiy0ldkqvynP22ZCOUp38Lc5mX0Ky7KTE9Ps0//
	 56y6RlMNbcWslqUI4XHsnVDPykvTivtpHOHJwl9fntOPQQboX+I+yeRSsrDGGWzvBrZat
	 uu6epWBEQYCJHuqWy3mt4P2SqUbTlVbFO5nFB82sr14z5oi/uHpNQBB85N/XAeOz6DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhKYH0Sr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C2606CAB2;
	Fri, 13 Nov 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhKYH0Sr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B1F1F000C4;
	Fri, 13 Nov 2026 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576447;
	bh=8fRGrgdpcOLrAC+A5MTGioC4BdpuyuY8kAtSNqNWojg=;
	h=From:To:Cc:Subject:Date;
	b=YhKYH0SrgQpIW+yPM+io4wYZe6J1s8jNkkkV2S3sqR+BbfUlIBsDXI+ly1dOT41vo
	 9Wmv+4BYkSytk10bWNrzBlG9TSps3OqLzTh9SPLSaSFH/vJvyDOwT4eAmLTaPYXEAv
	 UICs+lybbS89MSLjaZTTejezgSoQMLOmXRwBNL9t8p9L1yqOy6EfWpvrv2ZW/t9ygT
	 +a3crOcttz9Sig7HOQutmcaECwy5G/aCDln5dj1xtA0idRS0840fJg6Q+9ap46XAyk
	 5kAVNoEGck/jv8R0QFc5ewuP1jTYkTtVguoQD4/FxyRixseHp9MOpXJPZwP379H0cO
	 UvcLCo6Yz9kEw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject:
 [PATCH v1] PM: runtime: Update last_busy before calling rpm_suspend() in
 rpm_idle()
Date: Fri, 13 Nov 2026 14:27:23 +0100
Message-ID: <4789427.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

When rpm_idle() is about to call rpm_suspend(), there are no reasons
preventing the device from being suspended, but if the device uses an
autosuspend delay, it needs to be taken into account.

For this purpose, rpm_idle() adds RPM_AUTO to the flags passed to
rpm_suspend(), but doing that alone is insufficient because the point
in time from which the autosuspend delay is counted may be too early.

For example, if the device has children (or consumers) and the last
of them goes into runtime suspend, the parent may now become eligible
for suspending, but it may not be worthwhile for it to suspend until
a certain time later.

Quoting Alan Stern [1]:

 Let's say the last remaining active child goes into runtime suspend at
 time T.  Let's also say that the parent expects none of the children
 will need to resume until time T + D.  Is D sufficiently large to make
 it worthwhile for the parent to suspend and then resume?  If not, the
 parent should remain active.  If yes, the parent should autosuspend --
 and the length of time the parent should wait before autosuspending is
 on the order of the value of D (let's call it D*) that corresponds to
 this crossover point.  Thus the parent's autosuspend delay should be
 set to D*, or something close to it, in order to achieve both
 objectives.

Moreover, if the parent's autosuspend delay is set to D*, it should be
counted from time T at which the last child has suspended, but that does
not happen because the parent's last_busy timestamp is not updated at
time T.  That leads to undesirable parent suspends occurring between
child suspend and resume [2].

To address this issue, make rpm_idle() update the last_busy timestamp
of the device when it is about to call rpm_suspend() which most often
is right after the device's last child (or consumer) has gone into
runtime suspend.

Updating the last_busy timestamp when rpm_idle() returns an error
without calling rpm_suspend() is not useful because the device is then
going to remain active for an unknown amount of time and its autosuspend
delay needs to take effect later.

Link: https://lore.kernel.org/linux-pm/fc43eb13-816b-4cd0-9711-848fdab605ef@rowland.harvard.edu/ [1]
Link: https://lore.kernel.org/linux-pm/CAJZ5v0hKpjMsGQm8Cpa89x5wkNxqkggDNbp+eQ0S-E52DETWjQ@mail.gmail.com/ [2]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -560,7 +560,11 @@ static int rpm_idle(struct device *dev,
 
  out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
-	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
+	if (retval)
+		return retval;
+
+	pm_runtime_mark_last_busy(dev);
+	return rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
 /**



