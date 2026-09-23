Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1241DEEC
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185653; cv=none; b=XftFetd0hb4PMkuIaIeRnm0NZhHIBCJu3P1l+oql3kMsSzVLvereMKp4oCaQguZcp+Si8lowpTaWiNRFfAJmtLbepCyPKEKrQjMM4FEaH+FN0SLOrbRTUzGexG/xp3su5uTOqfQUS+U+dA0UduW7GUuFnpwJI95NsdkUICkMvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185653; c=relaxed/simple;
	bh=xeTF7AbUJiyZKStDfbV1ta/s+4wX0IuJsAkaOhCG2eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pObgdHdmN+FKuyejbYvcUwKw1sVjoq6DgIgHWaPeHczNWAZ6ZmdNVixN0D6jG0UZ5OjPcBgP3wAS5OXQhrQU4CX7shaDCbfoMo1I/MHlVLbfVXdIc59Roeh6w/Wl0ZybJYb2OV/so/bHsJFfILX9zUvn6mtGthoSZcR2OtX5FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KQKjBPF+; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQKjBPF+"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so776946a91.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185651; x=1790790451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Ys+TDlQiXSK2w0rIaULx8EXuHW6K3TaTzQSB501wZs=;
        b=KQKjBPF+VtYiN0XVsxrYuBMMfdyL0s4muYq4EmmhH2q84ijg45c4GTPoGzh9A4PHor
         /J3uYC5EuExvXfpp8dvSAbjWgvk++MEU4Xq/jRSDck7YZie24oDvGnodBJk+O7cn2waL
         ADb8TOJlwAtDQwZeNFsS3boUsnBHz/aDTiMfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185651; x=1790790451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Ys+TDlQiXSK2w0rIaULx8EXuHW6K3TaTzQSB501wZs=;
        b=RQUwKsEnqKFCdwOUBZUL8mA2mgQbjLzq3AmHXYA6A+eSg1C01rHMz1HpcEp8NjDykQ
         ymOX49B9JaVrldeBuTArq3RV4vWhkqhkzD6IMCoRqIKsFmvqPPoQdavYWVQW2Nj4upZy
         kz5bjKYygGG35s34o8Ey3e3cCdoNBlp3Pv8FrmQ3vtmFZIfxV2UYonNlbpg+TZtTAK2K
         W02jbG/4aI7fWbQQQQM6vUhTbrpOaMQpdclJFEGW432/CiCOQZRD74OI1rEG1GNNMkr2
         jgA8JU69V4mOmFVYCUymAZToIbdLyUjzrbbxMbOTPgsMCeJ7wWiUCMAUtMyOM/QUw9WI
         6zWw==
X-Forwarded-Encrypted: i=1; AKwUvBxn1HW6zZtV5ARH0/NloeYu8bwyHLWTynvGskFUoj+awmkhAlv3PaFb1d6QNCQhVd5ZNY8xTPVNfQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mfVjWR2ckXd/f/992d2LrNODInF2Qy1mjEXvLTIazRfQ+L5kQP
	b86lwJUfz8AxV8z9ktwwR50r8SRqG8mM2fgafEYe7k9EdAFeML64oaiZm//YDS8Nxg==
X-Gm-Gg: AYBFou33qSm8PY6vfoYiIG3yvDTuOAZFa93bCZFEdItxBmzRY1PZ81IdrCmVH5k5slN
	0cL3wwH4lfBU3Dg1xWG/S4Mg+bGwG94qGrQowow7kmIuGCUaZknJEOJlCsZsYTYx8NmDNd8nQcH
	1bfIL9Rxsj/EmSBrcFZbo2It5gjT03dsIUaTmNBjiRC7LQW9seA9BrayLFNwqrsWy4QmevpmQAv
	h57JmiV0d2sftd5m8DS0oJmY+ztxLG5iACXnUuoLmCcZ77BgJx4W6TBm/X2FIrLghjwrTaEbfFb
	hMvm2lpAXjR7bwkLT0MrEQrg6uGuh+nFHidlWJAqy7gPLilGBjFNtWVuGiyd4ge+f/tpTAHaF4A
	oFiVtuKoNkzOO2lC0lV7ro3Hf2lxAVfIgIPqztGsLArx9AjN53j7Eo3QP7hTl1QMW766orEk13h
	j/Y+DRxYuQRUOiBUgAS1RkHItZmSUV5vqxIikBeg9Lsc9uqB6Xdns5EbjjYOytfktyxsqOBk8ET
	V9An3GbICmNuU1PCJlTybbGMeDO/eIiCaBG0xj/A4IpXT3w
