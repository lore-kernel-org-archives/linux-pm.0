Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700002;
	b=YVfrQC3X8/a7cqBfR8uYRK9n7zekpZI0B7iLC4nbpUt4VBw7S6OF2muIkS1/nNY8rzio
	 8bChrubXBw9+9Fn0UPVVrBDCdBgpxmNTNfY3ggXaGu4EL4qIieJJXAfg6MSXyY0oZgNGH
	 eqM7aiDHGl2HsNN0JVe2c817AnffnTYXWhMVJKwaC6IRQhh5+w4AKNyEEk/6k2PUWEOqs
	 54WNCK7CZ2qYOreGbciCci1MKHOpqrk2+T/OznjtMWyR3jHee+Gj6xG3GUtbRxBiEcR8H
	 2wWD3iKOD2ogMvYkjD2iGMA9wIV7gUiab4874KjCzNTb1uCUwewQnutUE61HpTlRQ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DsXYwWSNjaBFqxw5zqDiY6JE1Q8o58Z7F9XiPYp5pso=;
	b=y28xZKbtNlsmro81cvtwnej1+nULFWcflIi980PqR17zUH3+cDjKFXDYB6CUt6Bder7p
	 Vw94WmsaS+KmVDBgcEy/iqPPGpl4u5NJlyb0fpskiv38fuoLlDiwnKqa3yid5TA9E4yYd
	 7pmEDYOkGNHP/Ti7jNpQfmOMjUHtQcvsW8l2eUML1dZrk1fi7jA93OJ/+vGZMUEDV6fr/
	 s7t5Uo1X36SKX31r5NoPT0uyDlza1I/TzeqG2cIcXIrxT0s7MfNCQRUhpkCca+8s1eh7G
	 EHo0WxvvTMPK10kPBJTdRzHr5fcCnjfs35GNGEDo1hDhBYWciTC6ypnqpP1Uu49/KzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaM2axvL;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CA606A329
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 23:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaM2axvL
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-372bdb942dbso2212740eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794700001; x=1795304801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DsXYwWSNjaBFqxw5zqDiY6JE1Q8o58Z7F9XiPYp5pso=;
        b=NaM2axvLYJXo9OHQhTdC2X/TZ/yL6/alDeeuYxQ1ZODDTQx/LmUZ+i0qCzi5uNgtye
         veKG9u0vui3RD7QMZuHrl1TtVKpApyJJNupq3wcSIZ/Vh6rLbczBQPJZf6BCIHffx2cw
         JHv41VO3CKRvv7koBxwmlx7flSac7S1zxGRYDFitOcHdEKNe9Z8c+ziS3hB1xgbRfX5n
         glWJdMyIry7+500OotpTKVvdTfzDZY9uU3pCnAPp0XaocBZyCGYHLwKzXsjQQE1rJmyE
         IoxmdSRCNm1JnFjYz+rCxGxpNOgYfF5/ow2y+/npDsIw019qgeSAzbEAj96EnQKPhG/A
         TG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794700001; x=1795304801;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsXYwWSNjaBFqxw5zqDiY6JE1Q8o58Z7F9XiPYp5pso=;
        b=Q4LmcwjZx16/0unA75kiQvwwzWG39LG2CorBrz14ihIh8197goJRe5PXUBjGII7AAO
         a4GF7wTlc/qhEx1I50c/+gg/YnC79Az7QqcRirCZA1u3DJJdV0EGQnpFZ156+gW01u14
         FeSgvgVm7drTW1tH9AIgZ32OEWKEiZf6YRzUJ283lGDkM8wVI6DF9f6Ja2wzlx4dhAKl
         WbE81Br5DOE7XGirzdaF5IcJLUqsveGO/fqWbNsYMq7Jgr11ARq01qFmzgfW7C6v+Jv+
         YPYVsVeCqx9J5aY+DW6Hjzn1NnCGmhm8ZMHfwIK4YS5f2enRClfDWIzuxJ7Qw55WYQnH
         h8Ow==
