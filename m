From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/6] PM / devfreq: Fix the checkpatch warnings
Date: Thu, 24 Nov 2016 02:52:38 -0800
Message-ID: <1479984758.19726.7.camel@perches.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
         <1479963668-22845-2-git-send-email-cw00.choi@samsung.com>
         <CGME20161124102049epcas4p3312e9a6cc4cb33b16dc1984922025c44@epcas4p3.samsung.com>
         <1479982838.19726.3.camel@perches.com> <5836C4F9.2010509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:38980 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935138AbcKXKwm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 05:52:42 -0500
In-Reply-To: <5836C4F9.2010509@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-11-24 at 19:46 +0900, Chanwoo Choi wrote:
> On 2016년 11월 24일 19:20, Joe Perches wrote:
> > On Thu, 2016-11-24 at 14:01 +0900, Chanwoo Choi wrote:
> > > This patch just fixes the checkpatch warnings.
> > 
> > unrelated trivia:
> > 
> > > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
[]
> > > @@ -576,11 +575,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
> > >  		goto err_out;
> > >  	}
> > >  
> > > -	devfreq->trans_table =	devm_kzalloc(&devfreq->dev, sizeof(unsigned int) *
> > > +	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
> > > +						sizeof(unsigned int) *
> > >  						devfreq->profile->max_state *
> > >  						devfreq->profile->max_state,
> > >  						GFP_KERNEL);
> > > -	devfreq->time_in_state = devm_kzalloc(&devfreq->dev, sizeof(unsigned long) *
> > > +	devfreq->time_in_state = devm_kzalloc(&devfreq->dev,
> > > +						sizeof(unsigned long) *
> > >  						devfreq->profile->max_state,
> > >  						GFP_KERNEL);
> > 
> > Maybe these should be devm_kcalloc calls
> 
> Why should devfreq use the devm_kcalloc?

Because these are allocating zeroed arrays of a specific size.

