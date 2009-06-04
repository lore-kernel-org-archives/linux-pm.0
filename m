From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 02:06:24 -0700
Message-ID: <20090604020624.4d39e0a3.akpm__20613.7196314105$1244106529$gmane$org@linux-foundation.org>
References: <4A278C08.5000206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A278C08.5000206@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>
List-Id: linux-pm@vger.kernel.org

On Thu, 04 Jun 2009 17:55:36 +0900 Minkyu Kang <mk7.kang@samsung.com> wrote:

> +	INIT_DELAYED_WORK_DEFERRABLE(&chip->work, max17040_work);
> +	schedule_delayed_work(&chip->work, MAX17040_DELAY);
> +
> +	bat_ps.properties = max17040_battery_props;
> +	bat_ps.num_properties = ARRAY_SIZE(max17040_battery_props);
> +
> +	ret = power_supply_register(&client->dev, &bat_ps);
> +	if (ret) {
> +		dev_err(&max17040->client->dev,
> +				"failed: power supply register\n");
> +		cancel_delayed_work(&chip->work);
> +		i2c_set_clientdata(client, NULL);
> +		kfree(chip);
> +		max17040 = NULL;
> +		return -1;
> +	}
> +
> +	return 0;
> +}

Wouldn't it be better to start the delayed_work after the
power_supply_register() has succeeded?
