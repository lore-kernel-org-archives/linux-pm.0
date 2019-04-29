From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
Date: Mon, 29 Apr 2019 17:12:39 +0300
Message-ID: <87ef5ksxwo.fsf@kamboji.qca.qualcomm.com>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
        <20190403195718.GA74723@google.com>
        <87o94tutdz.fsf@kamboji.qca.qualcomm.com>
        <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
        <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Claire Chang's message of "Mon, 29 Apr 2019 18:41:50 +0800")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sriram R <srirrama-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pradeep Kumar Chitrapu <pradeepc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:

> Tested-by: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
>> Still, I'm quite sure that the WARN_ON()s trigger during system resume
>> regardless of the hw/fw combination.
>
> Also see this on sido:
>
> [    4.925278] ath10k_sdio mmc1:0001:1: qca6174 hw3.2 sdio target
> 0x05030000 chip_id 0x00000000 sub 0000:0000
> [    4.935721] ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1
> tracing 1 dfs 0 testmode 1
> [    4.948750] ath10k_sdio mmc1:0001:1: firmware ver
> WLAN.RMH.4.4.1-00007-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32
> b98adaf8
> [    5.132728] ath10k_sdio mmc1:0001:1: board_file api 2 bmi_id 0:4
> crc32 6364cfcc

Great, thanks. I added your Tested-by as well.

-- 
Kalle Valo
