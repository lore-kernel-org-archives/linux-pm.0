Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870730;
	b=c2en6IwcvxnCcO3UNCClvRLrMJzu4aD7Iwtk1UMQe/7oX9UsaFQ4oq6liHZcCfNxi0n+
	 sTP90LDk1Gu2Vd3qzbpcXMkFZ3KY8pzwaMUuHndwDlOzIbsoJ5BpFwvjZq/G/bPDHyb/2
	 6yYSIHAm5axqZrcuRkiVdIeVCW8+zOWfWsU8vO8lIhEHFa4DPMpCdvginh000GX0XGLyi
	 w4x0+aR54U4jg32TSUK53fY5N3r1BNwrD0TETJLyfNHgAR1F4AEUtSPqtuecGkQVbvAoh
	 j5Z1gnt0yXXCkuQQbbQQ022e7trKPT7cDACBcH0k6u96MOJ6BRLPXUtR7VjV1EhSt2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=P6zFTL/LU2JpzSrp2Ia7UbUFXgPIzj2fzsJ8jro1fk8=;
	b=4wKOKc1eV4mGcduAZwNLfWoo+2YB3ELJm/pGr4qxRG3qMMPVrVnvdWGAwKAzT7pyGiX7
	 UeFE9eeG1nyxWud9kRUSEodTaoSiXqRYJ03XxcojtcaA+fqEMrYnOIi2UjtLfmsSLXRbB
	 NMKccdtHsK4pu/7gOYM6naKGK3HNSEiXipljygK0+O1G7DuIIueZRHgVA8IUE+F3SdMmS
	 U2lIW+5HUmRxuSeC58Ddqm7tkDFgu7XlTSjOd7SLLKotG+tU0VIC9CM132dQl5JP3Bg8P
	 VHGVcKu3y1iIoc4w8GLQS8Q4n/DbsJEetJeO3/4KgeuCFA+lkXvDZUL12R40VgALnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BspFyi6Z;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D173606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 23:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D173606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BspFyi6Z
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36f8cdd30beso6595652eec.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 15:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870729; x=1795475529; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6zFTL/LU2JpzSrp2Ia7UbUFXgPIzj2fzsJ8jro1fk8=;
        b=BspFyi6ZG4y4Q59eNwKP3RdxlN0hZJkzJM3aRFKM1pHT4fuPLFyQ/EioSbn7PwtfiH
         YYmXVDs9U7YpTpQN/g+CtNfbHFdGGhwRl0erOhQ81LsZNebv8o1qqmvTO9gudW7Iro0X
         XqQcfkgTz2R+UCxGcj2Kqyw1KlhuDJiL7YE8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870729; x=1795475529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P6zFTL/LU2JpzSrp2Ia7UbUFXgPIzj2fzsJ8jro1fk8=;
        b=YDVdnvBuI+yE7171TmeQmTNn5yxCXKg5M5HqdKI0DXLN0esE13wHEWNwjAtZK/kYnj
         634GisKrfiKGEDMIRW+BSwd6z7arFBbK/HWe3uVlPq9NLLWGQPzaTQpNWslgucTuF8ty
         Y/5MgexV3xpnYtqQxdPpaeXkoUbqBproP+2ni/kXXeZBEXCeEDUB5qmrdSl/I1NEV8a0
         USUjQrq7Q3/rvMTRP/cHmE6oyjj7EMRybxc00D6Fe/4a6c0jvD8t/Q76SgiGHjDqiqV1
         KtOfCx+zaT1CeSk2U3jpByR4ryrU5lPZv+pI+S+rVATMWVWo8CxckMcohxe9mWKKMkXH
         qZgQ==
X-Gm-Message-State: APuU4Z/1LSSFeWvcDnm+oDqI18gSZIMikrayDmJCSQ9BPUTJeS4Incer
	AZC2YC5o+REd+Yp9mYt9WT8qe+ppXl4JKk/aLkejn9WpoYkQLs8sdRClyldKfYXH3g==
