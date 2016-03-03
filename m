From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/4] thermal: Add support for hierarchical thermal
 zones
Date: Wed, 2 Mar 2016 19:23:27 -0800
Message-ID: <20160303032326.GE3379@localhost.localdomain>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-2-git-send-email-javi.merino@arm.com>
 <20160303031244.GA3379@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303031244.GA3379@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 02, 2016 at 07:12:46PM -0800, Eduardo Valentin wrote:
> 
> Thanks for moving this forward Javi,
> 
> Few comments inline.
> 
> On Wed, Nov 25, 2015 at 03:09:43PM +0000, Javi Merino wrote:
> > Add the ability to stack thermal zones on top of each other, creating a
> > hierarchy of thermal zones.

> > +
> > +	if (!tz->ops->get_temp) {
> > +		ret = get_subtz_temp(tz, temp);
> > +		goto unlock;
> > +	}

In fact, if we follow the semantics in DT, we should allow both,
regular sensors (.get_temp) and subtzs.
