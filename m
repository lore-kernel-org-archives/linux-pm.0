Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F274A092E
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328826; cv=none; b=se6LYQuWBlkqwj+C5RXLX3Qgvabwsoq/elNSZrB7YTQ0VJMPF4Tx/2sgp91xV/Rzrf3Lt03EZ+lUhiJCEmtsgG0+GajGIXegL02saLXYJcU1YrcrXOb8810FX5ztUE0ODW1qhUP9Roo+XSOn6WH2+uO7sgfFiyvoFD6c4vNIKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328826; c=relaxed/simple;
	bh=4JL95YwEiwI8pSBFYeThVqI8ljDf5YwjlvnqoDhxV+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1/xfjq4r8/C54nVzAlBky90V12ftmmp49IsjOtLO45DT9ncgsSnQZ+aiNSc7WnBJVggbuayaMFZ4Ud5kpiamoJeb7L8m1o5IYVvLizqDPsmVpeZjh/NdrgmBHkgAtEgG/XtFA5Z6xnSxh15Qv5EwdL56XTcMR0Wx6rxOtBZZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Agp7tfQr; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Agp7tfQr"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so216154c88.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328804; x=1791933604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gALNeJZ8uoakhMubYoDnGucUk9R/qG1InkA2cgN2kR8=;
        b=Agp7tfQrIrb5dZuC73wb1pVdreLij6ISYH6cNLE1OWzF7ftW6LAIp1YRh3hE5Z0v0r
         SA4rfJwPaIIMdZJnHGdvpPGa11s/fcgErUvmEp+gNJF0UCPSdFty0A3v65Ci/klE3ePU
         qCwtByWFtQcBGZBk2ttI5xPyCaN//GgrIyWKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328804; x=1791933604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gALNeJZ8uoakhMubYoDnGucUk9R/qG1InkA2cgN2kR8=;
        b=oavxc72CRv2kTw3PsgbZNdfDgy3Oin4vzio/gVokPgbmZ4fIo0SYh1QxnVcKrZuHxD
         W3qdVc2gOrS2BNY5q2eF2VzV1M59G9nwe0czBEbB7WzCSPetFJJakwCvG6EiLuAPXD0T
         g/tCeXJs+s9pXUYBekoZVsq5gLMA8hb23Zon3G+tsvVm9iDN9sxqtgxy7y0TeqOV5Pvn
         XgINlR87HvrgK3nsmolNQI5qYCoVBrXUUyxKfk3DJW1M6mq6qaZzQv6+o+TSEgpPAei2
         lxxO7WMQFb8ry+T6bUvL+jxnZeTTvbGEyvkt1oOuwrz8bKMkahIAoelhOv3ktNBz3swx
         Cxdg==
X-Gm-Message-State: AFuF++nHsGfFWhVE/h6he6j0oJdhflxgkB2NguiWbsCaLFhtDOojfkiA
	CAfqeHgpHq0X+LCa0rU2F1z7cfUU3GCko9BkqaHc144XozTV+HKKjSj9MnmoTUf+tzbz5Xrn5O7
	NReI=
X-Gm-Gg: AYBFou3Kb9dTpsFCpEx/PRT6QtDVVg/HsC+nJUQiwOYjI3VMQZmOyAoxhHo2uNDQiKT
	4KcmQpdXQsEjSJqVDWhqYcNa69Cy6oHN0zowmfAiI1ndPko+GaujrnGZsN5dI3wfNGFzHh3wkeh
	UWE0NCRcE/tBgSX2gmWrU9ezdwbPPhM2PtZlwMSZBmymWCk6oa3Iuv5E38fCUWm4n4VLU/xnUtB
	ys0ODp/Mh5WrDCdjolsMW8rYqCSK0g13gCHSNEXCsRiflnMLEKNsiv6KClXIhYwOkc024efZhHC
	0qzV8XU3Ft/Znm6PMOAm6d/EKJaVYL1erB2+dcwOl4by+sUw8iWda4EYeAJDoc9cv5GeMjqOgV2
	PasNHBLV55/l9sRwZHsTmeCBpps9/xSY7tBpWJmFJmNM0CuLCzVKLzteLvtAfxs/OT9WDeNsFyk
	7qlkCI18tQtnJkFGcshYZfFhLtvc+db9lZosxNiZk7KpDMioYlL52P/HnTQgvM//6Hpy+xHjXQL
	EEjHTwvE+5IaDc2TBXVt0irII1g2NFiEBzzXw==
