From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v6] PM / hibernate: Print the possible panic reason when
 resuming with inconsistent e820 map
Date: Fri, 26 Aug 2016 21:56:54 +0200
Message-ID: <20160826195654.GD21442@amd>
References: <1445404900-29702-1-git-send-email-yu.c.chen@intel.com>
 <20160823094527.GG7276@linux-rxt1.site>
 <20160823100155.GA12738@sharon>
 <20160824013610.GA26119@linux-rxt1.site>
 <20160825110748.GA22104@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42789 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbcHZT5L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 15:57:11 -0400
Content-Disposition: inline
In-Reply-To: <20160825110748.GA22104@sharon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: joeyli <jlee@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> > > > What's the progress of this patch? Looks already have experts review it.
> > > > Why this patch didn't accept?
> > > This patch is a little overkilled, and I have saved another simpler
> > > version to only check the md5 hash (as people suggested) for it. I can post it later.
> > > 
> > 
> > I am happy to test and review it.
> >
> Here it is. As Rafael is on travel, it would be grateful
> if you can give some advance on this, thanks!

Better than last one.

> +#ifdef CONFIG_HIBERNATION_CHECK_E820
> +#define MD5_HASH_SIZE 128
> +
> +/**
> + *	get_e820_md5 - calculate md5 according to struct e820map
> + *
> + *	@map: the e820 map to be calculated
> + *	@buf: the md5 result to be stored to
> + */
> +static int get_e820_md5(struct e820map *map, void *buf)
> +{
> +	struct scatterlist sg;
> +	struct crypto_ahash *tfm;
> +	struct ahash_request *req;
> +	int ret = 0;
> +
> +	tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> +	if (IS_ERR(tfm))
> +		return -ENOMEM;
> +
> +	req = ahash_request_alloc(tfm, GFP_ATOMIC);

what context is this called from? GFP_ATOMIC allocations like to fail...

> +static int hibernation_e820_check(void *buf)
> +{
> +	int ret;
> +	char result[MD5_HASH_SIZE] = {0};
> +
> +	ret = get_e820_md5(&e820_saved, result);
> +	if (ret)
> +		return ret;
> +
> +	if (memcmp(result, buf, MD5_HASH_SIZE))
> +		e820_conflict = true;

Passing return value using global variable is ugly. Can you just print
the warning and kill the box here?
> +

> +	/*
> +	 * A page has been allocated previously to store the hibernation
> +	 * image header, so we can safely store the md5 result behind
> +	 * struct restore_data_record, with size of 128 bytes.
> +	 */
> +	hibernation_e820_save(addr + sizeof(struct restore_data_record));
> +

Please just allocate space in struct restore_data_record . And I don't
think md5 sum is 128 _bytes_.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
