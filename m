From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/2] detect identical chip data arrays
Date: Sun, 8 Oct 2017 22:44:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710082243140.2160@hadrien>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <20171008203258.y7kqx7ipondxlsix@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cocci-bounces@systeme.lip6.fr>
In-Reply-To: <20171008203258.y7kqx7ipondxlsix@earth>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Liam Breck <liam@networkimprov.net>, Michal Marek <mmarek@suse.com>, pali.rohar@gmail.com, Joe Perches <joe@perches.com>, kbuild test robot <fengguang.wu@intel.com>, cocci@systeme.lip6.fr
List-Id: linux-pm@vger.kernel.org



On Sun, 8 Oct 2017, Sebastian Reichel wrote:

> Hi,
>
> On Sun, Oct 08, 2017 at 09:18:39PM +0200, Julia Lawall wrote:
> > Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warning
> > messages to indicate that some structures are the same, in response to
> > feedback from Liam Breck.
> >
> > Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, which
> > is not yet released, it actually works with the version currently available
> > on Github, eg from Coccinelle commit 3ba77b3a0f91.
>
> I think the rename makes sense, but I would expect the move to
> happen in one go with "git send-email -M", so that it detects the
> rename.

I'm not actually sure what is the status of the previous version.
Masahiro said applied, but I downloaded his tree and it was not there.  So
I thought this way would be easier.

julia
