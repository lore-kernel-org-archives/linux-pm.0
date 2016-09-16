From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] power: smb347-charger: Summit SMB345 charger IC
Date: Fri, 16 Sep 2016 08:31:38 -0500
Message-ID: <20160916133138.GA9399@rob-hp-laptop>
References: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
 <1473243615-29746-4-git-send-email-simhavcs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473243615-29746-4-git-send-email-simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 07, 2016 at 03:50:13PM +0530, Vinay Simha BN wrote:
> Summit microelectronics SMB345 charger chip added.
> 
> Cc: Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/power/supply/smb347_charger.txt       |  21 +++-

The binding should be combined with the previous patch.

>  drivers/power/supply/smb347-charger.c              | 123 ++++++++++-----------
>  2 files changed, 81 insertions(+), 63 deletions(-)
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