X-Received: by 2002:a05:7022:7e8d:b0:145:287:ce91 with SMTP id a92af1059eb24-162059dc702mr311961c88.14.1791328803565;
        Tue, 06 Oct 2026 16:20:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1616980c3b7sm1526701c88.16.2026.10.06.16.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:20:03 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 08/13] ALSA: hda: Discard pm_runtime_put_autosuspend() return value
Date: Tue,  6 Oct 2026 16:13:36 -0700
Message-ID: <20261006161337.8.Idcada3ae757100bf3a38f7e71bac37f827be06c6@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_hdac_power_down() and snd_hdac_power_down_pm() are defined to return
an int, but their return values are never used by any caller.
snd_hdac_power_down() also passes the return value of
pm_runtime_put_autosuspend() to the caller, which is not very useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Modify snd_hdac_power_down() to discard the pm_runtime_put_autosuspend()
return value and change the return types of snd_hdac_power_down() and
snd_hdac_power_down_pm() to void.

No intentional functional impact.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 include/sound/hdaudio.h |  8 ++++----
 sound/hda/core/device.c | 13 ++++---------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index aa994d6e6d35..4cbbb1744740 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -179,9 +179,9 @@ static inline int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid,
 
 #ifdef CONFIG_PM
 int snd_hdac_power_up(struct hdac_device *codec);
-int snd_hdac_power_down(struct hdac_device *codec);
+void snd_hdac_power_down(struct hdac_device *codec);
 int snd_hdac_power_up_pm(struct hdac_device *codec);
-int snd_hdac_power_down_pm(struct hdac_device *codec);
+void snd_hdac_power_down_pm(struct hdac_device *codec);
 int snd_hdac_keep_power_up(struct hdac_device *codec);
 
 /* call this at entering into suspend/resume callbacks in codec driver */
@@ -207,9 +207,9 @@ static inline bool snd_hdac_is_power_on(struct hdac_device *codec)
 }
 #else
 static inline int snd_hdac_power_up(struct hdac_device *codec) { return 0; }
-static inline int snd_hdac_power_down(struct hdac_device *codec) { return 0; }
+static inline void snd_hdac_power_down(struct hdac_device *codec) {}
 static inline int snd_hdac_power_up_pm(struct hdac_device *codec) { return 0; }
-static inline int snd_hdac_power_down_pm(struct hdac_device *codec) { return 0; }
+static inline void snd_hdac_power_down_pm(struct hdac_device *codec) {}
 static inline int snd_hdac_keep_power_up(struct hdac_device *codec) { return 0; }
 static inline void snd_hdac_enter_pm(struct hdac_device *codec) {}
 static inline void snd_hdac_leave_pm(struct hdac_device *codec) {}
diff --git a/sound/hda/core/device.c b/sound/hda/core/device.c
index a45f61e12c1a..6187ffaedbfa 100644
--- a/sound/hda/core/device.c
+++ b/sound/hda/core/device.c
@@ -572,14 +572,12 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up);
 /**
  * snd_hdac_power_down - power down the codec
  * @codec: the codec object
- *
- * Returns zero if successful, or a negative error code.
  */
-int snd_hdac_power_down(struct hdac_device *codec)
+void snd_hdac_power_down(struct hdac_device *codec)
 {
 	struct device *dev = &codec->dev;
 
-	return pm_runtime_put_autosuspend(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_down);
 
@@ -624,14 +622,11 @@ int snd_hdac_keep_power_up(struct hdac_device *codec)
  *
  * Like snd_hdac_power_up_pm(), this function is used in a recursive
  * code path like init code which may be called by PM suspend/resume again.
- *
- * Returns zero if successful, or a negative error code.
  */
-int snd_hdac_power_down_pm(struct hdac_device *codec)
+void snd_hdac_power_down_pm(struct hdac_device *codec)
 {
 	if (atomic_dec_if_positive(&codec->in_pm) < 0)
-		return snd_hdac_power_down(codec);
-	return 0;
+		snd_hdac_power_down(codec);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_down_pm);
 #endif
-- 
2.56.0.360.g66cac248cb-goog

