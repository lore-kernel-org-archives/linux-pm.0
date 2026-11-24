Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534841;
	b=0F/QQfezsT5Y1At2Dvw/kcK6BPeGm4LeGm98uUX5kezsLyRxk1qohtC89zGbGRc0FAnS
	 eQ/0EuwIQffT11LQphb7S+NatEg+oFNOeEKosW1kkwGlS6/FmLX94kStXRc5JH9ixHKxk
	 MDuLcFptRdfDsulsAZNJEHQ+CCyS/BOGCqt6uFl9n3DpJn5OeYD73vh6G0BY+PZwxvu0e
	 ZSHycJ4Pa2eliaJBNXFJ2iUXl7IfllqYtR3mPC4sgmRp5Y3x1KB/h0pLEYPUfXmmWLn9B
	 g9XqdZYpFlqoOWL+Tn/jGgCW/AIiAqcZ5GjtTzO5cC0xIBEDJKvy+BjngxLv0FR3gHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=w7+Vzl+4I34AMY2Evda6KVl8SQuFl//C/7Phv0kN2Ps=;
	b=epSp4DObZmk8+QMsZYW8ZDq6qZ3y609LF4BfAuj/iKZP/S6rN6gL5wfWD3bsWke/Vk1R
	 wpt+9eIn06VE+uwfC5KfUEfdYVwbPQlarSb+6MUCn50BE65YbBCteuckhkY1eoa9jadiB
	 SPg/7eGtW58ocIuClt3q1IvJXqH5LBh2LlL32YDE4cpDg0L0Ay8sxTDE/9u3h8qY3QPEI
	 j9PPmQAUezXMPlWQiyjj1PWtgBJ8ejPPW9ASOKEwZW4oVZ2tgAaadZRHpC8QhpBwZQosS
	 X5R71THGOV9/ANt2sJ5eN2+7Dxz4qg5uISDoklmDTEp2QRbmHHmxn/E5QJR4xQYhFqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bN6LZEFK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F08606A323;
	Tue, 24 Nov 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bN6LZEFK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FB11F000CF;
	Tue, 24 Nov 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534841;
	bh=w7+Vzl+4I34AMY2Evda6KVl8SQuFl//C/7Phv0kN2Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bN6LZEFKm6qdAhwcXLNyC4Ms+1I6aIaZiNu6HPtFChH2hkVyQ3M0EC7IBEmvT3tL5
	 MI4fq0YWQOeuKNcS4sKKMxYjepgB+I1MI8R3HMMQIvfmGQjfGYcoad7GKSTUvL019C
	 o8Z7ACCs0EwDT3D6CczKILmSZxQNGUVzfxa9Ra9IX1YDREHE7CYYPhcmnzchfq8cqh
	 cAjizboHVJWfcXNlbxYoTQZo35Jcv89EuEhV7MOZblnMepyiHep/+xYAyMr2dO6j4K
	 64nsy41NfjphKeVkOM/gNN8D6GD+pDBCepIl5tSoutqEEORBMUvVL0XUs3IqjCtcqx
	 XlUb+UlesQMKA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v2 3/4] PM: runtime: Update last_busy in all rpm_idle() paths
Date: Tue, 24 Nov 2026 16:37:51 +0100
Message-ID: <2373315.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4779892.LvFx2qVVIh@rafael.j.wysocki>
References: <4779892.LvFx2qVVIh@rafael.j.wysocki>
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

The changelog of commit 26236a3e8803 ("PM: runtime: Update last_busy
before calling rpm_suspend() in rpm_idle()") stated that rpm_idle() only
needed to update last_busy when it was about to call rpm_suspend(), but
that is incorrect.  There are still cases in which a device may be
autosuspended earlier than expected.

Namely, when rpm_idle() returns without calling rpm_suspend(), for example
because the callback has returned a transient error, while an autosuspend
timer is running, the timer may suspend the device without respecting the
autosuspend delay.  Moreover, an autosuspend timer may fire while the
callback is running in rpm_idle() and it will not see the new last_busy
value in that case.

To address these cases, add one more pm_runtime_mark_last_busy() call to
rpm_idle(), before the first retval check, and add a comment next to it
to explain the rationale for updating last_busy at that point.

Fixes: 26236a3e8803 ("PM: runtime: Update last_busy before calling rpm_suspend() in rpm_idle()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Address only one case addressed by the v1 (out of two)
   * Add a new last_busy update instead of moving the existing one in case the
     runtime idle callback waits for the device to become idle or similar

---
 drivers/base/power/runtime.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index a71afaea7707..bdcf1f10b39c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -538,6 +538,13 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	else if (dev->power.idle_notification)
 		retval = -EINPROGRESS;
 
+	/*
+	 * Since an autosuspend timer may be running and the new last_busy value
+	 * needs to be seen by it, update last_busy before returning an error or
+	 * dropping the spinlock and allowing the timer function to grab it.
+	 */
+	pm_runtime_mark_last_busy(dev);
+
 	if (retval)
 		goto out;
 
-- 
2.51.0




