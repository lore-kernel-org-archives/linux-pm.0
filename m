Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533324;
	b=M7EJFtXvB2HmDjju9at2O7BvsARHmz6PDTG5Qqf4tEZIKAfm5iDr9YPzBfjeTlE0aKPK
	 v8oVa7wrSQ20ERu4hDsNdiw1jl4xKVFRY3uT9pRvSfhqXLuyEGMFpY1vUTPtYrgk/KsP4
	 1D9XdojmDbuPSPAC+OHhpom7qLgxHPhaUVGWEcr4P0ZOv+n3CReSdNopyZ/rNVJC1ckC+
	 Fx5tJmJTDMRCv4/PbwZly1Nu4hHq6lSDamloCmuXuWKIHHkFK9Bb7tIdL/mtbCYYADvCc
	 M1QbCUPdmo4h2hD1uLdzehfid7oIa31u3PnLPbvGyUl+QbU5VyuLonbcKcrWKjbJwrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533324;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=kKwtJWuJPnB5J10PDRpzntxMxxzAUdKUtxf3uWvcEfA=;
	b=M6bd1Gv4Z7cUAzNAEAETr++obXmmG2oXZjY4p/U1eb0RtnIA9EU0g2E6f0TS7oxj8FQw
	 BpPwCAwPN7kwm2O9TivSi1W1AkYQ4xfJaio69U1U01CkEpRLWj15X7NZxb9YA6/VlNQxv
	 EulQMjDjcwUg2neSR072e1c1kijKBO36ldrG6OQ5w2Kr0qRYe9CI9PEND386EuehyfHbt
	 vXwkNZbOBKrDDHj6ro3e0mJPNq16dnmmMieS4bLq/a9ziOg9lezkCje8rXvqgjMsend0L
	 3m1dK3LWfYD8rRlWVMO4zHq1aoFEqj1qaM9kyrtCsFxU1cmNnaMtA2zv8zjMX9vcD3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=temperror header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=PHUfSbDV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FNB6WpXb;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719D606A31B
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 21:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E719D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=PHUfSbDV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FNB6WpXb
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1314A140015D
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 17:55:21 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 17:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1792533317;
	 x=1792619717; bh=kKwtJWuJPnB5J10PDRpzntxMxxzAUdKUtxf3uWvcEfA=; b=
	PHUfSbDVeUPap5reYr5mWoZV+jl5WMwpqnzqT0bdjbCbFGgeZHIbwvSwgL2hLpMm
	IErogJ/61/R9pn/JZbVrP6WqQH5LTfDn887X5PWyomwrKYDdBo9w4cFqjaICqWaZ
	sjtXVWNtdEuFqTT7Q8rQ9ZUojF4jlP/dZ0GyviwnniEBktqAz/qCu0V1HMDgZ+rN
	PBwbV5igNO9/EyEwaVqTpbMU9jI2mueAk416ss1JfwimHR8B/BCgDJ/3eSgjL5F9
	aQ0aUt/qjOQlMTQg9D7gk2WHZm7RSub2Mp6Cp4uyPEhUGbTIuvBmUQIqUvU7MZZ6
	gPt7cvpHemVueIdv/4Jauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792533317; x=
	1792619717; bh=kKwtJWuJPnB5J10PDRpzntxMxxzAUdKUtxf3uWvcEfA=; b=F
	NB6WpXbJTZeZCebNLe79TyjyoUYrmTxOiKrJhHEE4UqG/5wUMkjmOFt/K6uiLg6E
	C9m78WNk2wQQteNLHJbcnhIgFS88ifCx24C8eSwet+b/TiC2VtHOc0vcjTZ2eLsT
	W/rsoIl1h1QQqjTBv3+M3HB1J82qtH5zhamPbebTINaYl6ChXD6TWDWHsKNaOuD5
	qkuAu9shpi8FGm/mCpccJTY7Kb59nGYrEkplIOsovetlSS0X65mWGfYEPD+gI4pD
	zAtP+5Q382EwvP8JNkCCsmf9+MFU7KBY2Hvew0mI1bfWKM0XtqxSxWJh6LLZqKHr
	I7GzZ1erVd6PDflaFs8KA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792533317; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:KHlxNvki/nxiRHGfuRwOekplNEnpyHvNRrHjuXDJQ1hgtFn
	jfoCPjA68wkNz0IGDZGY5QssDFjALvu2+WM7GK7tBUd6dSNlpuAhpXvjYiVL+H9l
	XESF2tAXKmRl04+hwjNypDwZ6yZXcR7g2eQV/nYJCSU7bSDLxShl0VWhVZyteqjr
	ssx/Lpu068yeUSeDo3ofzVkWsrPPWS1CvYLi+1IhqaUNPmGOQQGxesS3Rfcfdtmo
	T6jOzX4MXXcQUv+NaImiMNBQdI08kNizYLGusPFKT71q5Xf+Auw+h6zya44v4WAM
	O2a+6zGZtYZrFGB+Th9r8SipTQuk0K55XgMADeg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+yOQjQ6zXwRbJ+kN8rcSInQA4bMulg0f4PEqkTuqIiQ=:NI2fXuKCJ44j/5aG07kT0zNKWgQIFH5UQn9ZfhyNfTI=;
