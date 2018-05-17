From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/8] firmware: arm_scmi: rename scmi_xfer_{init,get,put}
Date: Thu, 17 May 2018 09:38:03 +0100
Message-ID: <20180517093803.00003dce@huawei.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
 <1525885634-22348-5-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525885634-22348-5-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 9 May 2018 18:07:10 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> Just after the initial patches were queued, Jonathan Cameron mentioned
> that scmi_one_xfer_{get_put} were not very clear and suggested to use
> scmi_xfer_{alloc,free}. While I agree to some extent, the reason not to
> have alloc/free as these are preallocated buffers and these functions
> just returns a reference to free slot in that preallocated array.
> However it was agreed to drop "_one" as it's implicit that we are always
> dealing with one slot anyways.
> 
> This patch updates the name accordingly dropping "_one" in both {get,put}
> functions. Also scmi_one_xfer_init is renamed as scmi_xfer_get_init to
> reflect the fact that it gets the free slots and then initialise it.
> 
> Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Sudeep,

Mostly fine, but one block of comment change that is unrelated has snuck
into this patch.  I think it should be in the earlier kernel-doc fix
up patch.

You have also been a little inconsistent on whether to add blank lines
before return ret statements.  This is really trivial so up to you on
whether to fix that up in v2.

With the doc line moved to the other patch.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/firmware/arm_scmi/base.c    | 23 +++++++++++++----------
>  drivers/firmware/arm_scmi/clock.c   | 24 ++++++++++++------------
>  drivers/firmware/arm_scmi/common.h  |  4 ++--
>  drivers/firmware/arm_scmi/driver.c  | 20 ++++++++++----------
>  drivers/firmware/arm_scmi/perf.c    | 28 ++++++++++++++--------------
>  drivers/firmware/arm_scmi/power.c   | 16 ++++++++--------
>  drivers/firmware/arm_scmi/sensors.c | 20 ++++++++++----------
>  7 files changed, 69 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index c36ded9dbb83..9dff33ea6416 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -37,7 +37,7 @@ static int scmi_base_attributes_get(const struct scmi_handle *handle)
>  	struct scmi_msg_resp_base_attributes *attr_info;
>  	struct scmi_revision_info *rev = handle->version;
>  
> -	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
>  				 SCMI_PROTOCOL_BASE, 0, sizeof(*attr_info), &t);
>  	if (ret)
>  		return ret;
> @@ -49,7 +49,7 @@ static int scmi_base_attributes_get(const struct scmi_handle *handle)
>  		rev->num_agents = attr_info->num_agents;
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  
>  	return ret;
>  }
> @@ -81,7 +81,7 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
>  		size = ARRAY_SIZE(rev->vendor_id);
>  	}
>  
> -	ret = scmi_one_xfer_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
> +	ret = scmi_xfer_get_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
>  	if (ret)
>  		return ret;
>  
> @@ -89,7 +89,8 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
>  	if (!ret)
>  		memcpy(vendor_id, t->rx.buf, size);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
> +
>  	return ret;
>  }
>  
> @@ -110,7 +111,7 @@ scmi_base_implementation_version_get(const struct scmi_handle *handle)
>  	struct scmi_xfer *t;
>  	struct scmi_revision_info *rev = handle->version;
>  
> -	ret = scmi_one_xfer_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
> +	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
>  				 SCMI_PROTOCOL_BASE, 0, sizeof(*impl_ver), &t);
>  	if (ret)
>  		return ret;
> @@ -121,7 +122,8 @@ scmi_base_implementation_version_get(const struct scmi_handle *handle)
>  		rev->impl_ver = le32_to_cpu(*impl_ver);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
> +
>  	return ret;
>  }
>  
> @@ -144,7 +146,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
>  	u32 tot_num_ret = 0, loop_num_ret;
>  	struct device *dev = handle->dev;
>  
> -	ret = scmi_one_xfer_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
> +	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
>  				 SCMI_PROTOCOL_BASE, sizeof(*num_skip), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -173,7 +175,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
>  		tot_num_ret += loop_num_ret;
>  	} while (loop_num_ret);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  
>  	return ret;
>  }
> @@ -196,7 +198,7 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
>  	int ret;
>  	struct scmi_xfer *t;
>  
> -	ret = scmi_one_xfer_init(handle, BASE_DISCOVER_AGENT,
> +	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_AGENT,
>  				 SCMI_PROTOCOL_BASE, sizeof(__le32),
>  				 SCMI_MAX_STR_SIZE, &t);
>  	if (ret)
> @@ -208,7 +210,8 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
>  	if (!ret)
>  		memcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
> +