X-Gm-Message-State: APuU4Z9PNR8ysjlkr6rZbxavpj/k+HK7bkNezaSwLYX/ZgUx/JoSuFf9
	4HO0BsjgolNK173oKqpXc3wYleKDBWe2+AKHhNYHcfZgCQTR3P57zLsp
X-Gm-Gg: AYBFou0xDECGyG7hOGM1RpEutMMamWbDfuF/SbQX3CgUaRYt5z8NawEtJjNmFTiIdYS
	TKL0cmu0O85d0ZXfRxyAZo0ZF/x71i9RS2vh/vSLElWjalpkb7U42LfX45IlA1vAcrGK5nn/mRr
	oLBqXL2a+GZa37z4naPrFNi5x/NAta0UwbhinRPjB5IJV9wIDiUPi4h9+SnBprP+Gba7i0TLl8+
	8Hsr9L584xkkMeAE2cRvESeOmYW+Bq22NpoGS564abzInR1qlnx7ajYeTwz+H5l16Ruqyn2ZgmQ
	EIRz6WzwEtOWNCn2+wrWPDqMPPCi909A2R+iyhhhHnJfqcZC7eybXyApoToHCZtfCj/6zlbx4GS
	PpIQ94aoEioKvCAua7Juu/4cL9eMj7QBkkC1eYXeyL8WJHgo4O79nrs0hQUcz5FQQfLyplZwgQJ
	N7IiC+oI6OzDA3zjjrrPiqd135iLSJ1RoveIrWveKTg8xwNZ9JQgwSvsidvW/X1Igft6LjMo4fk
	JGY8FAQVyladvAq710f0bpNNWXOtUkxuLUz1z8IM/x+Yy9jw4BbOsNLKFEyqc/q+AIXd2JyH0Vh
	AUCHHk3YsCU6nKzniBMpUeb/+PKQVX96nMZrLi4Sje5SeayrZS99eEdxm/kOtE/NBfpb
X-Received: by 2002:a05:7301:4c92:b0:36c:ec0:23ef with SMTP id 5a478bee46e88-379675fc906mr5925233eec.16.1794700001217;
        Sat, 14 Nov 2026 15:46:41 -0800 (PST)
