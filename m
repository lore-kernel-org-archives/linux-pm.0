From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Thu, 05 Oct 2017 12:54:06 -0700
Message-ID: <1507233246.4434.44.camel@perches.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
                 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
                 <alpine.DEB.2.20.1710052113090.2626@hadrien>
                 <1507230959.4434.39.camel@perches.com>
                 <alpine.DEB.2.20.1710052116480.2626@hadrien>
         <1507231856.4434.41.camel@perches.com>
         <alpine.DEB.2.20.1710052138150.2626@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1710052138150.2626@hadrien>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-10-05 at 21:40 +0200, Julia Lawall wrote:
> On Thu, 5 Oct 2017, Joe Perches wrote:
> > btw: spatch 1.7 doesn't seem to have a tag in git
> > 
> > From the script:
> > 
> >     // Requires: 1.0.7
> > 
> > Assuming this is correct, then this doesn't even run today
> > except maybe on your system.
> 
> It runs on the current github version.  If you don't have the github
> version it will suffer from false negatives, but nothing will break.

fyi: there's no tag for 1.0.7 there either.

