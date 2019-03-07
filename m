From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Date: Wed, 6 Mar 2019 21:01:00 -0800
Message-ID: <20190307050100.GA44339@wrath>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.

Hi Lubomir,

Thanks for the recent Cc and pointer to here. In general, I have no
problem with the net changes. I do have some concerns from a
reviewability and change documentation perspective.

You document your intent above, but you also made several other changes
to get there which aren't documented, so when reviewing they stand out
as "why is this here?".

>From what I can tell, this change contains:

1) Cleanup of olpc_dt_interpret() calls to avoid splitting string
literals (noted in the patch history, but not called out as an
intentional change)

2) Refactoring of logic and breaking out the check for the compatible
property into olpc_dt_compatible_match

3) Addition of "we're running very old firmware if this is missing"
checks - I'm not sure how this relates to the stated problem and
the intended fix.

4) The addition of the xo1.5 compatible property.

All the other things makes it very difficult to determine if this patch
does what you describe - and only what you describe.

In general please:
a) Cleanup code
b) Refactor code
c) Change functionality

In that order - that way the new functionality is what show up when
someone does a git blame on the file (rather than a cleanup patch, which
isn't as useful in defect analysis).

And always document in your commit messages the approach you take to fix
the reported issue.

Thanks,


-- 
Darren Hart
VMware Open Source Technology Center
