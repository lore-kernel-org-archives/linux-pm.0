From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check
Date: Wed, 1 Jun 2016 20:33:35 +0900
Message-ID: <CAGTfZH2NfeVpQgU1+PN1RkW8dz7cDNkBWSvSoFbx8s3hGvY22Q@mail.gmail.com>
References: <alpine.DEB.2.10.1605251710500.3644@hadrien>
	<20160526064541.GA6680@mwanda>
	<CAJ0PZbR4j+8dRpOsvEtdsu2Z7hoXN1UOD70qoJ5q3oMG4X+yDw@mail.gmail.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJ0PZbR4j+8dRpOsvEtdsu2Z7hoXN1UOD70qoJ5q3oMG4X+yDw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <julia.lawall@lip6.fr>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Myungjoo,

On Wed, Jun 1, 2016 at 7:25 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> On Thu, May 26, 2016 at 3:45 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> Smatch complains because platform_get_resource() returns NULL on error
>> and not an error pointer so the check is wrong.  Julia Lawall pointed
>> out that normally we don't check these, because devm_ioremap_resource()
>> has a check for NULL.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>
> Queued in fixes branch to be sent with other fixes for RCx.


I already reviewed this patch. Also, the merged patch[1] don't include
the my reviewed-by tag.
I'd like you to add my reviewed-by tag again.

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=fixes&id=44a3c02256bb69b2a20f55d2bd77c5a2fd20bc52

Regards,
Chanwoo Choi
