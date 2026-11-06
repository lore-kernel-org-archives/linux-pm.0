Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964706;
	b=kCRVc9dn07PX/muTHYCQtaOmf9KnSr1oD05OQ2ZrkK8IHNFXDODn77lvt+FHEc/6VAra
	 s+ylhHqHw8aSM8tCFYqxEJUudD6PpS5iEpn6fybqrzUkBYWI1kw4wwSzf7yP+71m+J9JQ
	 SGRgPuPJef7dZfBmN05HawcknVzZuXzK0dwaVkKfLHgG+mdMog9+B3uIYE/MRncZxrWSf
	 7Rifz2KXXZRZmUuhjgtaxcMpBplje0yOQarqVPpETjF+XQWBqYc07AGdHewMQPZqmvBi4
	 EOZErUu5K9dvsp8C+Kce7On7UOu3B33ar3ZcNBdSKQhQtkqXUHb+uLNdrbzmFivXZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=IkZ4QsbIo6NB3CqXA++bJQKlV2FLxKl3SeIw8XijjNk=;
	b=aeY7OzODI5+LiXuyhxizGwSCL/4tzft+afe4MKBy4BZqRpo1Lw+fBXjFWqpRDG5wBjgE
	 5p/2ab0W0R9oCiXdkl6rm0rwq4COPAORx/+NqHXz0q6j3RfhrOf4U28ndH0D5nqCzTqFz
	 HWErfIcb9zLXLC/NAr2RKULPKq1Yj9B/e1iJ0c1oTmOCQmTvy2Q7dyAG7/jV5KpobwzNH
	 c5Ux2YdIJgrzwq0AbNTFi24kVwssn/EJL3C25byPeeSWhgx2VmSMe44f6OeCJD/UilJcB
	 1NP3rkj8F7PSf7uNQAWhPTpWJCXGZL4ueYZk3XvutMaygqTJItmD3Rlsie4ygtTimvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=II7FpDRr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACD606D805;
	Fri,  6 Nov 2026 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=II7FpDRr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF6D1F0089F;
	Fri,  6 Nov 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964706;
	bh=IkZ4QsbIo6NB3CqXA++bJQKlV2FLxKl3SeIw8XijjNk=;
	h=From:To:Cc:Subject:Date;
	b=II7FpDRrD1pbynr8pZEGJrrn3eQRufW6CYbct7E6l8lKd1EcAcXNlQrMEEEwJKhA7
	 eHnXMXOSh59OVlxyPQhzFSUPTZxj3vkGtbU2Cr4+jOAOu6rnsG2iIQBEe7sPODpmVe
	 FcSfkSn75eB4gFVosRFrm2AbOeTXuNeQN9rjpop4aG7nRKbEOs1Eezl1EeQh38gVJf
	 INYiz+zbk1pWWjlipjrEHP/mFizhGJrdDpZGK5hQ6onMRExZ8PaJQnFb73gg8eTRwm
	 aZUGDtSYp1qnLF1iC2RLuqPHxBbXJozwOy7vtu5uUM2tPRdIqU2K+d7bRkQYQriNP6
	 K9vwBRCPOnMOQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v1] PM: runtime: Update last_busy in rpm_resume() for active devices
Date: Fri, 06 Nov 2026 12:31:41 +0100
Message-ID: <13032301.O9o76ZdvQC@rafael.j.wysocki>
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

Setting an autosuspend delay for a device can be expected to cause a
runtime suspend of the device after calling, say, pm_runtime_put() to
be deferred, so the time between the last successful attempt to resume
the device and its subsequent suspend is at least equal to the
autosuspend delay.

However, that expectation is only met after the device has been actually
resumed in rpm_resume() by invoking its runtime resume callback.  If the
runtime PM status of the device is already "active" when rpm_resume()
runs for it, the device's last_busy timestamp is not updated which may
allow a subsequent pm_runtime_put() invocation (or similar) to suspend
it right away.

This is arguably inconsistent and confusing, so make rpm_resume() also
update the device's last_busy timestamp when it finds that the device is
already "active" and it is about to return 1 early.

Fixes: 56f487c78015 ("PM / Runtime: Update last_busy in rpm_resume")
Link: https://lore.kernel.org/linux-pm/CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com/
Reported-by: Brian Norris <briannorris@chromium.org>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -819,6 +819,12 @@ static int rpm_resume(struct device *dev
 		pm_runtime_deactivate_timer(dev);
 
 	if (dev->power.runtime_status == RPM_ACTIVE) {
+		/*
+		 * The attempt to resume the device means that it is needed for
+		 * something, so update its last_busy timestamp as in the case
+		 * in which it actually resumes below.
+		 */
+		pm_runtime_mark_last_busy(dev);
 		retval = 1;
 		goto out;
 	}



