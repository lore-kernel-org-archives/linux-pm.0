Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748080;
	b=zO5ZmeDexpcbzxC24mXHnDK2MNj8XsSOrC0WnpjSFv4qy0PxBp+nYtn5qlI0qC3dL0df
	 ntmA8QZwK2cvAGE2rsDjiSzrK0SiMzWrZiBEIzg7wQfsr3FY2hdWeb9rgP6FLH9/cMbcc
	 CN3X6TU1zmg4xGV8F0H5rexSw9BjuxN3nj5/1HBBaHUzWZMJND1ArxzsF2/2FIbiwUXnn
	 d+iqvrsUZIy3GACHp+oAI/hHjVxQU9jqV6R/g0nCgzaf90D2/kXVl8vRaYVRtHYOg1yWR
	 Dq5QYEYfWfUJP3UxFwF5+VPUnHsC62bzn2305QAGo1IN6AMt+w9bINqQNu9e6/70Vfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uiwTdVTEUjpLNHmklGjK4vXL9miCcangUBoZKdOGahQ=;
	b=p7TDUAPj7NZHqOqdbYbvpFYK3VrTh0p3IYRSCG8PvJ0nyvI51EVSvcF9sGO43Z8Qm3qC
	 /BIKHCk/tjP9MxyewyEuviJRJMbPFeJcxHHFNIxM/9piMItR9EkwcPaA84q8AprlUMw6u
	 Y5PJSwR7ljILP7nm+0LbXXTwrDbhqtX0moTAldDmJ7jPtdj/ZZYPtj8W8qD/84Mj96CiV
	 TV6SUZRNAp/6nDzp/ftjngqmKn4Fs5TYH1FDbYxoWbYbLzOHvm6fBDESKz7ikTRIqAkR7
	 hML0GwaK/Xe2hLhcq0A55igS8W83fL7IxE07NdvDtoF6kFh036pcKcpnnPSu8Mq0jww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vbi2mlYP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8278606A31B;
	Tue,  3 Nov 2026 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vbi2mlYP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE871F000C1;
	Tue,  3 Nov 2026 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748079;
	bh=uiwTdVTEUjpLNHmklGjK4vXL9miCcangUBoZKdOGahQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vbi2mlYP+1AVsQu23mY5X6XhrWHW9pgucrNtCCShnFVF9fj2YDVDag2BD+tIo2eWz
	 2TeKja5KiWyu2OLCggSGnGqoIlYWtiaWsBnoUJugT365ucXu8p7W6g+g2ITt3NPtcn
	 tJFekbbIGT+/exTdZEmURyVOv+4UdGtMEMRUZNJetlq977tw6QemhIySUZ6n576wvl
	 IsW+JS1Vr6MdguEVlCYFlKe23sjNLmLPU42TjPPUdKEd+/e/Q7eyu7BrN3Ph+aFVuH
	 QRL8h76NpGRkifrMEXePzlISK2HXtLGYjimpCSSIoXqRfquoaA+WHmHCAfNxFn7Yk8
	 CVwdmg4ZquuHQ==
Date: Tue, 3 Nov 2026 23:21:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Fabrice Gasnier
 <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 4/5] PM: runtime: Add tests for last_busy propagation
Message-ID: <20261103232109.2e334027@jic23-hlaptop>
In-Reply-To: <20261103141442.v2.4.I8ab8b7f662fe1921c7084a47d554535597cc2702@changeid>
References: <20261103221717.3840215-1-briannorris@chromium.org>
	<20261103141442.v2.4.I8ab8b7f662fe1921c7084a47d554535597cc2702@changeid>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 14:14:42 -0800
Brian Norris <briannorris@chromium.org> wrote:

> This is a regression test for the problem fixed in "PM: runtime:
> Propagate last_busy from dependent to dependency".
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Trivial style stuff.

