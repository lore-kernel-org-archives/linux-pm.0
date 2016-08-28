From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v6] PM / hibernate: Print the possible panic reason when
 resuming with inconsistent e820 map
Date: Sun, 28 Aug 2016 10:07:10 +0800
Message-ID: <20160828020710.GB5941@sharon>
References: <1445404900-29702-1-git-send-email-yu.c.chen@intel.com>
 <20160823094527.GG7276@linux-rxt1.site>
 <20160823100155.GA12738@sharon>
 <20160824013610.GA26119@linux-rxt1.site>
 <20160825110748.GA22104@sharon>
 <20160826195654.GD21442@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753105AbcH1B7J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Aug 2016 21:59:09 -0400
Content-Disposition: inline
In-Reply-To: <20160826195654.GD21442@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: joeyli <jlee@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,
On Fri, Aug 26, 2016 at 09:56:54PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > What's the progress of this patch? Looks already have experts review it.
> > > > > Why this patch didn't accept?
> > > > This patch is a little overkilled, and I have saved another simpler
> > > > version to only check the md5 hash (as people suggested) for it. I can post it later.
> > > > 
> > > 
> > > I am happy to test and review it.
> > >
> > Here it is. As Rafael is on travel, it would be grateful
> > if you can give some advance on this, thanks!
> 
> Better than last one.
> 
> > +		return -ENOMEM;
> > +
> > +	req = ahash_request_alloc(tfm, GFP_ATOMIC);
> 
> what context is this called from? GFP_ATOMIC allocations like to fail...
>
It is in normal process context, OK, I'll change it to GFP_KERNEL.
> > +static int hibernation_e820_check(void *buf)
> > +{
> > +	int ret;
> > +	char result[MD5_HASH_SIZE] = {0};
> > +
> > +	ret = get_e820_md5(&e820_saved, result);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (memcmp(result, buf, MD5_HASH_SIZE))
> > +		e820_conflict = true;
> 
> Passing return value using global variable is ugly. Can you just print
> the warning and kill the box here?
Do you mean get rid of the panic hooker and just print the warning here?
> > +
> 
> > +	/*
> > +	 * A page has been allocated previously to store the hibernation
> > +	 * image header, so we can safely store the md5 result behind
> > +	 * struct restore_data_record, with size of 128 bytes.
> > +	 */
> > +	hibernation_e820_save(addr + sizeof(struct restore_data_record));
> > +
> 
> Please just allocate space in struct restore_data_record . And I don't
> think md5 sum is 128 _bytes_.
>
OK. The md5 sum should be 128 bits thus 16 bytes.

Thanks!
Yu 