X-ME-Sender: <xms:Q-PXagx1bKs4N4aOLmCRBtvgZPOu68EzT95T3F76RjekBo2LRmOn6A>
    <xme:Q-PXavFx9ZhlojmrgXI28-scfv6vQPH00hd-7pQUeJVvpHscg1-Zjx1GHmB62tlCg
    DiBOt5mCikqBbuhj4XkBz6kyEPd_gXdYG3sR1iUp7OeMaJTpddexm-bXg>
X-ME-Proxy-Cause: dmFkZTFZV6kkUrn0Shef1bYJCjdKRM6Xsss50sZJQtfMZJNXzy8lPQuJxVRlkniLikOuNH
    h7IREj3Djkq8ksTarpB352xDwUMTcN/3OUDaU6IxiHYP14BA8lLLSOVxQodBj7zEqxaGAz
    sNJL0wx125zXHaIvCG8l+SwCH9Yo4YrytlFfPHf6BwVgakHut7ouYVNfkolvMZvWAW5H+F
    FN9nYYxM5iDVsxvQiufvGRVavdmar8TzX4AFXs+jau2xv1JEWK5KEcy5yZi4bBPgx+hkA0
    FhZFTxoCQa4utbjJLeiuQ8vc6gWYnCBKuQx/zsNf8iRNlck7MoLmjdCmHCrXOOClP7aDaS
    EfFr35X6sdQWoFhWAxHnGyS1Fy/ZkSxPhowtsclla6spOn58x+QtkcuFzNLqJqNFYBV2XA
    L+6YMFR66aZlray3a1sNpJMyXFbrb47R4IKzqoPtejxl3aTL/sbbRF3YdL7H7Wu7NZ5oWl
    pBFIxKYTHdWpD9gYMv/FRVFVIWvnFUrrULfveN1K5LnkD1RQBAxJDdww4ia6crMidLff/k
    SvBfSplPkSwvkD5M3XxcuvLcofX10wvPDtbV/boNQP1eO0PX9HjnGd5s8pGQSlNonmr+AN
    MPIyOJb5CD442iuo2h96UH79g8e4KV58AFpDJOmcprWByCxJlfnafAqT708w
X-ME-Proxy: <xmx:Q-PXaoxIRJnAUQ0yC-f-RnQ8N6VWkjDk2-wFMrJTvx1S6SfItjj5Xg>
    <xmx:Q-PXalndrtWC17akR1Bqe40LUf8SHXPT-Y01V2eXzKi8DWM5SSc9vQ>
    <xmx:Q-PXaiWeL5zJEvgiTe_z2xcIENRSPIXD6npRQeh2djIWOwJMNreOpQ>
    <xmx:Q-PXagPzhmxk5FFuDMckODuiM8wdIa55579FeOwFeGYMMYxsZR2wwA>
    <xmx:RePXagAGQn86p4ijSb-ECYhhi8MhT3Syj45YGTZKEuDJKVtcrcrYXP8e>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id ADF422C0007E; Tue, 20 Oct 2026 17:55:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AqFACRUlSr37
Date: Tue, 20 Oct 2026 17:54:55 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Daniel Lezcano" <daniel.lezcano@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Len Brown" <lenb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Jai Luthra" <jai.luthra@ideasonboard.com>,
 "Greg KH" <gregkh@linuxfoundation.org>,
 "Mario Limonciello" <superm1@kernel.org>, "Jack Wu" <jackbb_wu@compal.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Zhang DM" <jixianqiang1540@gmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Message-Id: <647d10df-72bc-4c08-96e4-045a387d54f9@app.fastmail.com>
