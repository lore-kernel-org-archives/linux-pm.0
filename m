From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] PM / devfreq: constify attribute_group structures.
Date: Thu, 06 Jul 2017 01:39:47 +0000
Message-ID: <20170706013947epcms1p3be4b0f009cb73ccf8d555c9e6d1c529d@epcms1p3>
References: <595A19AA.3060105@samsung.com>
        <a4e33dd6c72dac67a227e896044b2ee3c1f8825a.1499076508.git.arvind.yadav.cs@gmail.com>
        <CGME20170703101025epcas4p151a0c496ae3410031c27f4da7ab9714f@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <595A19AA.3060105@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> On 2017년 07월 03일 19:10, Arvind Yadav wrote:

> > attribute_groups are not supposed to change at runtime. All functions

> > working with attribute_groups provided by <linux/sysfs.h> work with const

> > attribute_group. So mark the non-const structs as const.

> > 

> > File size before:

> >    text	   data	    bss	    dec	    hex	filename

> >     621	    176	      0	    797	    31d	drivers/devfreq/governor_userspace.o

> > 

> > File size After adding 'const':

> >    text	   data	    bss	    dec	    hex	filename

> >    670	    144	      0	    814	    32e	drivers/devfreq/governor_userspace.o

> > 

> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

> > ---

> >  drivers/devfreq/governor_userspace.c | 2 +-

> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > 

> > diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c

[]

> 

> Looks good to me.

> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>



Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>



Thank you. Applying to for-rc branch.





Cheers,

MyungJoo
