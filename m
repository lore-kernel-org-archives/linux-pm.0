From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] PM / devfreq: fix indentation in
 devfreq_add_device()
Date: Mon, 21 Jan 2019 08:39:20 -0800
Message-ID: <a6b96055a16da89a3cc20c145b65beb61c55f0a1.camel@perches.com>
References: <CGME20190119183407epcas1p4958e4526d07c36605307c49b0c0e2e2c@epcas1p4.samsung.com>
         <20190119160454.23151-1-tiny.windzz@gmail.com>
         <e45d38da-1dc4-c1ca-83d4-0efeb64acef1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e45d38da-1dc4-c1ca-83d4-0efeb64acef1@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2019-01-21 at 10:58 +0900, Chanwoo Choi wrote:
> On 19. 1. 20. 오전 1:04, Yangtao Li wrote:
> > To beautify the code format.

I believe half of the changes are actually _less_ beautiful.

> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
[]
> > @@ -683,16 +683,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  		goto err_out;
> >  	}
> >  
> > -	devfreq->trans_table =
> > -		devm_kzalloc(&devfreq->dev,
> > -			     array3_size(sizeof(unsigned int),
> > -					 devfreq->profile->max_state,
> > -					 devfreq->profile->max_state),
> > -			     GFP_KERNEL);
> > +	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> > +					    array3_size(sizeof(unsigned int),
> > +					    devfreq->profile->max_state,
> > +					    devfreq->profile->max_state),
> > +					    GFP_KERNEL);

I think this bit is worse because the array3_size arguments
are no longer aligned.

> >  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> > -						devfreq->profile->max_state,
> > -						sizeof(unsigned long),
> > -						GFP_KERNEL);
> > +					      devfreq->profile->max_state,
> > +					      sizeof(unsigned long),
> > +					      GFP_KERNEL);

and this bit is better.