X-Received: by 2002:a17:90b:1dcf:b0:39e:6c69:f479 with SMTP id 98e67ed59e1d1-3a07e74a090mr3526315a91.56.1790185651372;
        Wed, 23 Sep 2026 10:47:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a097663e1dsm157934a91.7.2026.09.23.10.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:29 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/8] PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs
Date: Wed, 23 Sep 2026 10:40:24 -0700
Message-ID: <20260923174711.1283986-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime PM documentation could use some improvements and additions,
to help guide people less familiar with the main runtime PM concepts and
its internal implementation details.

Find version 1 of this series here:
https://lore.kernel.org/all/20260904212000.4167880-1-briannorris@chromium.org/

The first part of that series has already been applied. For the
remaining work:

 - Formatting and clarity improvements.

 - Clarifying core concepts in the Introduction. (Pretty much all new
   readers I encounter have a hard time with the difference between
   "enabled", "allowed", and "active".)

 - Adding Example driver patterns -- because the API is so large and
   complicated, it can help to try to walk people through standard
   practices, and what everything means in context.

I tried to keep some of the larger changes toward the end, to hopefully
make it easier to rework or reject them while cherry-picking some of the
easier stuff from the first part of the series.

Feel free to add suggestions! Within reason, I'm open to tackling more
here, as I think many people have many valid perspectives on exactly why
and how the docs do or don't serve people well today. Or I can tackle
less, if you think some of my choices are not improvements.

Some possible follow-ups I'm toying with:

 * Slimming down the API might be better than heavily documenting it. A
   smaller API is a more digestible API.

   My only concrete next step: drop __pm_runtime_put_autosuspend(). Its
   last user is nearly gone:
   https://lore.kernel.org/all/20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com/

   I could also see deprecating one of
   pm_runtime_put_sync{,_suspend,_autosuspend}(). They all do slightly
   different things, but I'm not sure every difference is actually fully
   intentional (or at least, not necessary).

 * Tweaking some of the behavior on pm_runtime_barrier(). Today, it's
   very asymmetric, as it prefers resume. But I believe there may be
   value in making it flush (not just cancel) pending suspend too. That
   may be in a future proposal; for now, I just try to make its
   asymmetry more clear in the docs.

 * Sand down some more rough edges on return codes. For example, it's
   very difficult to get any useful meaning out of pm_runtime_put_sync()
   return codes. There's a high chance that anyone trying to treat
   return codes as errors is inviting bugs. (Is -EAGAIN a failure?)

   Of course, the answer there is not "document it better" -- we can
   make it easier to use.

 * Adjust the way devm_pm_runtime_enable() works, specifically for
   remove()/teardown. Currently, this is very hard to use correctly --
   some common driver patterns may assume that a device will tear down
   while RPM_SUSPENDED; but that's not actually guaranteed. Notably,
   this makes some of the "Examples" section fairly tricky/subtle.

Regards,
Brian

Changes in v2:
 * Major rework on Introduction section, especially regarding "enabled"
   and "active"
 * Add appropriate teardown to "Probe with Hardware Powered Off"
   Example, as the remove() + power-off behavior is subtle here, and
   easy to get wrong
 * Drop changes that are already applied
 * Add a few new fix patches, noticed while reviewing the rest
 * Move Introduction patch near the end of the series, as it is a likely
   target for further discussion and modification.
 * Correct Ulf's email address
 * CC linux-doc

Brian Norris (8):
  PM: runtime: Correct pm_runtime_autosuspend_expiration() doc
  PM: runtime: More kerneldoc formatting
  PM: runtime: Misc improvements to runtime_pm.rst
  PM: runtime: Add "Section" hyperlinks
  PM: runtime: Clarify ->runtime_idle() callback return value handling
  PM: runtime: Clarify driver callback expectations and structure
    Section 2
  PM: runtime: Expand introduction with core concepts and structure
  PM: runtime: Add Example Driver Patterns section

 Documentation/power/runtime_pm.rst | 568 ++++++++++++++++++++++++++---
 drivers/base/power/runtime.c       |   8 +-
 2 files changed, 525 insertions(+), 51 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog

