From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH 01/12] PM / devfreq: Fix memory leak when fail to
 register device
Date: Mon, 28 Aug 2017 01:30:27 +0000
Message-ID: <20170828013027epcms1p19d7bf62daf3f571f3e4bf2df3ed85871@epcms1p1>
References: <59A36264.4030605@samsung.com>
        <1503538979-22693-2-git-send-email-cw00.choi@samsung.com>
        <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <20170828001753epcms1p658026b4f636aa4c0aee6f22bc128ebe3@epcms1p6>
        <CGME20170824014259epcas2p398a53a9a76d9aff7e35cf8515ec4e46a@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59A36264.4030605@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> On 2017년 08월 28일 09:17, MyungJoo Ham wrote:

> >> When the devfreq_add_device fails to register deivce, the memory

> >> leak of devfreq instance happen. So, this patch fix the memory

> >> leak issue. Before freeing the devfreq instance checks whether

> >> devfreq instance is NULL or not because the device_unregister()

> >> frees the devfreq instance when jumping to the 'err_init'.

> >> It is to prevent the duplicate the kfee(devfreq).

> >>

> >> Cc: stable@vger.kernel.org

> >> Fixes: ac4b281176a5 ("PM / devfreq: fix duplicated kfree on devfreq pointer")

> >> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

> >> ---

> >>  drivers/devfreq/devfreq.c | 5 ++++-

> >>  1 file changed, 4 insertions(+), 1 deletion(-)

> > 

> > This looks like to be duplicated. Please check your repo basis.

> 

> These patches is based on the v4.13-rc6.

> 

> After merged ("PM / devfreq: fix duplicated kfree on devfreq pointer"),

> this patch doesn't consider the free of memory when error case.

> 

> After applying this patch, this patch consider the error case

> when jumping the err_dev statement with goto.

> 		device_unregister(&devfreq->dev);

> 	err_dev:

> 		if (devfreq)		

> 			kfree(devfreq);



Ah sorry. It looks like I was confused of - and + somehow.



Acked-By: MyungJoo Ham.



(I'll merge trivial fixes first)



> 

> 
