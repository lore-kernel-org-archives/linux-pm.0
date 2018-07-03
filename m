From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when
 drivers are built as modules.
Date: Tue, 03 Jul 2018 19:47:49 +0900
Message-ID: <20180703104749epcms1p473b2160f6e2bbe3c6b87827b30e8473b@epcms1p4>
References: <7c67974e40afd15abfca5907b27de097@codeaurora.org>
        <20180621220430.25644-1-enric.balletbo@collabora.com>
        <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
        <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
        <1e792d3c972998f92109c127886243e32c4cde71.camel@collabora.com>
        <CGME20180622212233epcas2p3308116579442dc8a42a9db7445ce8ef8@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c67974e40afd15abfca5907b27de097@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "akhilpo@codeaurora.org" <akhilpo@codeaurora.org>, Ezequiel Garcia <ezequiel@collabora.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> >> Adding to Ezequiel's point, shouldn't we take more granular lock
> >> (devfreq->lock) first and then call devfreq_list_lock at the time of
> >> adding to the list?
> >> 
> > 
> > Not sure why we should do that. devfreq->lock should be used to
> > protect the struct devfreq state, while the devfreq_list_lock
> > is apparently protecting the two lists (which seem unrelated
> > lists).

Correct.

devfreq->lock protects an instance of devfreq.
devfreq_list_lock protects the global devfreq data (list of devfreq / governors)

> > 
> > So, the two locks are not correlated.
> > 
> > Regards,
> > Eze
> In governor_store(), we do 'df->governor = governor;' without taking 
> df->lock. So it is possible to switch governor while update_devfreq() is 
> in progress.

Yup. that's possible.

> I smell trouble there. Don't you think so?
> I am assuming df->lock protects 'struct devfreq' and devfreq_list_lock 
> protects both device and governor lists.

devfreq_list_lock is not supposed to protect a device.

Assuming a memory read of a word is atomic (I'm not aware of one that's not
unless in a case where the address is unaligned in some archtectures),
update_devfreq won't cause such issues because it reads "devfreq->governor"
only one in its execution except for the null check.

Thus, if there could be an error, it'd be a case where someone else is
doing "devfreq->governor = NULL" without devfreq->lock.
And, find_devfreq_governor() does not return NULL.


Cheers,
MyungJoo

> 
> -Akhil.
> 