Received: from [192.168.35.43] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm20474566eec.13.2026.11.14.15.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 15:46:40 -0800 (PST)
Message-ID: <6a60a9f4-7525-4555-91f4-a6072c3701f9@gmail.com>
Date: Sun, 15 Nov 2026 08:46:37 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH] devfreq: stop monitor before calling governor GOV_STOP
Content-Language: ko
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/2026 2:11 AM, Mukesh Ojha wrote:
> The following NULL pointer dereference is observed when devfreq_monitor
> fires after userspace_exit() has freed governor_data:
> 
>   pc : devfreq_userspace_func+0x10/0x2c
>   Code: 39402109 --> ldrb w9, [x0, #8]   (x0 = NULL)
>   Call trace:
>    devfreq_userspace_func+0x10/0x2c
>    devfreq_monitor+0x34/0x134
>    process_scheduled_works+0x1d8/0x804
>    worker_thread+0x1c0/0x458
> 
> The fault address 0x8 is userspace_data.valid — an 8-byte unsigned long
> (user_frequency) precedes it, so governor_data == NULL is the cause.
> 
> The race: devfreq_resume_device() reads df->governor without holding
> devfreq_list_lock, while governor_store() updates it under that lock.
> The stale pointer dispatches GOV_RESUME to the old governor
> (simple_ondemand) after the switch has already completed:
> 
>   CPU 0 (devfreq_resume_device)        CPU 1 (governor_store)
> 
>   read df->governor → simple_ondemand
>                                        lock(devfreq_list_lock)
>                                        GOV_STOP → monitor stopped
>                                        df->governor = userspace
>                                        GOV_START → governor_data alloc'd
>                                        unlock(devfreq_list_lock)
>   simple_ondemand->event_handler
>     (DEVFREQ_GOV_RESUME)
>     → devfreq_monitor_resume()
>         stop_polling == true → re-queue work  ← stray monitor!
>         stop_polling = false
> 
> devfreq_monitor is now queued with df->governor == userspace. When
> devfreq_remove_device() or governor_store() next calls userspace GOV_STOP,
> userspace_exit() frees governor_data. The stray monitor fires,
> dereferences NULL governor_data, and crashes.
> 
> Call devfreq_monitor_stop() before every GOV_STOP dispatch in the core,
> ensuring the polling work is fully cancelled before any governor tears down
> its private data.  devfreq_monitor_stop() is safe unconditionally:
> IRQ_DRIVEN governors return immediately, polling governors that already
> call it in their own GOV_STOP handler make the second call a no-op
> (stop_polling already true), and governors that never polled get a harmless
> cancel_delayed_work_sync() on an empty queue.
> 
> Four sites are fixed: devfreq_remove_device(), governor_store(),
> devfreq_remove_governor() (governor module unload), and timer_store()
> (timer-type change performs a GOV_STOP + GOV_START cycle).
> 
> Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/devfreq/devfreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f08fc6966eae..7538f20657b7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -993,9 +993,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  
>  	devfreq_cooling_unregister(devfreq->cdev);
>  
> -	if (devfreq->governor)
> +	if (devfreq->governor) {
> +		devfreq_monitor_stop(devfreq);
>  		devfreq->governor->event_handler(devfreq,
>  						 DEVFREQ_GOV_STOP, NULL);
> +	}
> +
>  	device_unregister(&devfreq->dev);
>  
>  	return 0;
> @@ -1344,6 +1347,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
>  
>  		if (!strncmp(devfreq->governor->name, governor->name,
>  			     DEVFREQ_NAME_LEN)) {
> +			devfreq_monitor_stop(devfreq);
>  			ret = devfreq->governor->event_handler(devfreq,
>  						DEVFREQ_GOV_STOP, NULL);
>  			if (ret) {
> @@ -1416,6 +1420,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	 * Stop the current governor and remove the specific sysfs files
>  	 * which depend on current governor.
>  	 */
> +	devfreq_monitor_stop(df);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> @@ -1863,6 +1868,7 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>  	df->profile->timer = timer;
>  	mutex_unlock(&df->lock);
>  
> +	devfreq_monitor_stop(df);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",

Hi,

I think that need the governor_lock to fix the issue as following.
and initialize devfreq->governor = NULL in devfreq_remove_device()
But I'm not testing it fully. just suggestion.

How about that? and could you test it to fix issue?

 drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++----------
 include/linux/devfreq.h   |  6 +++++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f25304bca37f..814722858c47 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -779,6 +779,7 @@ static void devfreq_dev_release(struct device *dev)
 	if (devfreq->opp_table)
 		dev_pm_opp_put_opp_table(devfreq->opp_table);
 
+	mutex_destroy(&devfreq->governor_lock);
 	mutex_destroy(&devfreq->lock);
 	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
@@ -822,6 +823,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	mutex_init(&devfreq->lock);
+	mutex_init(&devfreq->governor_lock);
 	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
@@ -940,9 +942,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	mutex_lock(&devfreq->governor_lock);
 	devfreq->governor = governor;
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
+	mutex_unlock(&devfreq->governor_lock);
 	if (err) {
 		dev_err_probe(dev, err,
 			"%s: Unable to start governor for the device\n",
@@ -991,9 +995,14 @@ int devfreq_remove_device(struct devfreq *devfreq)
 
 	devfreq_cooling_unregister(devfreq->cdev);
 
-	if (devfreq->governor)
+	mutex_lock(&devfreq->governor_lock);
+	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
+		/* Prevent a later suspend/resume from reaching the governor */
+		devfreq->governor = NULL;
+	}
+	mutex_unlock(&devfreq->governor_lock);
 	device_unregister(&devfreq->dev);
 
 	return 0;
@@ -1152,12 +1161,16 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 	if (atomic_inc_return(&devfreq->suspend_count) > 1)
 		return 0;
 
+	mutex_lock(&devfreq->governor_lock);
 	if (devfreq->governor) {
 		ret = devfreq->governor->event_handler(devfreq,
 					DEVFREQ_GOV_SUSPEND, NULL);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&devfreq->governor_lock);
 			return ret;
+		}
 	}
+	mutex_unlock(&devfreq->governor_lock);
 
 	if (devfreq->suspend_freq) {
 		mutex_lock(&devfreq->lock);
@@ -1197,12 +1210,16 @@ int devfreq_resume_device(struct devfreq *devfreq)
 			return ret;
 	}
 
+	mutex_lock(&devfreq->governor_lock);
 	if (devfreq->governor) {
 		ret = devfreq->governor->event_handler(devfreq,
 					DEVFREQ_GOV_RESUME, NULL);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&devfreq->governor_lock);
 			return ret;
+		}
 	}
+	mutex_unlock(&devfreq->governor_lock);
 
 	return 0;
 }
@@ -1337,10 +1354,9 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		int ret;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!devfreq->governor)
-			continue;
-
-		if (!strncmp(devfreq->governor->name, governor->name,
+		mutex_lock(&devfreq->governor_lock);
+		if (devfreq->governor &&
+		    !strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_STOP, NULL);
@@ -1351,6 +1367,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 			}
 			devfreq->governor = NULL;
 		}
+		mutex_unlock(&devfreq->governor_lock);
 	}
 
 	list_del(&governor->node);
@@ -1398,16 +1415,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		ret = PTR_ERR(governor);
 		goto out;
 	}
+
+	mutex_lock(&df->governor_lock);
 	if (!df->governor)
 		goto start_new_governor;
 
 	if (df->governor == governor) {
 		ret = 0;
-		goto out;
+		goto out_unlock;
 	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
 		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
 		ret = -EINVAL;
-		goto out;
+		goto out_unlock;
 	}
 
 	/*
@@ -1418,7 +1437,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
 			 __func__, df->governor->name, ret);
-		goto out;
+		goto out_unlock;
 	}
 
 start_new_governor:
@@ -1436,7 +1455,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		/* Restore previous governor */
 		df->governor = prev_governor;
 		if (!df->governor)
-			goto out;
+			goto out_unlock;
 
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
@@ -1444,7 +1463,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 				"%s: reverting to Governor %s failed (%d)\n",
 				__func__, prev_governor->name, ret);
 			df->governor = NULL;
-			goto out;
+			goto out_unlock;
 		}
 	}
 
@@ -1454,6 +1473,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 */
 	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
 
+out_unlock:
+	mutex_unlock(&df->governor_lock);
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -1831,6 +1852,7 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 	int ret = 0, i;
 
 	guard(mutex)(&devfreq_list_lock);
+	guard(mutex)(&df->governor_lock);
 
 	if (!df->governor || !df->profile ||
 	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index dc1075dc3446..f5a795f1ad77 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -144,6 +144,11 @@ struct devfreq_stats {
  * @node:	list node - contains the devices with devfreq that have been
  *		registered.
  * @lock:	a mutex to protect accessing devfreq.
+ * @governor_lock:	a mutex to serialize governor switching (STOP,
+ *		@governor update and START) against DEVFREQ_GOV_SUSPEND and
+ *		DEVFREQ_GOV_RESUME dispatch. Lock order: devfreq_list_lock ->
+ *		@governor_lock -> @lock. It must not be taken while holding
+ *		@lock.
  * @dev:	device registered by devfreq class. dev.parent is the device
  *		using devfreq.
  * @profile:	device-specific devfreq profile
@@ -185,6 +190,7 @@ struct devfreq {
 	struct list_head node;
 
 	struct mutex lock;
+	struct mutex governor_lock;	/* see kernel-doc above */
 	struct device dev;
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
-- 
2.43.0


-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