> ---
> 
> Changes in v2:
>  * Use device_move() instead of manual re-parenting
>  * fsleep() instead of msleep()
> 
>  drivers/base/power/runtime-test.c | 99 +++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
> index 24865ce844fc..00ca3b10543a 100644
> --- a/drivers/base/power/runtime-test.c
> +++ b/drivers/base/power/runtime-test.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/cleanup.h>
> +#include <linux/delay.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/workqueue.h>
>  #include <kunit/device.h>
> @@ -285,6 +286,102 @@ static void pm_runtime_supplier_suspend_test(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(norpm_supplier));
>  }
>  
> +static void pm_runtime_parent_last_used_test(struct kunit *test)
> +{
> +	struct device *parent = kunit_device_register(test, DEVICE_NAME "_parent");
> +	struct device *dev = kunit_device_register(test, DEVICE_NAME);

Similar style comment to below.

> +	u64 expiry1, expiry2;
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +
> +	KUNIT_ASSERT_EQ(test, 0, device_move(dev, parent, DPM_ORDER_NONE));
> +
> +	pm_runtime_set_active(parent);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_use_autosuspend(parent);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 0);
> +	/* Effectively infinite delay (prevent finishing autosuspend during this test). */
> +	pm_runtime_set_autosuspend_delay(parent, 200000);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_mark_last_busy(parent);
> +
> +	pm_runtime_get_noresume(dev);
> +
> +	pm_runtime_enable(parent);
> +	pm_runtime_enable(dev);
> +
> +	expiry1 = pm_runtime_autosuspend_expiration(parent);
> +	KUNIT_EXPECT_NE(test, 0, expiry1);
> +
> +	/* Make absolutely sure the clock advances. */
> +	fsleep(1000);
> +
> +	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync_autosuspend(dev));
> +
> +	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +	/* Flush, in case any request was pending. */
> +	flush_workqueue(pm_wq);
> +	KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(parent));
> +
> +	expiry2 = pm_runtime_autosuspend_expiration(parent);
> +	KUNIT_EXPECT_NE(test, 0, expiry2);
> +	/* The child's last_busy time should have bumped up the parent's expiration. */
> +	KUNIT_EXPECT_GT(test, expiry2, expiry1);
> +}
> +
> +static void pm_runtime_supplier_last_used_test(struct kunit *test)
> +{
> +	struct device *supplier = kunit_device_register(test, DEVICE_NAME "_supplier");
> +	struct device *dev = kunit_device_register(test, DEVICE_NAME);
Having the assignment clear of the error check is never great, but now there are multiple
devs, I'd definitely move them.

	struct device *supplier, *dev;

> +	u64 expiry1, expiry2;
> +
	supplier = kunit_device_register(test, DEVICE_NAME "_supplier");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);

	dev = kunit_device_register(test, DEVICE_NAME);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, supplier);

> +
> +	KUNIT_ASSERT_NOT_NULL(test, device_link_add(dev, supplier, DL_FLAG_PM_RUNTIME));
> +
> +	pm_runtime_set_active(supplier);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_use_autosuspend(supplier);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 0);
> +	/* Effectively infinite delay (prevent finishing autosuspend during this test). */
> +	pm_runtime_set_autosuspend_delay(supplier, 200000);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_mark_last_busy(supplier);
> +
> +	pm_runtime_get_noresume(dev);
> +
> +	pm_runtime_enable(supplier);
> +	pm_runtime_enable(dev);
> +
> +	expiry1 = pm_runtime_autosuspend_expiration(supplier);
> +	KUNIT_EXPECT_NE(test, 0, expiry1);
> +
> +	/* Make absolutely sure the clock advances. */
> +	fsleep(1000);
> +
> +	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync_autosuspend(dev));
> +
> +	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> +
> +	/* Flush, in case any request was pending. */
> +	flush_workqueue(pm_wq);
> +	KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(supplier));
> +
> +	expiry2 = pm_runtime_autosuspend_expiration(supplier);
> +	KUNIT_EXPECT_NE(test, 0, expiry2);
> +	/* The consumer's last_busy time should have bumped up the supplier's expiration. */
> +	KUNIT_EXPECT_GT(test, expiry2, expiry1);
> +}
> +
>  static struct kunit_case pm_runtime_test_cases[] = {
>  	KUNIT_CASE(pm_runtime_depth_test),
>  	KUNIT_CASE(pm_runtime_already_suspended_test),
> @@ -293,6 +390,8 @@ static struct kunit_case pm_runtime_test_cases[] = {
>  	KUNIT_CASE(pm_runtime_error_test),
>  	KUNIT_CASE(pm_runtime_probe_active_test),
>  	KUNIT_CASE(pm_runtime_supplier_suspend_test),
> +	KUNIT_CASE(pm_runtime_parent_last_used_test),
> +	KUNIT_CASE(pm_runtime_supplier_last_used_test),
>  	{}
>  };
>  

