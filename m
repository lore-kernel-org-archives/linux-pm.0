Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119559;
	b=Qb7hg04tHes7oZuD5l0mhFwHwvTjeRTKfotNobpiOwn1pIlelw4muYXMwmOaEV/jzzQW
	 Mm4bivAW+yV8roD7O31MGMW3jXyeNPGIHcjOpjm3QAPGlsJet27AVjDYxEaZ42X6idgLA
	 lH27s/MssF/G1wuunbiJtR/9XbGb0qoENlCMCWvoTEIzjAre5j8dPNyrBiO0YBxd4F8r2
	 9Kfssgf4liUMlx1jGXGvD7O3dbpLgYWiT9Q1ioIU+AtM7DJbDrzjrTZjEG6UT0oBBKfWI
	 +Gyi5TRQ40Eqh19b2u5gKMEtmNVhd82HjcUw5BPZfsgjdLaf/4HsSSg5idEjodi3Udw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=LAeGseoVNJClCP/Xf2eakpkXRTLTx+M9br/V/h2PGAo=;
	b=Sya2IqXUJ3sq/BL2ENFx3yeJeB3yM4dMBJ7wScAfbaD4ThEtUSxPNEVQ3mhyDnjY1pEM
	 GAEabVK4U0Q7qW2xVEvL+hUef1MB5FgOr2ciTCuRT5Dp/6QqueAMfApUB4Sakw4I9SPU5
	 QjkwR/VcHnSniT7BzQgKB7NkhExPbfc23eDM5lqaluU4ASlzgTn+waaA/hF+CdcRVJi3S
	 Gv7cCCh86Yo8yczvx46i/LX4VcjG+3/d4oNL3tn63gsoCthRhGPc0v3qUZRWSBU3qDyJo
	 mPkGRb4XlKW0TRtOcOxBuAk4uc//Ihq4D6XsTsz3XEKwpidS+HBZSczXCB1Was1oa3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K302fx8A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA139606C6A2;
	Thu, 19 Nov 2026 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K302fx8A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612921F000C0;
	Thu, 19 Nov 2026 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119559;
	bh=LAeGseoVNJClCP/Xf2eakpkXRTLTx+M9br/V/h2PGAo=;
	h=From:To:Cc:Subject:Date;
	b=K302fx8AjzYtM9XU2gJ6G+C4PPPwYCjOQk1ZQneLZoDLtaCssksQ1BR0/98VDrtDo
	 M1IO2tzj142uP8hjp0Lxxmpo2T9klVc4Z2xSfYLre043ZHkViF65mlSdoMqiRv9FD2
	 IIecn6LxQ9Qq8/h+sGqlGvnNjyFUEMyXJF6oqPwMPWFb2jyLXBCe+rTdrdyxTC3/3k
	 1xzKc1a4j+vja9c9zsY5CF1Fdj44hR682Oj9NLBUPZFB5pJzmzSAxs22eT2cWQnjNQ
	 qpJRoUm6DnwhWSwhDnvnG/32ry2rO0a3w7AVtRfBOw3/vqGoeRB0R6H+mMj8Z4fSkD
	 qzvhMSKxgDO0Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v1 0/4] PM: runtime: Close some gaps related to autosuspend
Date: Thu, 19 Nov 2026 21:13:03 +0100
Message-ID: <1978814.tdWV9SEqCh@rafael.j.wysocki>
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

Hi All,

This is a follow-up series for

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=26236a3e8803f7e1ace104020d7f006edb220116

which is in linux-next.

First of all, I was mistaken when I wrote this in the changelog of the above:

 Updating the last_busy timestamp when rpm_idle() returns an error
 without calling rpm_suspend() is not useful because the device is then
 going to remain active for an unknown amount of time and its autosuspend
 delay needs to take effect later.

There actually is a reason for doing this which is that an autosuspend timer
(left behind by an intermediate runtime resume) may be running when rpm_idle()
runs and that autosuspend timer needs to be prevented from using a soon-to-be-stale
last_busy timestamp value.  There is one more issue related to that in
__pm_runtime_idle() and both are addressed by patch [1/4].

Patch [2/4] simply removes spaces preceding labels as a matter of cleanup.

Patch [3/4] removes one more difference in the handling of devices that are
resumed by rpm_resume() and those that are already active when they are passed
to that function.

Patch [4/4] drops the direct pm_runtime_mark_last_busy() calls from rpm_resume()
that are not needed any more after the previous changes.

For details, please see the patch changelogs.

Thanks!