X-Gm-Gg: AYBFou3p/5cGA/j7Bsb8pBke47eAqdRlr7cUnAfL7fD3uCp6bOaLODcNXkgaYRZAZ/b
	XOr7e2J5u8ZuqkeHn3kMRsh0tznANW/8eZZxg7ZxEkGzD087SA55m5f2SlIOoqMQahKOQVOEtyF
	lXTxZMeqqy4zyeCvRZ8ocFPLzxCQvcx7aACA6LQ8BwhMky42KtGFxUbhkYqf2GnnX4U+QAcEZ55
	cp/a71+Dg+79S8PXVJ93OMv8t5DOvTdxM+rdKG0xIEgb+/fZ/JXaz25TFjvATd/+3+J904fC6We
	pwtqF8dOaPSDAUexlPlKAi2gq0kcFpzMNx89cxo4ep4d9SmJQ0JDJNrgxTNWteOa8HtyuSoy184
	hig9J9/lBhojRi9iqHQjZL1hx4TpIyO0rJRiKe2VRUHwHUr8kBN3xKnEnvzrsmh4Ws1E3b+kxw6
	K60wCCiXXLqlDoecOXkMmhAkrSqrczbTazcW0Xfmiw2KVhywCmHGNHhDwHO6O96aA/zKcUrAmci
	74y/p6saDGfm7RfEbLF/8cDcpFi77k8LRiJyDAs0fO/5Yv80Dd/ktp/7aAb2pn7Q182LAwQnsBX
	/PrKxsvUl0dYrqKZVkIKV7puC1MBVPLRBlSwRRXmia5W4Lspn8Kn9CXs+Diha0aOnjE=
X-Received: by 2002:a05:693c:41c7:20b0:371:ede8:3e9b with SMTP id 5a478bee46e88-379680cf32amr11739248eec.36.1794870728428;
        Mon, 16 Nov 2026 15:12:08 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:264:3904:fc3a:a69a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-379565d269asm40883461eec.23.2026.11.16.15.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:12:07 -0800 (PST)
Date: Mon, 16 Nov 2026 15:12:05 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy before calling
 rpm_suspend() in rpm_idle()
Message-ID: <avuNxXw7YZ4ZeO-1@google.com>
References: <4789427.LvFx2qVVIh@rafael.j.wysocki>
 <aveybY5Z9OWQYkRS@google.com>
 <CAJZ5v0h3Q3ySm0BmHG80QAQReV-6mbj2A0J5cSG1Pwc_ziGyDw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h3Q3ySm0BmHG80QAQReV-6mbj2A0J5cSG1Pwc_ziGyDw@mail.gmail.com>

On Sun, Nov 15, 2026 at 06:35:04PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Sat, Nov 14, 2026 at 1:59 AM Brian Norris <briannorris@chromium.org> wrote:
> > Is it worthwhile to note (or at least hint at) how many other things
> > change along with this? e.g., how pm_runtime_allow() (and therefore
> > auto > control/power), all non-autosuspend pm_runtime_put() variants,
> > etc, also extend the autosuspend timer? I think we agreed these are
> > acceptable effects, and likely even desireable, but I'd say these are
> > fairly major changes.
> 
> Fair enough, I'll add the following to the changelog when applying the patch:
> 
> "This potentially changes observable behavior in all situations in
> which pm_runtime_put(), pm_runtime_put_sync(), pm_runtime_idle(), or
> pm_request() idle is used on a device with an autosuspend delay.  That

nit: you split "pm_request_idle()" oddly

> includes changing a device's "power/control" sysfs attribute value
> from "on" to "auto" (if there are no other active runtime PM
> references to the given device), accessing PCI configuration space
> from user space etc.  Namely, in all of those cases, the runtime
> suspend of the device following the runtime PM helper call (if it
> causes a runtime suspend to occur) will be deferred by the full
> autosuspend delay, which arguably is more consistent and predictable
> than deferring the runtime suspend in question by a more-or-less
> unknown (and basically random) time depending on when the most recent
> update of the device's last_busy timestamp has occurred.
> 
> It will also cause the majority of the direct
> pm_runtime_mark_last_busy() calls to become redundant, and they will
> be taken care of later."

Seems good, thanks! Who knows if anybody will actually read the
changelogs, but at least it leaves a paper trail for future cleanups
that will likely reference this change.

> > In any case, the change looks good to me:
> >
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Thank you!
> 
> > I meant to make time to test this out a bit more, but ran out; maybe
> > next week.
> 
> That will be much appreciated.

OK, I made some time:

Tested-by: Brian Norris <briannorris@chromium.org>

It tests out well (passing) with:

(a) the KUnit tests that try to imitate the stm32-adc parent/child
    structure from commit c537d3457542 [1]

(b) my original KUnit test [2]. I've appended a slightly-updated v3, in
    case you want to merge it

(c) some targeted PCIe tests on Pixel phones. Specifically, I see that
    the portdrv.c 100ms autosuspend delay is now consistently applied
    after both lspci (this used to work OK, simply because rpm_resume()
    would also update last_busy) and after endpoint suspend (this
    previously did not apply the autosuspend delay, as the endpoint
    tended to stay active for a long time)

Thanks,
Brian

[1] https://lore.kernel.org/all/auzlLwlleGLPsLcw@google.com/
    This test is inherently timing sensitive and therefore flaky. It
    just serves as an example, not something to commit.

[2] [PATCH v2 4/5] PM: runtime: Add tests for last_busy propagation
    https://lore.kernel.org/all/20261103141442.v2.4.I8ab8b7f662fe1921c7084a47d554535597cc2702@changeid/



From: Brian Norris <briannorris@chromium.org>
Date: Thu, 1 Oct 2026 11:53:49 -0700
Subject: [PATCH v3] PM: runtime: Add tests for dependency last_busy update

This is a regression test for the problem fixed in "PM: runtime: Update
last_busy before calling rpm_suspend() in rpm_idle()", ensuring that
when a child or consumer suspends, the corresponding parent or supplier
autosuspend timer expiration increases.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 * Minor style changes
 * Target
     "PM: runtime: Update last_busy before calling rpm_suspend() in
      rpm_idle()"
   instead of prior patch
     "PM: runtime: Propagate last_busy from dependent to dependency"
   (both solve the same problem)

Changes in v2:
 * Use device_move() instead of manual re-parenting
 * fsleep() instead of msleep()

 drivers/base/power/runtime-test.c | 103 ++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 24865ce844fc..685a3504cd7b 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
 #include <kunit/device.h>
@@ -285,6 +286,106 @@ static void pm_runtime_supplier_suspend_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(norpm_supplier));
 }
 
+static void pm_runtime_parent_last_used_test(struct kunit *test)
+{
+	struct device *parent, *dev;
+	u64 expiry1, expiry2;
+
+	parent = kunit_device_register(test, DEVICE_NAME "_parent");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	dev = kunit_device_register(test, DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	KUNIT_ASSERT_EQ(test, 0, device_move(dev, parent, DPM_ORDER_NONE));
+
+	pm_runtime_set_active(parent);
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(parent);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	/* Effectively infinite delay (prevent finishing autosuspend during this test). */
+	pm_runtime_set_autosuspend_delay(parent, 200000);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_mark_last_busy(parent);
+
+	pm_runtime_get_noresume(dev);
+
+	pm_runtime_enable(parent);
+	pm_runtime_enable(dev);
+
+	expiry1 = pm_runtime_autosuspend_expiration(parent);
+	KUNIT_EXPECT_NE(test, 0, expiry1);
+
+	/* Make absolutely sure the clock advances. */
+	fsleep(1000);
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync_autosuspend(dev));
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	/* Flush, in case any request was pending. */
+	flush_workqueue(pm_wq);
+	KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(parent));
+
+	expiry2 = pm_runtime_autosuspend_expiration(parent);
+	KUNIT_EXPECT_NE(test, 0, expiry2);
+	/* The child's last_busy time should have bumped up the parent's expiration. */
+	KUNIT_EXPECT_GT(test, expiry2, expiry1);
+}
+
+static void pm_runtime_supplier_last_used_test(struct kunit *test)
+{
+	struct device *supplier, *dev;
+	u64 expiry1, expiry2;
+
+	supplier = kunit_device_register(test, DEVICE_NAME "_supplier");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supplier);
+
+	dev = kunit_device_register(test, DEVICE_NAME);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	KUNIT_ASSERT_NOT_NULL(test, device_link_add(dev, supplier, DL_FLAG_PM_RUNTIME));
+
+	pm_runtime_set_active(supplier);
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(supplier);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	/* Effectively infinite delay (prevent finishing autosuspend during this test). */
+	pm_runtime_set_autosuspend_delay(supplier, 200000);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_mark_last_busy(supplier);
+
+	pm_runtime_get_noresume(dev);
+
+	pm_runtime_enable(supplier);
+	pm_runtime_enable(dev);
+
+	expiry1 = pm_runtime_autosuspend_expiration(supplier);
+	KUNIT_EXPECT_NE(test, 0, expiry1);
+
+	/* Make absolutely sure the clock advances. */
+	fsleep(1000);
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync_autosuspend(dev));
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	/* Flush, in case any request was pending. */
+	flush_workqueue(pm_wq);
+	KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(supplier));
+
+	expiry2 = pm_runtime_autosuspend_expiration(supplier);
+	KUNIT_EXPECT_NE(test, 0, expiry2);
+	/* The consumer's last_busy time should have bumped up the supplier's expiration. */
+	KUNIT_EXPECT_GT(test, expiry2, expiry1);
+}
+
 static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_depth_test),
 	KUNIT_CASE(pm_runtime_already_suspended_test),
@@ -293,6 +394,8 @@ static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_error_test),
 	KUNIT_CASE(pm_runtime_probe_active_test),
 	KUNIT_CASE(pm_runtime_supplier_suspend_test),
+	KUNIT_CASE(pm_runtime_parent_last_used_test),
+	KUNIT_CASE(pm_runtime_supplier_last_used_test),
 	{}
 };
 
-- 
2.56.1.703.gf848ed807c-goog

