From: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: Re: [PATCH RFC 08/10] hwspinlock: qcom: Lock #7 is special lock,
 uses dynamic proc_id
Date: Wed, 12 Aug 2015 21:30:36 -0700
Message-ID: <20150813043036.GJ13472@usrtlx11787.corpusers.net>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-9-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438792366-2737-9-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed 05 Aug 09:32 PDT 2015, Lina Iyer wrote:

> Hwspinlocks are widely used between processors in an SoC, and also
> between elevation levels within in the same processor.  QCOM SoC's use
> hwspinlock to serialize entry into a low power mode when the context
> switches from Linux to secure monitor.
> 
> Lock #7 has been assigned for this purpose. In order to differentiate
> between one cpu core holding a lock while another cpu is contending for
> the same lock, the proc id written into the lock is (128 + cpu id). This
> makes it unique value among the cpu cores and therefore when a core
> locks the hwspinlock, other cores would wait for the lock to be released
> since they would have a different proc id.  This value is specific for
> the lock #7 only.
> 

As I was thinking about this, I came to the conclusion that my argument
that it's system configuration and not a property of the block that lock
#7 is special is actually biting myself.

Just as #7 is system configuration, so is the fact that 1 is the lock
value for all other locks.

I've been meaning to answer you, but I haven't come to a good conclusion
in this matter. I think that both of these properties should be possible
to express in DT, but I don't know how.


Perhaps we should just list each lock that we expose as a subnode in DT
with a property to indicate the lock value - with the possibility of
indicating cpu_id.

Something like:

tcsr-mutex {
	compatible = "qcom,tcsr-mutex";
	syscon = <&tcsr_mutex_block 0 0x80>;

	#hwlock-cells = <1>;
	#address-cells = <1>;
	#size-cells = <0>;

	smem-lock@3 {
		reg = <3>;
		qcom,lock-value = <1>;
	};

	scm-lock@7 {
		reg = <7>;
		qcom,lock-value-from-cpu-id;
		qcom,lock-raw;
	};
};

As we don't reference most of these locks anyways I don't think this
would still be reasonable. And if reg is an array it's quite compact.

> Declare lock #7 as raw capable, so the hwspinlock framework would not
> enfore acquiring a s/w spinlock before acquiring the hwspinlock.
> 

I'm fine with this part!


Sorry for the extremely slow response, but this took some time to
process...

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
