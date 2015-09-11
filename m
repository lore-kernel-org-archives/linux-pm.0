From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v2 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Fri, 11 Sep 2015 11:26:49 +0300
Message-ID: <20150911082649.GQ21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <20150910122616.GB21512@lpalcu-desk>
 <20150910212626.GA16256@borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:29849 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbbIKI0w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Sep 2015 04:26:52 -0400
Content-Disposition: inline
In-Reply-To: <20150910212626.GA16256@borg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 04:26:26PM -0500, Andreas Dannenberg wrote:
> On Thu, Sep 10, 2015 at 03:26:16PM +0300, Laurentiu Palcu wrote:
> > On Tue, Sep 08, 2015 at 07:12:24PM -0500, Andreas Dannenberg wrote:
[...] 
> > For the entire patchset, please run it through 'checkpatch --strict'.
> > There are some minor style issues that are worth fixing.
> 
> Ok will do. But I'm not a big fan of --strict, especially the alignment
> of function arguments that spill into the next line. If it is required
> by the Kernel community (is it?) why not making --strict a default-on
> option of checkpatch.pl or mandating it in one of the docs?
I don't think this is required by the kernel community. However, I
believe that fixing those style issues will make the code tidier. The
reason this is not the default option for checkpatch is because you
cannot always align those function arguments without exceeding the 80
chars line limit, etc. Which is reasonable. So, wherever we can do it,
let's, at least, try. :)

>  
> > Regarding the DT patch (on which I'll comment separately, after I go
> > through the entire patchset), make sure you put it before the code
> > implementing the binding [1].
> > 
> > [1] Documentation/devicetree/bindings/submitting-patches.txt
> 
> I had actually read this but my DT doc binding patch also renames the
> binding file itself. So technically it isn't valid until after the
> rename patch was applied... which is against the patch ordering... Any
> creative idea on how to solve this?
One idea would be to start the patchset upfront with the renaming. This
will not introduce new bindings nor change any driver functionality, so
it should be ok. Then introduce the new bindings and continue with the
rest of implementation. I think this will be compliant with the DT doc
requirements and it'll probably silence checkpatch warnings like the one
below:

WARNING: DT compatible string "ti,bq24250" appears un-documented --
check ./Documentation/devicetree/bindings/

The only downside to this is that you'll have to rework the rest of the
patches to use the new prefixes... :/

laurentiu