I actually agree that it is sensible to drop this extra line in here as you
are working on the related code (and it improves readability a tiny bit).
However, if you are going to do it, do them all.  There are other places
below that would benefit from this little change.

>  	return ret;
>  }
>  
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index e6f17825db79..3874666a8a14 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -77,7 +77,7 @@ static int scmi_clock_protocol_attributes_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_clock_protocol_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
>  				 SCMI_PROTOCOL_CLOCK, 0, sizeof(*attr), &t);
>  	if (ret)
>  		return ret;
> @@ -90,7 +90,7 @@ static int scmi_clock_protocol_attributes_get(const struct scmi_handle *handle,
>  		ci->max_async_req = attr->max_async_req;
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -101,7 +101,7 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_clock_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
> +	ret = scmi_xfer_get_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
>  				 sizeof(clk_id), sizeof(*attr), &t);
>  	if (ret)
>  		return ret;
> @@ -115,7 +115,7 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
>  	else
>  		clk->name[0] = '\0';
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -132,7 +132,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
>  	struct scmi_msg_clock_describe_rates *clk_desc;
>  	struct scmi_msg_resp_clock_describe_rates *rlist;
>  
> -	ret = scmi_one_xfer_init(handle, CLOCK_DESCRIBE_RATES,
> +	ret = scmi_xfer_get_init(handle, CLOCK_DESCRIBE_RATES,
>  				 SCMI_PROTOCOL_CLOCK, sizeof(*clk_desc), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -186,7 +186,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
>  		clk->list.num_rates = tot_rate_cnt;
>  
>  err:
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -196,7 +196,7 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
>  	int ret;
>  	struct scmi_xfer *t;
>  
> -	ret = scmi_one_xfer_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
> +	ret = scmi_xfer_get_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
>  				 sizeof(__le32), sizeof(u64), &t);
>  	if (ret)
>  		return ret;
> @@ -211,7 +211,7 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
>  		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -222,7 +222,7 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
>  	struct scmi_xfer *t;
>  	struct scmi_clock_set_rate *cfg;
>  
> -	ret = scmi_one_xfer_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
> +	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
>  				 sizeof(*cfg), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -235,7 +235,7 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -246,7 +246,7 @@ scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
>  	struct scmi_xfer *t;
>  	struct scmi_clock_set_config *cfg;
>  
> -	ret = scmi_one_xfer_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
> +	ret = scmi_xfer_get_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
>  				 sizeof(*cfg), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -257,7 +257,7 @@ scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 0821662a4633..41b03e46cca8 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -95,9 +95,9 @@ struct scmi_xfer {
>  	struct completion done;
>  };
>  
> -void scmi_one_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
> +void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
>  int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
> -int scmi_one_xfer_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
> +int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
>  		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
>  int scmi_handle_put(const struct scmi_handle *handle);
>  struct scmi_handle *scmi_handle_get(struct device *dev);
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 6fee11f06a66..33d2b78af3ff 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -295,7 +295,7 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
>   *
>   * Return: 0 if all went fine, else corresponding error.
>   */
> -static struct scmi_xfer *scmi_one_xfer_get(const struct scmi_handle *handle)
> +static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle)
>  {
>  	u16 xfer_id;
>  	struct scmi_xfer *xfer;
> @@ -324,14 +324,14 @@ static struct scmi_xfer *scmi_one_xfer_get(const struct scmi_handle *handle)
>  }
>  
>  /**
> - * scmi_one_xfer_put() - Release a message
> + * scmi_xfer_put() - Release a message
>   *
>   * @handle: Pointer to SCMI entity handle
>   * @xfer: message that was reserved by scmi_xfer_get
>   *
>   * This holds a spinlock to maintain integrity of internal data structures.
>   */
> -void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> +void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  {
>  	unsigned long flags;
>  	struct scmi_info *info = handle_to_scmi_info(handle);
> @@ -436,7 +436,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  }
>  
>  /**
> - * scmi_one_xfer_init() - Allocate and initialise one message
> + * scmi_xfer_get_init() - Allocate and initialise one message
>   *
>   * @handle: Pointer to SCMI entity handle
>   * @msg_id: Message identifier
> @@ -445,13 +445,13 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>   * @rx_size: receive message size
>   * @p: pointer to the allocated and initialised message
>   *
> - * This function allocates the message using @scmi_one_xfer_get and
> + * This function allocates the message using @scmi_xfer_get and
>   * initialise the header.
>   *
>   * Return: 0 if all went fine with @p pointing to message, else
>   *	corresponding error.
>   */
> -int scmi_one_xfer_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
> +int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
>  		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
>  {
>  	int ret;
> @@ -464,7 +464,7 @@ int scmi_one_xfer_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
>  	    tx_size > info->desc->max_msg_size)
>  		return -ERANGE;
>  
> -	xfer = scmi_one_xfer_get(handle);
> +	xfer = scmi_xfer_get(handle);
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
>  		dev_err(dev, "failed to get free message slot(%d)\n", ret);
> @@ -500,7 +500,7 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
>  	__le32 *rev_info;
>  	struct scmi_xfer *t;
>  
> -	ret = scmi_one_xfer_init(handle, PROTOCOL_VERSION, protocol, 0,
> +	ret = scmi_xfer_get_init(handle, PROTOCOL_VERSION, protocol, 0,
>  				 sizeof(*version), &t);
>  	if (ret)
>  		return ret;
> @@ -511,7 +511,7 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
>  		*version = le32_to_cpu(*rev_info);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -539,7 +539,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
>  }
>  
>  /**
> - * scmi_handle_get() - Get the  SCMI handle for a device
> + * scmi_handle_get() - Get the SCMI handle for a device

This wants to be in the earlier documentation fix patch not here.

>   *
>   * @dev: pointer to device for which we want SCMI handle
>   *
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 611ab08e6174..2a219b1261b1 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -115,7 +115,7 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_perf_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
>  				 SCMI_PROTOCOL_PERF, 0, sizeof(*attr), &t);
>  	if (ret)
>  		return ret;
> @@ -133,7 +133,7 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
>  		pi->stats_size = le32_to_cpu(attr->stats_size);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -145,7 +145,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_perf_domain_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, PERF_DOMAIN_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, PERF_DOMAIN_ATTRIBUTES,
>  				 SCMI_PROTOCOL_PERF, sizeof(domain),
>  				 sizeof(*attr), &t);
>  	if (ret)
> @@ -171,7 +171,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -194,7 +194,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
>  	struct scmi_msg_perf_describe_levels *dom_info;
>  	struct scmi_msg_resp_perf_describe_levels *level_info;
>  
> -	ret = scmi_one_xfer_init(handle, PERF_DESCRIBE_LEVELS,
> +	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_LEVELS,
>  				 SCMI_PROTOCOL_PERF, sizeof(*dom_info), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -237,7 +237,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
>  	} while (num_returned && num_remaining);
>  
>  	perf_dom->opp_count = tot_opp_cnt;
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  
>  	sort(perf_dom->opp, tot_opp_cnt, sizeof(*opp), opp_cmp_func, NULL);
>  	return ret;
> @@ -250,7 +250,7 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
>  	struct scmi_xfer *t;
>  	struct scmi_perf_set_limits *limits;
>  
> -	ret = scmi_one_xfer_init(handle, PERF_LIMITS_SET, SCMI_PROTOCOL_PERF,
> +	ret = scmi_xfer_get_init(handle, PERF_LIMITS_SET, SCMI_PROTOCOL_PERF,
>  				 sizeof(*limits), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -262,7 +262,7 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -273,7 +273,7 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
>  	struct scmi_xfer *t;
>  	struct scmi_perf_get_limits *limits;
>  
> -	ret = scmi_one_xfer_init(handle, PERF_LIMITS_GET, SCMI_PROTOCOL_PERF,
> +	ret = scmi_xfer_get_init(handle, PERF_LIMITS_GET, SCMI_PROTOCOL_PERF,
>  				 sizeof(__le32), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -288,7 +288,7 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
>  		*min_perf = le32_to_cpu(limits->min_level);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -299,7 +299,7 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
>  	struct scmi_xfer *t;
>  	struct scmi_perf_set_level *lvl;
>  
> -	ret = scmi_one_xfer_init(handle, PERF_LEVEL_SET, SCMI_PROTOCOL_PERF,
> +	ret = scmi_xfer_get_init(handle, PERF_LEVEL_SET, SCMI_PROTOCOL_PERF,
>  				 sizeof(*lvl), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -311,7 +311,7 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -321,7 +321,7 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
>  	int ret;
>  	struct scmi_xfer *t;
>  
> -	ret = scmi_one_xfer_init(handle, PERF_LEVEL_GET, SCMI_PROTOCOL_PERF,
> +	ret = scmi_xfer_get_init(handle, PERF_LEVEL_GET, SCMI_PROTOCOL_PERF,
>  				 sizeof(u32), sizeof(u32), &t);
>  	if (ret)
>  		return ret;
> @@ -333,7 +333,7 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
>  	if (!ret)
>  		*level = le32_to_cpu(*(__le32 *)t->rx.buf);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> index 087c2876cdf2..cfa033b05aed 100644
> --- a/drivers/firmware/arm_scmi/power.c
> +++ b/drivers/firmware/arm_scmi/power.c
> @@ -63,7 +63,7 @@ static int scmi_power_attributes_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_power_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
>  				 SCMI_PROTOCOL_POWER, 0, sizeof(*attr), &t);
>  	if (ret)
>  		return ret;
> @@ -78,7 +78,7 @@ static int scmi_power_attributes_get(const struct scmi_handle *handle,
>  		pi->stats_size = le32_to_cpu(attr->stats_size);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -90,7 +90,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_power_domain_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, POWER_DOMAIN_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, POWER_DOMAIN_ATTRIBUTES,
>  				 SCMI_PROTOCOL_POWER, sizeof(domain),
>  				 sizeof(*attr), &t);
>  	if (ret)
> @@ -109,7 +109,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -120,7 +120,7 @@ scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
>  	struct scmi_xfer *t;
>  	struct scmi_power_set_state *st;
>  
> -	ret = scmi_one_xfer_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
> +	ret = scmi_xfer_get_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
>  				 sizeof(*st), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -132,7 +132,7 @@ scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -142,7 +142,7 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
>  	int ret;
>  	struct scmi_xfer *t;
>  
> -	ret = scmi_one_xfer_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
> +	ret = scmi_xfer_get_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
>  				 sizeof(u32), sizeof(u32), &t);
>  	if (ret)
>  		return ret;
> @@ -153,7 +153,7 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
>  	if (!ret)
>  		*state = le32_to_cpu(*(__le32 *)t->rx.buf);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index bbb469fea0ed..27f2092b9882 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -79,7 +79,7 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_sensor_attributes *attr;
>  
> -	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
>  				 SCMI_PROTOCOL_SENSOR, 0, sizeof(*attr), &t);
>  	if (ret)
>  		return ret;
> @@ -95,7 +95,7 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
>  		si->reg_size = le32_to_cpu(attr->reg_size);
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -108,7 +108,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_resp_sensor_description *buf;
>  
> -	ret = scmi_one_xfer_init(handle, SENSOR_DESCRIPTION_GET,
> +	ret = scmi_xfer_get_init(handle, SENSOR_DESCRIPTION_GET,
>  				 SCMI_PROTOCOL_SENSOR, sizeof(__le32), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -150,7 +150,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
>  		 */
>  	} while (num_returned && num_remaining);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -162,7 +162,7 @@ scmi_sensor_configuration_set(const struct scmi_handle *handle, u32 sensor_id)
>  	struct scmi_xfer *t;
>  	struct scmi_msg_set_sensor_config *cfg;
>  
> -	ret = scmi_one_xfer_init(handle, SENSOR_CONFIG_SET,
> +	ret = scmi_xfer_get_init(handle, SENSOR_CONFIG_SET,
>  				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -173,7 +173,7 @@ scmi_sensor_configuration_set(const struct scmi_handle *handle, u32 sensor_id)
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -185,7 +185,7 @@ static int scmi_sensor_trip_point_set(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_set_sensor_trip_point *trip;
>  
> -	ret = scmi_one_xfer_init(handle, SENSOR_TRIP_POINT_SET,
> +	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_SET,
>  				 SCMI_PROTOCOL_SENSOR, sizeof(*trip), 0, &t);
>  	if (ret)
>  		return ret;
> @@ -198,7 +198,7 @@ static int scmi_sensor_trip_point_set(const struct scmi_handle *handle,
>  
>  	ret = scmi_do_xfer(handle, t);
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
> @@ -209,7 +209,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
>  	struct scmi_xfer *t;
>  	struct scmi_msg_sensor_reading_get *sensor;
>  
> -	ret = scmi_one_xfer_init(handle, SENSOR_READING_GET,
> +	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
>  				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor),
>  				 sizeof(u64), &t);
>  	if (ret)
> @@ -227,7 +227,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
>  		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
>  	}
>  
> -	scmi_one_xfer_put(handle, t);
> +	scmi_xfer_put(handle, t);
>  	return ret;
>  }
>  