In-Reply-To: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com>
References: <20261020144525.3265851-1-daniel.lezcano@oss.qualcomm.com>
Subject: Re: [PATCH v3] platform profile: Separate handler locking from sysfs lifetime
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2026, at 10:45 AM, Daniel Lezcano wrote:
> Registration and removal currently hold profile_lock across
> device_unregister() and sysfs_update_group(). These operations can remove
> sysfs attributes and wait for their active callbacks to finish. The
> profile read and write callbacks acquire profile_lock themselves, so a
> concurrent access can deadlock:
>
>   Removal/update path             Active sysfs callback
>   -------------------             ---------------------
>   acquire profile_lock            hold kernfs active reference
>   remove a sysfs attribute         wait for profile_lock
>   wait for its active references
>
> The removal path cannot finish until the callback returns, and the
> callback cannot return until the removal path releases profile_lock.
> This applies both to per-provider device teardown and to updates of the
> legacy aggregate attribute group.
>
> Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
> platform_profile_remove()") previously fixed this lock ordering by moving
> sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
> platform_profile: Use guard(mutex) for register/unregister") reintroduced
> the issue by extending the mutex guard over sysfs_remove_group(). Later,
> commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> platform profile") replaced that teardown with device_unregister() and
> sysfs_update_group(), still under the same mutex, extending the problem
> to class-device teardown and aggregate attribute updates.
>
> Simply dropping profile_lock around these operations is insufficient.
> Aggregate operations currently discover providers through the class
> device list. A provider being unregistered could therefore still be
> selected for an aggregate read, write or cycle while its sysfs files are
> being torn down. Concurrent registrations and removals would also race
> when updating aggregate attribute visibility.
>
> Introduce profile_registration_lock to serialize registration, removal
> and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
> Retain profile_lock for profile operations and use it to protect an
> explicit list of handlers participating in the aggregate interface.
>
> Add a handler to that list only after device_register() succeeds. On
> removal, unlink it under profile_lock before calling device_unregister().
> Acquiring profile_lock first waits for any aggregate operation already
> using the handler to complete; unlinking prevents later aggregate
> operations from finding it. Release profile_lock before draining sysfs
> callbacks, allowing active per-provider callbacks to complete before the
> device is released. Apply the same unlink-before-unregister ordering to
> registration error cleanup.
>
> Walk this list for aggregate reads, writes and profile cycling, and use
> its emptiness to determine aggregate attribute visibility. The class
> devices remain the per-provider userspace interface.
>
> There can now be an interval between removing the last handler from the
> list and removing the aggregate attributes. Explicitly reject choices
> reads and writes during that interval: the intersection bitmap starts
> with every bit set, so an empty traversal must not advertise all profiles
> or report a successful write without updating a provider.
>
> This separates aggregate membership from class device teardown while
> preserving the existing class and ACPI sysfs interfaces.
>
> Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for 
> register/unregister")
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v3:
>   - Send the locking fix as a standalone patch, independently of the
>     firmware-agnostic extraction and legacy-interface deprecation 
> series.
>   - Document that profile_lock protects handler-list membership and
>     serializes profile operations against each other and handler 
> removal.
>     Explain why it must not be held across sysfs teardown.
>
> Changes in v2:
>   - Expand the deadlock and handler-lifetime explanation.
>   - Add the Fixes tag and describe the earlier fix, regression and later
>     extension to class-device teardown and sysfs group updates.
>
>  drivers/acpi/platform_profile.c | 80 ++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 79d2e92e5c28..d79080a20e21 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -8,15 +8,25 @@
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/init.h>
> +#include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> 
>  #define to_pprof_handler(d)	(container_of(d, struct 
> platform_profile_handler, dev))
> 
> +/*
> + * Protects profile_handlers membership and serializes profile 
> operations
> + * against each other and handler removal. Never held across sysfs 
> teardown,
> + * which can wait for callbacks that acquire this lock.
> + */
>  static DEFINE_MUTEX(profile_lock);
> +/* Serialize registration and sysfs updates without blocking sysfs 
> callbacks. */
> +static DEFINE_MUTEX(profile_registration_lock);
> +static LIST_HEAD(profile_handlers);
> 
>  struct platform_profile_handler {
> +	struct list_head node;
>  	const char *name;
>  	struct device dev;
>  	int minor;
> @@ -44,6 +54,22 @@ static_assert(ARRAY_SIZE(profile_names) == 
> PLATFORM_PROFILE_LAST);
> 
>  static DEFINE_IDA(platform_profile_ida);
> 
> +static int profile_walk_handlers(void *data,
> +				 int (*fn)(struct device *dev, void *data))
> +{
> +	struct platform_profile_handler *handler;
> +	int ret;
> +
> +	lockdep_assert_held(&profile_lock);
> +	list_for_each_entry(handler, &profile_handlers, node) {
> +		ret = fn(&handler->dev, data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * _commmon_choices_show - Show the available profile choices
>   * @choices: The available profile choices
> @@ -306,20 +332,18 @@ static ssize_t 
> platform_profile_choices_show(struct kobject *kobj,
>  	int err;
> 
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &data, _aggregate_choices);
> +		err = profile_walk_handlers(&data, _aggregate_choices);
>  		if (err)
>  			return err;
>  		if (data.count == 1) {
> -			err = class_for_each_device(&platform_profile_class, NULL,
> -						    &data, _remove_hidden_choices);
> +			err = profile_walk_handlers(&data, _remove_hidden_choices);
>  			if (err)
>  				return err;
>  		}
>  	}
> 
>  	/* no profile handler registered any more */
> -	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
> +	if (!data.count || bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
>  		return -EINVAL;
> 
>  	return _commmon_choices_show(data.aggregate, buf);
> @@ -384,8 +408,7 @@ static ssize_t platform_profile_show(struct kobject *kobj,
>  	int err;
> 
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &profile, _aggregate_profiles);
> +		err = profile_walk_handlers(&profile, _aggregate_profiles);
>  		if (err)
>  			return err;
>  	}
> @@ -423,15 +446,13 @@ static ssize_t platform_profile_store(struct 
> kobject *kobj,
>  		return -EINVAL;
> 
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		ret = class_for_each_device(&platform_profile_class, NULL,
> -					    &data, _aggregate_choices);
> +		ret = profile_walk_handlers(&data, _aggregate_choices);
>  		if (ret)
>  			return ret;
> -		if (!test_bit(i, data.aggregate))
> +		if (!data.count || !test_bit(i, data.aggregate))
>  			return -EOPNOTSUPP;
> 
> -		ret = class_for_each_device(&platform_profile_class, NULL, &i,
> -					    _store_and_notify);
> +		ret = profile_walk_handlers(&i, _store_and_notify);
>  		if (ret)
>  			return ret;
>  	}
> @@ -450,22 +471,11 @@ static struct attribute *platform_profile_attrs[] = {
>  	NULL
>  };
> 
> -static int profile_class_registered(struct device *dev, const void 
> *data)
> -{
> -	return 1;
> -}
> -
>  static umode_t profile_class_is_visible(struct kobject *kobj, struct 
> attribute *attr, int idx)
>  {
> -	struct device *dev;
> -
> -	dev = class_find_device(&platform_profile_class, NULL, NULL, 
> profile_class_registered);
> -	if (!dev)
> -		return 0;
> -
> -	put_device(dev);
> +	guard(mutex)(&profile_lock);
> 
> -	return attr->mode;
> +	return list_empty(&profile_handlers) ? 0 : attr->mode;
>  }
> 
>  static const struct attribute_group platform_profile_group = {
> @@ -502,8 +512,7 @@ int platform_profile_cycle(void)
>  	int err;
> 
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &profile, _aggregate_profiles);
> +		err = profile_walk_handlers(&profile, _aggregate_profiles);
>  		if (err)
>  			return err;
> 
> @@ -512,8 +521,7 @@ int platform_profile_cycle(void)
>  		    profile == PLATFORM_PROFILE_LAST)
>  			return -EINVAL;
> 
> -		err = class_for_each_device(&platform_profile_class, NULL,
> -					    &data, _aggregate_choices);
> +		err = profile_walk_handlers(&data, _aggregate_choices);
>  		if (err)
>  			return err;
> 
> @@ -525,8 +533,7 @@ int platform_profile_cycle(void)
>  					  PLATFORM_PROFILE_LAST,
>  					  profile + 1);
> 
> -		err = class_for_each_device(&platform_profile_class, NULL, &next,
> -					    _store_and_notify);
> +		err = profile_walk_handlers(&next, _store_and_notify);
> 
>  		if (err)
>  			return err;
> @@ -583,7 +590,7 @@ struct device *platform_profile_register(struct 
> device *dev, const char *name,
>  		}
>  	}
> 
> -	guard(mutex)(&profile_lock);
> +	guard(mutex)(&profile_registration_lock);
> 
>  	/* create class interface for individual handler */
>  	minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> @@ -604,6 +611,8 @@ struct device *platform_profile_register(struct 
> device *dev, const char *name,
>  		put_device(ppdev);
>  		goto cleanup_ida;
>  	}
> +	scoped_guard(mutex, &profile_lock)
> +		list_add_tail(&to_pprof_handler(ppdev)->node, &profile_handlers);
> 
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 
> @@ -614,6 +623,8 @@ struct device *platform_profile_register(struct 
> device *dev, const char *name,
>  	return ppdev;
> 
>  cleanup_cur:
> +	scoped_guard(mutex, &profile_lock)
> +		list_del(&to_pprof_handler(ppdev)->node);
>  	device_unregister(ppdev);
> 
>  cleanup_ida:
> @@ -636,7 +647,10 @@ void platform_profile_remove(struct device *dev)
> 
>  	pprof = to_pprof_handler(dev);
> 
> -	guard(mutex)(&profile_lock);
> +	guard(mutex)(&profile_registration_lock);
> +
> +	scoped_guard(mutex, &profile_lock)
> +		list_del(&pprof->node);
> 
>  	ida_free(&platform_profile_ida, pprof->minor);
>  	device_unregister(&pprof->dev);
>
> base-commit: d0cd1e850e1602729dd60dc3c5fd96f80e0cdc5d

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
