From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 08/10] hwspinlock: qcom: Lock #7 is special lock,
 uses dynamic proc_id
Date: Fri, 14 Aug 2015 08:12:22 -0600
Message-ID: <20150814141222.GC86880@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-9-git-send-email-lina.iyer@linaro.org>
 <20150813043036.GJ13472@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150813043036.GJ13472-P9SbAA3LsXe39TS3lRcy0mP6iJigPa5YXqFh9Ls21Oc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 12 2015 at 22:30 -0600, Bjorn Andersson wrote:
>On Wed 05 Aug 09:32 PDT 2015, Lina Iyer wrote:
>
>> Hwspinlocks are widely used between processors in an SoC, and also
>> between elevation levels within in the same processor.  QCOM SoC's use
>> hwspinlock to serialize entry into a low power mode when the context
>> switches from Linux to secure monitor.
>>
>> Lock #7 has been assigned for this purpose. In order to differentiate
>> between one cpu core holding a lock while another cpu is contending for
>> the same lock, the proc id written into the lock is (128 + cpu id). This
>> makes it unique value among the cpu cores and therefore when a core
>> locks the hwspinlock, other cores would wait for the lock to be released
>> since they would have a different proc id.  This value is specific for
>> the lock #7 only.
>>
>
>As I was thinking about this, I came to the conclusion that my argument
>that it's system configuration and not a property of the block that lock
>#7 is special is actually biting myself.
>
>Just as #7 is system configuration, so is the fact that 1 is the lock
>value for all other locks.
>
>I've been meaning to answer you, but I haven't come to a good conclusion
>in this matter. I think that both of these properties should be possible
>to express in DT, but I don't know how.
>
I thought about that. These are s/w imposed behavior. As a far as the
h/w is concerned, you could just write a non-zero value and the lock is
considered acquired. So placing that in DT may not be appropriate.

>
>Perhaps we should just list each lock that we expose as a subnode in DT
>with a property to indicate the lock value - with the possibility of
>indicating cpu_id.
>
>Something like:
>
>tcsr-mutex {
>	compatible = "qcom,tcsr-mutex";
>	syscon = <&tcsr_mutex_block 0 0x80>;
>
>	#hwlock-cells = <1>;
>	#address-cells = <1>;
>	#size-cells = <0>;
>
>	smem-lock@3 {
>		reg = <3>;
>		qcom,lock-value = <1>;
>	};
>
>	scm-lock@7 {
>		reg = <7>;
>		qcom,lock-value-from-cpu-id;
>		qcom,lock-raw;
>	};
>};
>
>As we don't reference most of these locks anyways I don't think this
>would still be reasonable. And if reg is an array it's quite compact.
>
But, looking at the DT, its not evident what lock-value-from-cpu-id,
would mean.  It is an implementation detail of Linux (as a result of
firmware). May be better to just hide it in the hwspinlock driver.

I am not sure about lock-raw, but I would think its not QCOM specific.
Imagine the case, when hwspinlock framework does not s/w spinlock around
the hwspinlock, we wouldnt have this property. The reason why we
spinlock around the hwspinlock is because we dont have a good way to
generate a unique value for the hwspinlock, so multiple threads
acquiring the same locks could safely be assured that they have acquired
the lock. While convenient and probably more effecient to just have s/w
spinlocks around the hwspinlock, the problem here is it is mandated
across all locks.

To me it seems OK to explicity call out lock #7 as unique entity in the
bank that is compatible with a raw hwspinlock in the DT. But the value
that lock #7 uses is an implementation detail and should rest wth the
drivers.

Thanks,
Lina
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
