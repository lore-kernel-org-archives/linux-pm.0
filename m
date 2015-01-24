From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v4 00/17] thermal: exynos: Thermal code rework to use
 device tree
Date: Sat, 24 Jan 2015 13:04:40 +0900
Message-ID: <54C319D8.4050303@kernel.org>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com> <1421407861-25099-1-git-send-email-l.majewski@samsung.com> <0dad01d036e0$2f376c80$8da64580$@kernel.org> <20150123105944.457d6d07@amdc2363> <0e1401d036fb$c00a3510$401e9f30$@kernel.org> <20150123144540.GF13468@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150123144540.GF13468@developer.hsd1.ca.comcast.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Zhang Rui' <rui.zhang@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Lukasz Majewski' <l.majewski@majess.pl>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, 'Abhilash Kesavan' <kesavan.abhilash@gmail.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 01/23/15 23:45, Eduardo Valentin wrote:
> Hi Kukjin,
> 
Hi Eduardo,

[...]

>>>> I hope will apply DT changes in Samsung tree. Is it OK to thermal
>>>> tree?
>>>
>>> I think that it is up to you and Eduardo to decide :-).
>>>
>>> I'd personally prefer to add this patch set at once to Eduardo's tree
>>> (of course with your ACKs).
>>>
>> If so, we could see too many useless merge conflicts. Because your patches
>> touch most of exynos DT stuff and that's why DT changes should be handled in
>> Samsung tree if there is no problem ;) Let's wait for thermal guys.
> 
> Let's target the latest version (v6) of this series. You can add my
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> 
OK, I'll take DT changes in my tree with your ack.

> in the DTS changes. And add them via your tree. I believe we will avoid
> merge conflicts this way. I will handle the patches touching drivers/.
> 
Sure, thanks.

- Kukjin
