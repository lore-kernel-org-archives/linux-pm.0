From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
Date: Thu, 18 Oct 2018 12:38:03 -0700
Message-ID: <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
 <20181015150926.29520.45280.stgit@localhost.localdomain>
 <1539886275.81977.17.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539886275.81977.17.camel@acm.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bart Van Assche <bvanassche@acm.org>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 10/18/2018 11:11 AM, Bart Van Assche wrote:
> On Mon, 2018-10-15 at 08:09 -0700, Alexander Duyck wrote:
>> +static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
>> +{
>> +	struct device *dev = _dev;
>> +
>> +	__device_driver_lock(dev, dev->parent);
>> +
>> +	/*
>> +	 * If someone attempted to bind a driver either successfully or
>> +	 * unsuccessfully before we got here we should just skip the driver
>> +	 * probe call.
>> +	 */

The answer to your question below is up here.

>> +	if (!dev->driver) {
>> +		struct device_driver *drv = dev_get_drvdata(dev);
>> +
>> +		if (drv)
>> +			driver_probe_device(drv, dev);
>> +	}
>> +
>> +	__device_driver_unlock(dev, dev->parent);
>> +
>> +	put_device(dev);
>> +
>> +	dev_dbg(dev, "async probe completed\n");
>> +}
>> +
>>   static int __driver_attach(struct device *dev, void *data)
>>   {
>>   	struct device_driver *drv = data;
>> @@ -945,6 +971,25 @@ static int __driver_attach(struct device *dev, void *data)
>>   		return ret;
>>   	} /* ret > 0 means positive match */
>>   
>> +	if (driver_allows_async_probing(drv)) {
>> +		/*
>> +		 * Instead of probing the device synchronously we will
>> +		 * probe it asynchronously to allow for more parallelism.
>> +		 *
>> +		 * We only take the device lock here in order to guarantee
>> +		 * that the dev->driver and driver_data fields are protected
>> +		 */
>> +		dev_dbg(dev, "scheduling asynchronous probe\n");
>> +		device_lock(dev);
>> +		if (!dev->driver) {
>> +			get_device(dev);
>> +			dev_set_drvdata(dev, drv);
>> +			async_schedule(__driver_attach_async_helper, dev);
>> +		}
>> +		device_unlock(dev);
>> +		return 0;
>> +	}
>> +
>>   	device_driver_attach(drv, dev);
> 
> What prevents that the driver pointer becomes invalid after async_schedule() has
> been called and before __driver_attach_async_helper() is called? I think we need
> protection against concurrent driver_unregister() and __driver_attach_async_helper()
> calls. I'm not sure whether that is possible without introducing a new mutex.
> 
> Thanks,
> 
> Bart.

See the spot called out above.

Basically if somebody loads a driver the dev->driver becomes set. If a 
driver is removed it will clear dev->driver and set driver_data to 
0/NULL. That is what I am using as a mutex to track it in conjunction 
with the device mutex. Basically if somebody attempts to attach a driver 
before we get there we just exit and don't attempt to load this driver.
