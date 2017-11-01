From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Wed, 1 Nov 2017 23:36:21 +0100
Message-ID: <CAJZ5v0gLw2J=zU3fJxSnea_ua2AgP8bRoFQLi7_wyAzLJGizEg@mail.gmail.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
 <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
 <3227682.nATp9NGxKU@aspire.rjw.lan> <CAMuHMdVKh9n4aep+niyYYEA_4cNrB4+BfGWrJ3WLpej1me114w@mail.gmail.com>
 <CAMuHMdW3AJFZQVDPTcpL-UMRxNThcOpQxNz6yTx9qDP7SQ-kLg@mail.gmail.com>
 <CAMuHMdX4WjXZQrP9QMGFV8sbntOUvfZ4y-uQSS4_4ArrCjsxWA@mail.gmail.com>
 <CAJZ5v0guHP=icMiRBZ1B4oWQVxrtN2Nt+aE_V1646PfpsKkiJg@mail.gmail.com>
 <CAMuHMdWiwURQ2MAvpQu-=0AZ+O8Ej=VzPE7bCJ+FWxL3D2n_cg@mail.gmail.com>
 <CAJZ5v0iHdSzAf2KSJ0r5-kVaa1eEohgoUhdOR9s-uLRFw7EC9w@mail.gmail.com>
 <42ddd99a-e279-0d64-d000-e70f356998d0@ti.com> <CAJZ5v0hW0iu3Yn+3YFk3EBOey+dtAQt=YbmU5dM2X4nirzbtSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hW0iu3Yn+3YFk3EBOey+dtAQt=YbmU5dM2X4nirzbtSw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

[cut]

>> It seems the default values for pm_qos have changed with the patch, and that
>> breaks genpd at least. I only fixed PM runtime initially, but you could try
>> this diff to fix the genpd part also:
>>
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> index d68b056..7c8f643 100644
>> --- a/include/linux/pm_qos.h
>> +++ b/include/linux/pm_qos.h
>> @@ -34,9 +34,9 @@ enum pm_qos_flags_status {
>>  #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
>>  #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE        0
>>  #define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE  0
>> -#define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    0
>> +#define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    PM_QOS_LATENCY_ANY
>>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT    PM_QOS_LATENCY_ANY
>> -#define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE 0
>> +#define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE (-1)
>>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>>
>>  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
>
> This is the original change in pm_qos.h (up to the GMail-induced
> whitespace breakage):
>
> -#define PM_QOS_DEFAULT_VALUE -1
> +#define PM_QOS_DEFAULT_VALUE (-1)
> +#define PM_QOS_LATENCY_ANY S32_MAX
>
> #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE (2000 * USEC_PER_SEC)
> #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE (2000 * USEC_PER_SEC)
> #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE 0
> #define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE 0
> #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE 0
> +#define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT PM_QOS_LATENCY_ANY

OK, so I should have changed PM_QOS_RESUME_LATENCY_DEFAULT_VALUE to
PM_QOS_LATENCY_ANY too, so that the default is still "no restriction".

> #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE 0
> #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>
> -#define PM_QOS_LATENCY_ANY ((s32)(~(__u32)0 >> 1))
>
> #define PM_QOS_FLAG_NO_POWER_OFF (1 << 0)
> #define PM_QOS_FLAG_REMOTE_WAKEUP (1 << 1)

Thanks,
Rafael
